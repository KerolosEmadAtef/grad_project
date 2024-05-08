import 'package:flutter/material.dart';
import 'package:test1/constants/colors.dart';

class HomeScreenTest extends StatelessWidget {
  final String? userName;
  HomeScreenTest({Key? key, this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Screen',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.highligtedTextColor,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text('WELCOME HOME $userName'),
            ],
          ),
        ],
      ),
    );
  }
}
