import 'package:calculator_app/calculator_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          titleSpacing: 152,
          // backgroundColor: Colors.lightBlue.shade100,
          title: const Text("Calculator",style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
            fontSize: 23
        ),),
          elevation: 0,
        ),

        body: const Calculator()
      ),
    );
  }
}
