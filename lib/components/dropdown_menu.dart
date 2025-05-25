import 'package:flutter/material.dart';

class DropBoxMenu extends StatefulWidget {
  final String? value;
  final String? labelText;
  final Function(String?)? validator;
  final Map<String, String> options;
  final ValueChanged<String?>? onChanged;

  const DropBoxMenu({
    super.key,
    required this.value,
    required this.labelText,
    required this.options,
    this.onChanged,
    this.validator,
  });

  @override
  State<DropBoxMenu> createState() => _DropBoxMenuState();
}

class _DropBoxMenuState extends State<DropBoxMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
      child: DropdownButtonFormField<String>(
        value: widget.value,
        decoration: InputDecoration(
          labelText: widget.labelText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black, width: 1),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
        ),
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(16),
        menuMaxHeight: 300,
        itemHeight: 50,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.red, size: 32),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        isExpanded: true,
        alignment: AlignmentDirectional.topStart,
        onChanged: widget.onChanged,
        items:
            widget.options.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 4.0,
                  ),
                  child: Text(
                    entry.value,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              );
            }).toList(),
        validator: (value) {
          return widget.validator != null ? widget.validator!(value) : null;
        },
        isDense: false,
      ),
    );
  }
}
