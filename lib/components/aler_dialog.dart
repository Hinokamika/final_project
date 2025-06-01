import 'package:flutter/material.dart';

class DialogCustom extends StatelessWidget {
  final String title;
  final String content;
  final String confirmButtonText;
  final String cancelButtonText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const DialogCustom({
    super.key,
    required this.title,
    required this.content,
    required this.confirmButtonText,
    required this.cancelButtonText,
    this.onConfirm,
    this.onCancel,
  });

  // Method to show the dialog
  Future<void> show(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onCancel != null) onCancel!();
          },
          child: Text(cancelButtonText),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onConfirm != null) onConfirm!();
          },
          child: Text(confirmButtonText),
        ),
      ],
    );
  }
}
