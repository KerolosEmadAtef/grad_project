import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:test1/constants/colors.dart';
import 'package:test1/constants/variables.dart';

import '../widgets/app_buttons.dart';
import '../widgets/error_popup.dart';
import '../widgets/loading_indicator.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool _isLoading = false;
  bool _showError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.highligtedTextColor,
        title: const Text(
          'Just a test Screen✌',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isLoading = true;
                      });
                      Future.delayed(const Duration(seconds: 2), () {
                        setState(() {
                          _isLoading =
                              false; // Set loading state to false after delay
                        });
                      });
                      log('clicked!');
                    },
                    child: MainAppButtons(
                        textColor: AppColors.mainButtonsTextColor,
                        buttonColor: AppColors.mainButtonsColor,
                        borderColor: AppColors.mainButtonsColor,
                        text: 'Click me to show loading!'),
                  ),
                ),
                const SizedBox(
                  height: sizedBoxHeightSize,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        // Simulate an error (You can replace this with your actual error handling logic)
                        _showError = true;
                      });
                    },
                    child: MainAppButtons(
                        textColor: AppColors.mainButtonsTextColor,
                        buttonColor: AppColors.mainButtonsColor,
                        borderColor: AppColors.mainButtonsColor,
                        text: 'Click me to show error popup!'),
                  ),
                ),
              ],
            ),
          ),
          if (_showError)
            ErrorPopup(
              errorMessage: 'Something went wrong, please try again.',
              onClose: () {
                setState(() {
                  _showError =
                      false; // Close the error popup when tapped on 'OK'
                });
              },
            ),
        ],
      ),
    );
  }
}
