import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart'; // Import the providers.dart file

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
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Health Goal',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                value:
                    userData.primaryHealthGoal.isEmpty
                        ? null
                        : userData.primaryHealthGoal,
                decoration: const InputDecoration(
                  labelText: 'Primary Health Goal',
                ),
                items:
                    ['Weight Loss', 'Muscle Gain', 'Maintain Weight'].map((
                      String value,
                    ) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    userDataNotifier.updatePrimaryHealthGoal(newValue);
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a health goal';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value:
                    userData.fitnessGoal.isEmpty ? null : userData.fitnessGoal,
                decoration: const InputDecoration(
                  labelText: 'Specific Fitness Goals',
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
                    userDataNotifier.updateFitnessGoal(newValue);
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an option';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Additional Notes',
                ),
                onChanged: (value) {
                  userDataNotifier.updateAdditionalNotes(value);
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      widget.controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    child: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
