import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart'; // Import the providers.dart file

class UserInformation extends ConsumerStatefulWidget {
  final PageController controller;

  const UserInformation({super.key, required this.controller});

  @override
  ConsumerState<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends ConsumerState<UserInformation> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    final userData = ref.read(userDataProvider);
    _nameController = TextEditingController(text: userData.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
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
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (value) {
                  userDataNotifier.updateName(value);
                },
              ),
              DropdownButtonFormField<String>(
                value: userData.gender.isEmpty ? null : userData.gender,
                decoration: const InputDecoration(labelText: 'Gender'),
                items:
                    ['Male', 'Female'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    userDataNotifier.updateGender(newValue);
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a gender';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: userData.ageGroup.isEmpty ? null : userData.ageGroup,
                decoration: const InputDecoration(labelText: 'Age Group'),
                items:
                    ['Below 18', '20-30', 'Above 30'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    userDataNotifier.updateAgeGroup(newValue);
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an age group';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
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
        ),
      ),
    );
  }
}
