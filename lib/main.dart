import 'package:custom_stepper_withoutpgview/package/presentation/custom_stepper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CustomStepper(steps: [
        AddStep(
            title: 'info',
            content: Container(width: 100, height: 50, color: Colors.amber)),
        AddStep(
            title: 'info',
            content: Container(width: 100, height: 50, color: Colors.amber)),
        AddStep(
            title: 'info',
            content: Container(width: 100, height: 50, color: Colors.amber)),
        AddStep(
            title: 'info',
            content: Container(width: 100, height: 50, color: Colors.amber)),
        AddStep(
            title: 'info',
            content: Container(width: 100, height: 50, color: Colors.amber)),
        AddStep(
            title: 'info',
            content: Container(width: 100, height: 50, color: Colors.amber)),
      ]),
    );
  }
}
