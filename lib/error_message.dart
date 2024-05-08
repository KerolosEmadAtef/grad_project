import 'package:flutter/material.dart';

void _showErrorPopup(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Oops!'),
        content: Text(errorMessage + ', Please try again!'),
        backgroundColor: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'))
        ],
      );
    },
  );
}
