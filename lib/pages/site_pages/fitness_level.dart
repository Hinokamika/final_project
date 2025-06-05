import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/provider/user_details_provider.dart';

class FitnessLevel extends ConsumerStatefulWidget {
  final PageController controller;

  const FitnessLevel({super.key, required this.controller});

  @override
  ConsumerState<FitnessLevel> createState() => _FitnessLevelState();
}

class _FitnessLevelState extends ConsumerState<FitnessLevel> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider);
    final userDataNotifier = ref.watch(userDataProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Fitness Level',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              DropdownButtonFormField<String>(
                                value:
                                    userData.exerciseStatus.isEmpty
                                        ? null
                                        : userData.exerciseStatus,
                                decoration: const InputDecoration(
                                  labelText: 'Exercise Status',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                items:
                                    [
                                      'Yes (I exercise regularly)',
                                      'No (I do not exercise regularly)',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    userDataNotifier.updateExerciseStatus(
                                      newValue,
                                    );
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select an exercise status';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              if (userData.exerciseStatus ==
                                  'Yes (I exercise regularly)')
                               DropdownButtonFormField<String>(
                                value:
                                    userData.fitnessLevel.isEmpty
                                        ? null
                                        : userData.fitnessLevel,
                                decoration: const InputDecoration(
                                  labelText: 'Fitness Level',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                items:
                                    [
                                      'Beginner (little to no experience)',
                                      'Intermediate (some experience)',
                                      'Advanced (more than 5 years)',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    userDataNotifier.updateFitnessLevel(
                                      newValue,
                                    );
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a fitness level';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              if (userData.exerciseStatus ==
                                  'Yes (I exercise regularly)')
                                TextFormField(
                                  initialValue: userData.exerciseFrequency,
                                  decoration: const InputDecoration(
                                    labelText: 'Exercise Frequency',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    userDataNotifier.updateExerciseFrequency(
                                      value,
                                    );
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your exercise frequency';
                                    }
                                    return null;
                                  },
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 20,
                      left: 0,
                      child: FloatingActionButton(
                        onPressed: () {
                          widget.controller.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        backgroundColor: const Color(0xFFFF3333),
                        tooltip: 'Back',
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.white, width: 2),
                        ),
                        elevation: 5,
                        child: const Icon(
                          Icons.arrow_back,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 0,
                      child: FloatingActionButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                        backgroundColor: const Color(0xFFFF3333),
                        tooltip: 'Next',
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.white, width: 2),
                        ),
                        elevation: 5,
                        child: const Icon(
                          Icons.arrow_forward,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
