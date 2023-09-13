import 'dart:async';
import 'package:flutter/material.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Set a timer for 1 second
    Timer(Duration(seconds: 1), () {
      // After 1 second, navigate to your main screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Home(), // Replace with your main screen
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).primaryColor, // Use your primary color here
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.remove_red_eye,
              size: 100, // Adjust the size as needed
              color: Colors.white, // Change to your desired color
            ),
            SizedBox(height: 16), // Add some spacing between the icon and text
            Text(
              'CashVisionV2',
              style: TextStyle(
                color: Colors.white, // Change to your desired text color
                fontSize: 24, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // Adjust the font weight as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
