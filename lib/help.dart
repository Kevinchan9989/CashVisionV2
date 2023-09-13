import 'package:cashvisionv2/utils/colors.dart';
import 'package:flutter/material.dart';

class HelpDialog {
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
                      const Text(
                        'Help',
                        style: TextStyle(
                          color: AppColors.primaryColor2,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Welcome to the Cash Reader app\'s help section. We\'re here to assist you in using our app effectively. If you have any questions or encounter issues, please refer to the following resources or get in touch with our support team.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Contact Support:',
                        style: TextStyle(
                          color: AppColors.primaryColor2,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      ListTile(
                        leading: Icon(
                          Icons.email,
                          color: AppColors.primaryColor2,
                        ),
                        title: Text('Email Support'),
                        subtitle: Text('chanbg21@gmail.com'),
                        onTap: () {
                          // Add logic to open the user's email app with the support email pre-filled.
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.code,
                          color: AppColors.primaryColor2,
                        ),
                        title: Text('GitHub Repository'),
                        subtitle: Text('https://github.com/Kevinchan9989'),
                        onTap: () {
                          // Add logic to open the user's web browser with the GitHub repository link.
                        },
                      ),
                      // Add more help sections and resources as needed.
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
