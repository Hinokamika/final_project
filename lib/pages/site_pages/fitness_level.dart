import 'package:flutter/material.dart';

class FitnessLevel extends StatelessWidget {
  const FitnessLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Fitness Level',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'Please select your fitness level:',
                  style: TextStyle(fontSize: 18),
                ),
                // Add your fitness level selection widgets here
              ],
            ),
          ),
        ),
      ),
    );
  }
}