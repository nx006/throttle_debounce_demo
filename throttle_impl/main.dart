import 'dart:async';

typedef VoidCallback = void Function();

class Throttle {
  final Function callback;
  final Duration wait;

  final bool leading;
  final bool trailing;

  Timer? _timeout;
  List<dynamic>? _lastCallArgs;

  Throttle({
    required this.callback,
    required this.wait,
    this.leading = true,
    this.trailing = true,
  });

  void later() {
    if (trailing && _lastCallArgs != null) {
      Function.apply(callback, _lastCallArgs!);
      _lastCallArgs = null;
      _timeout = Timer(wait, later);
    } else {
      _timeout = null;
    }
  }

  void call(List<dynamic> args) {
    if (_timeout != null) {
      _lastCallArgs = args;
      return;
    }
    if (leading) {
      Function.apply(callback, args);
    } else {
      _lastCallArgs = args;
    }
    _timeout = Timer(wait, later);
  }
}

void testThrottle(bool leading, bool trailing) {
  final startTime = DateTime.now();
  final events = {
    const Duration(milliseconds: 0): 'A',
    const Duration(milliseconds: 7): 'B',
    const Duration(milliseconds: 12): 'C',
    const Duration(milliseconds: 22): 'D',
    const Duration(milliseconds: 25): 'E',
    const Duration(milliseconds: 45): 'F',
  };

  final throttled = Throttle(
    callback: (String arg) {
      final givenTime = events.entries.firstWhere((e) => e.value == arg).key;
      final passedTime = DateTime.now().difference(startTime);
      print(
          '$arg\t${givenTime.inMilliseconds}ms\t${passedTime.inMilliseconds}ms');
    },
    wait: const Duration(milliseconds: 10),
    leading: leading,
    trailing: trailing,
  );

  events.forEach((duration, event) {
    Timer(duration, () => throttled.call([event]));
  });
}

void main() {
  print("Scenario: leading == true && trailing == true");
  print('event | givenTime | actualTime');
  testThrottle(true, true);
  Timer(const Duration(milliseconds: 60), () {
    print("\nScenario: leading == false && trailing == true");
    testThrottle(false, true);
    Timer(const Duration(milliseconds: 60), () {
      print("\nScenario: leading == true && trailing == false");
      testThrottle(true, false);
    });
  });
}
