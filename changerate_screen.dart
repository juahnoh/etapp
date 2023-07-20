import 'package:flutter/material.dart';
//아직 안만들어써요
class changeRate extends StatelessWidget {
  const changeRate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      backgroundColor: Colors.orange,
      title: Text('Change rate of tremor', style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}
