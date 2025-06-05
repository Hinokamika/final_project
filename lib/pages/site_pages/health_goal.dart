import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/provider/user_details_provider.dart';

class HealthGoal extends ConsumerStatefulWidget {
  final PageController controller;

  const HealthGoal({super.key, required this.controller});

  @override
  ConsumerState<HealthGoal> createState() => _HealthGoalState();
}

class _HealthGoalState extends ConsumerState<HealthGoal> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    final userData = ref.read(userDataProvider);
    _notesController = TextEditingController(text: userData.additionalNotes);
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

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
                          'Health Goal',
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
                                    userData.primaryHealthGoal.isEmpty
                                        ? null
                                        : userData.primaryHealthGoal,
                                decoration: const InputDecoration(
                                  labelText: 'Primary Health Goal',
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
                                      'Weight Loss',
                                      'Muscle Gain',
                                      'Maintain Weight',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    userDataNotifier.updatePrimaryHealthGoal(
                                      newValue,
                                    );
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a health goal';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30),
                              DropdownButtonFormField<String>(
                                value:
                                    userData.fitnessGoal.isEmpty
                                        ? null
                                        : userData.fitnessGoal,
                                decoration: const InputDecoration(
                                  labelText: 'Specific Fitness Goals',
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
                                    ['Yes', 'No'].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    userDataNotifier.updateFitnessGoal(
                                      newValue,
                                    );
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select an option';
                                  }
                                  return null;
                                },
                              ),
                              if (userData.fitnessGoal == 'Yes') ...[
                                const SizedBox(height: 30),
                                TextFormField(
                                  controller: _notesController,
                                  decoration: const InputDecoration(
                                    labelText: 'Additional Notes',
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
                                    userDataNotifier.updateAdditionalNotes(
                                      value,
                                    );
                                  },
                                ),
                              ],
                              const SizedBox(height: 20),
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
