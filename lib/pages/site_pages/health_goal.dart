import 'package:flutter/material.dart';

class HealthGoal extends StatelessWidget {
  const HealthGoal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Padding(padding: EdgeInsets.all(10), child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Center(
          child: Text(
            'Health Goal',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      )),
    );
  }
}