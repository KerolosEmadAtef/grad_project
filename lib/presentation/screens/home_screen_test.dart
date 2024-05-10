import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/constants/colors.dart';

import '../../business_logic/cubit/auth_cubit.dart';

class HomeScreenTest extends StatelessWidget {
  final String? userName;
  // ignore: prefer_const_constructors_in_immutables, use_super_parameters
  HomeScreenTest({Key? key, this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text(
          'Home Screen',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ), // Icon for the logout button
            onPressed: () {
              // Call the logout method from the AuthCubit
              context.read<AuthCubit>().signOut();
            },
          ),
        ],
        centerTitle: true,
        backgroundColor: AppColors.highligtedTextColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('WELCOME HOME 👋🏻',
                  style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue[600])),
            ],
          ),
        ],
      ),
    );
  }
}
