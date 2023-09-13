import 'package:flutter/material.dart';

class AboutDialogBox {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Icon(
                          Icons.remove_red_eye, // Change to the eye icon
                          color: Theme.of(context)
                              .primaryColor, // Use the primary theme color
                          size: 100,
                        ),
                      ),
                      SizedBox(height: 16),
                      const Text(
                        'Cash Vision V2', // Replace with your app's name
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      const Text(
                        'Version 1.0.0', // Replace with your app's version
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      const Text(
                        'Developed by Github: Kevinchan9989', // Replace with your company name
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Description: Cash Vision V2 is your trusted companion to empower the visually impaired. Our app uses cutting-edge technology to help users confidently recognize the denominations of both cash and coins. Seamlessly navigate the world of currency with audio assistance, providing independence and accessibility to those who need it most. Experience the future of currency recognition with Cash Vision V2.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      SizedBox(height: 16),
                      const Text(
                        'Contact me at chanbg21@gmail.com', // Replace with your contact information
                        textAlign: TextAlign.center,
                      ),
                      ListTile(
                        leading: Icon(Icons.play_arrow_rounded,
                            color: Theme.of(context).primaryColor),
                        title: const Text(
                          'Available on Google Play', // Replace with the link to Google Play
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
