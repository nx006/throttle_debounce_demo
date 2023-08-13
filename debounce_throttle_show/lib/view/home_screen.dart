import 'package:debounce_throttle_show/component/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:debounce_throttle/debounce_throttle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String generalText = '';
  String debounceText = '';
  String throttleText = '';
  int generalCount = 0;
  int debounceCount = 0;
  int throttleCount = 0;

  final debouncer = Debouncer<String>(
    const Duration(seconds: 1),
    initialValue: '',
    checkEquality: false,
  );

  final throttler = Throttle<String>(
    const Duration(seconds: 1),
    initialValue: '',
    checkEquality: false,
  );

  @override
  void initState() {
    super.initState();

    debouncer.values.listen((event) {
      setState(() {
        debounceText = event;
        debounceCount++;
      });
    });

    throttler.values.listen((event) {
      setState(() {
        throttleText = event;
        throttleCount++;
      });
    });
  }

  setGeneralText(String value) {
    setState(() {
      generalText = value;
      generalCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '일반 결과',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomTextFormField(
              onChanged: (value) {
                setGeneralText(value);
              },
            ),
            buildResultTextBox(
              value: generalText,
              count: generalCount,
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Debounce',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomTextFormField(
              onChanged: (value) {
                debouncer.setValue(value);
              },
            ),
            buildResultTextBox(
              value: debounceText,
              count: debounceCount,
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Throttle',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomTextFormField(
              onChanged: (value) {
                throttler.setValue(value);
              },
            ),
            buildResultTextBox(
              value: throttleText,
              count: throttleCount,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResultTextBox({required String value, required int count}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            '결과: $value',
            style: const TextStyle(
              fontSize: 18.0,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          '$count',
          style: const TextStyle(
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }
}
