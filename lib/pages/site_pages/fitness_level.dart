import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart'; // Import the providers.dart file

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
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Fitness Level',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                value:
                    userData.fitnessLevel.isEmpty
                        ? null
                        : userData.fitnessLevel,
                decoration: const InputDecoration(labelText: 'Fitness Level'),
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
                    userDataNotifier.updateFitnessLevel(newValue);
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a fitness level';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value:
                    userData.exerciseStatus.isEmpty
                        ? null
                        : userData.exerciseStatus,
                decoration: const InputDecoration(labelText: 'Exercise Status'),
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
                    userDataNotifier.updateExerciseStatus(newValue);
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
