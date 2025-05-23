import 'package:final_project/components/dropdown_menu.dart';
import 'package:flutter/material.dart';

class UserInformation extends StatefulWidget {
  final PageController controller;
  const UserInformation({super.key, required this.controller});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final _formKey = GlobalKey<FormState>();
  String? _genderOption;
  String? _ageGroupOption;
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: [
                    const Text(
                      'User Information',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),
                            DropBoxMenu(
                              labelText: 'What is your gender?',
                              value: _genderOption,
                              options: {'male': 'Male', 'female': 'Female'},
                              onChanged: (String? value) {
                                setState(() {
                                  _genderOption = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select your gender';
                                }
                              },
                            ),
                            const SizedBox(height: 30),
                            DropBoxMenu(
                              labelText: 'Age Group',
                              value: _ageGroupOption,
                              options: {
                                'below 18': 'Below 18',
                                '20-30': '20-30',
                                'above 30': 'Above 30',
                              },
                              onChanged: (String? value) {
                                setState(() {
                                  _ageGroupOption = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'PLease select your age group';
                                }
                              },
                            ),
                          ],
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 20),
        child: FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              print('Name: ${_nameController.text}');
              print('Gender: $_genderOption');
              print('Age Group: $_ageGroupOption');
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
