import 'package:flutter/material.dart';
import 'package:cashvisionv2/text2speech.dart';
import 'package:cashvisionv2/about_page.dart';
import 'package:cashvisionv2/help.dart';
import 'package:cashvisionv2/utils/colors.dart';

class SettingsPage extends StatefulWidget {
  final String selectedLanguage;
  final String selectedSpeed;
  final bool displayConfidence;

  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<String> onSpeedChanged;
  final ValueChanged<bool> onDisplayConfidenceChanged;

  const SettingsPage({
    Key? key,
    required this.selectedLanguage,
    required this.selectedSpeed,
    required this.displayConfidence,
    required this.onLanguageChanged,
    required this.onSpeedChanged,
    required this.onDisplayConfidenceChanged,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late String _selectedLanguage;
  late String _selectedSpeed;
  late bool _displayConfidence;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.selectedLanguage;
    _selectedSpeed = widget.selectedSpeed;
    _displayConfidence = widget.displayConfidence;
  }

  void _updateLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
  }

  void _updateSpeed(String speed) {
    setState(() {
      _selectedSpeed = speed;
    });
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption('English', 'en-US', context),
              _buildLanguageOption('Malay', 'ms-MY', context),
              _buildLanguageOption('Chinese', 'cmn-CN', context),
              _buildLanguageOption('Tamil', 'ta-IN', context),
            ],
          ),
        );
      },
    );
  }

  void _showSpeedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: Text('Select Voice Speed'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildSpeedOption(context, 0.3, 'Slow'),
              _buildSpeedOption(context, 0.5, 'Default'),
              _buildSpeedOption(context, 0.7, 'Fast'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(
      String label, String value, BuildContext context) {
    return ListTile(
      title: Text(label),
      onTap: () {
        _updateLanguage(value);
        widget.onLanguageChanged(value); // Notify the parent of the change
        Navigator.of(context).pop(); // Close the dialog
      },
    );
  }

  Widget _buildSpeedOption(BuildContext context, double rate, String label) {
    return ListTile(
      title: Text(label),
      onTap: () {
        _updateSpeed(label);
        widget.onSpeedChanged(label);
        Navigator.of(context).pop();
        TextToSpeech.setRate(rate);
        setState(() {
          _selectedSpeed = label;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: AppColors.accentColor3,
          ),
        ),
      ),
      body: Container(
        color: AppColors.accentColor2,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: const Text(
                  'Language & Region',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.language,
                  color: Colors.blueGrey.shade300,
                ),
                title: Text(
                  'Language',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  'Selected Language: $_selectedLanguage',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                onTap: () {
                  _showLanguageDialog(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: const Text(
                  'Voice & Display Settings',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.volume_up,
                  color: Colors.blueGrey.shade300,
                ),
                title: Text(
                  'Voice Speed',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  'Selected Speed: $_selectedSpeed',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                onTap: () {
                  _showSpeedDialog(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.stars,
                  color: Colors.blueGrey.shade300,
                ),
                title: Text(
                  'Display Confidence',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  'Display Confidence Level',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                trailing: Switch(
                  value: _displayConfidence,
                  onChanged: (value) {
                    setState(() {
                      _displayConfidence = value;
                    });
                    widget.onDisplayConfidenceChanged(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: const Text(
                  'Help & Support',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.info_outline,
                  color: Colors.blueGrey.shade300,
                ),
                title: Text(
                  'About',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                onTap: () {
                  AboutDialogBox.show(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.help_outline,
                  color: Colors.blueGrey.shade300,
                ),
                title: Text(
                  'Help',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  HelpDialog.show(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
