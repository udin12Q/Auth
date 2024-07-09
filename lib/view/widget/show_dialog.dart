import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showCustomDialog(BuildContext context,
    {required IconData icon,
    required String title,
    required String content,
    required Color color}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Text(title),
        ],
      ),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
