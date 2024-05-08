import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test1/google_signin.dart';

class HomePage extends StatefulWidget {
  final GoogleSignInAccount? user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // pading constants
  final double horizontalPadding = 20.0;
  final double vertiaclPadding = 20.0;

  // list of smart devices
  List mySmartDevices = [
    //[smartDeviceName, iconPath, powerStatus]
    ['Smart Light', 'lib/icons/light-bulb.png', 'true'],
    ['Smart AC', 'lib/icons/air-conditioner.png', 'false'],
    ['Smart TV', 'lib/icons/smart-tv.png', 'false'],
    ['Smart Fan', 'lib/icons/fan.png', 'false'],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //custom app bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: vertiaclPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //menu icon
                  Image.asset(
                    'lib/icons/menu.png',
                    height: 45,
                    color: Colors.grey[800],
                  ),
                  Icon(
                    Icons.person,
                    size: 45,
                    color: Colors.grey[800],
                  ),
                  GestureDetector(
                    onTap: () {
                      GoogleSignInApi.logout(); // Call the logout function
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.logout_outlined,
                    ),
                  ),
                  //account icon
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            // welcome home
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Home,',
                  ),
                  Text(
                    'Ahmed',
                    style: TextStyle(fontSize: 40.0),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 20.0,
            ),

            //smart devices + grid

            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text('Smart Devices'),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text('User Authentication Token:'),
            ),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            //   child: Text('$authToken'),
            // ),

            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: mySmartDevices.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
