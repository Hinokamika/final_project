import 'package:final_project/components/dropdown_menu.dart';
import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class FitnessLevel extends StatefulWidget {
  final PageController controller;
  const FitnessLevel({super.key, required this.controller});

  @override
  State<FitnessLevel> createState() => _FitnessLevelState();
}

class _FitnessLevelState extends State<FitnessLevel> {
  String? _fitnessLevelState;
  String? _exerciseState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Fitness Level',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          DropBoxMenu(
                            labelText: 'How would you rate your fitness level?',
                            value: _fitnessLevelState,
                            options: {
                              'beginner': 'Beginner (little to no experience)',
                              'intermediate': 'Intermediate (some experience)',
                              'advanced': 'Advanced (more than 5 years)',
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'PLease select your fitness level';
                              }
                            },
                            onChanged: (String? value) {
                              setState(() {
                                _fitnessLevelState = value;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          DropBoxMenu(
                            labelText: 'Do you currently exercise?',
                            value: _exerciseState,
                            options: {
                              'yes': 'Yes (I exercise regularly)',
                              'no': 'No (I do not exercise regularly)',
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'PLease select your exercise status';
                              }
                            },
                            onChanged: (String? value) {
                              setState(() {
                                _exerciseState = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              print('Level State: $_fitnessLevelState');
              print('Exercise State: $_exerciseState');
              widget.controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          backgroundColor: const Color(0xFFFF3333),
          tooltip: 'Submit',
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.white, width: 2),
          ),
          elevation: 5,
          child: const Icon(Icons.send, size: 25, color: Colors.white),
        ),
      ),
    );
  }
}
