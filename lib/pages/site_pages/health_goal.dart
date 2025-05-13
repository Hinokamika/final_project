import 'package:final_project/components/dropdown_menu.dart';
import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();
String? _specificDietState;
String? _fitnessGoalState;

class HealthGoal extends StatefulWidget {
  final PageController controller;
  const HealthGoal({super.key, required this.controller});

  @override
  State<HealthGoal> createState() => _HealthGoalState();
}

class _HealthGoalState extends State<HealthGoal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Main Content
          Padding(
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
                          'Health Goal',
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
                                labelText: 'What is your primary health goal?',
                                value: _specificDietState,
                                options: {
                                  'weight_loss': 'Weight Loss',
                                  'muscle_gain': 'Muscle Gain',
                                  'maintain_weight': 'Maintain Weight',
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'PLease select your health goal';
                                  }
                                },
                                onChanged: (String? value) {
                                  setState(() {
                                    _specificDietState = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 30),
                              DropBoxMenu(
                                labelText:
                                    'Do you have any specific fitness goals?',
                                value: _fitnessGoalState,
                                options: {'yes': 'Yes ', 'no': 'No '},
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'PLease select your option!';
                                  }
                                },
                                onChanged: (String? value) {
                                  setState(() {
                                    _fitnessGoalState = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Additional Notes',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
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

          // Back Button (Left FAB)
          Positioned(
            left: 40,
            bottom: 40,
            child: FloatingActionButton(
              onPressed: () {
                widget.controller.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              backgroundColor: Colors.grey,
              tooltip: 'Go Back',
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.white, width: 2),
              ),
              elevation: 5,
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ],
      ),

      // Submit Button (Right FAB)
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              print('Specific Diet: $_specificDietState');
              print('Fitness Goal: $_fitnessGoalState');
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
          child: const Icon(Icons.arrow_forward, size: 25, color: Colors.white),
        ),
      ),
    );
  }
}
