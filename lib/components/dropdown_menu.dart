import 'package:flutter/material.dart';

class DropBoxMenu extends StatefulWidget {
  final String? value;
  final String? labelText;
  final Map<String, String> options;
  final ValueChanged<String?>? onChanged;

  const DropBoxMenu({
    super.key,
    required this.value,
    required this.labelText,
    required this.options,
    this.onChanged,
  });

  @override
  State<DropBoxMenu> createState() => _DropBoxMenuState();
}

class _DropBoxMenuState extends State<DropBoxMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
      child: DropdownButtonFormField<String>(
        value: widget.value,
        decoration: InputDecoration(
          labelText: widget.labelText,
          filled: true, // Enable fill color
          fillColor: Colors.white, // Set background to white
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black, width: 1),
          ),
        ),
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(12),
        menuMaxHeight: 300,
        itemHeight: 50,
        onChanged: widget.onChanged,
        items:
            widget.options.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(
                  entry.value,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select an option';
          }
          return null;
        },
      ),
    );
  }
}
