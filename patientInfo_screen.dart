import 'package:flutter/material.dart';

class patientInfo extends StatefulWidget {
  const patientInfo({super.key});

  @override
  State<patientInfo> createState() => _patientInfoState();
}

class _patientInfoState extends State<patientInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Edit patient information', style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}
