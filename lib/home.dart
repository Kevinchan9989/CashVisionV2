import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cashvisionv2/settings_page.dart';
import 'package:cashvisionv2/text2speech.dart';
import 'package:cashvisionv2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter/services.dart';
import './main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CameraController? cameraController;
  String output = '';
  File? capturedImage;
  bool isProcessing = false;
  String selectedLanguage = "en-US"; // Default language is en-UK
  String selectedSpeed = "Default";
  bool displayConfidence = true; // You can set a default value here

  @override
  void initState() {
    super.initState();
    loadCamera();
    loadModel();
    TextToSpeech.speak("Please tap anywhere on the screen to detect.");
  }

  void _handleLanguageChanged(String language) {
    setState(() {
      selectedLanguage = language;
      TextToSpeech.setLanguage(language); // Update text-to-speech language
    });
  }

  void _handleSpeedChanged(String speed) {
    setState(() {
      selectedSpeed = speed;
    });
  }

  String _getLanguage() {
    return selectedLanguage;
  }

  // Function to toggle the displayConfidence state
  void toggleDisplayConfidence(bool value) {
    setState(() {
      displayConfidence = value;
    });
  }

  loadCamera() {
    cameraController = CameraController(
      cameras![0],
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((imageStream) {
            // Unused camera stream
          });
        });
      }
    });
  }

  void captureAndRunModel() async {
    if (cameraController != null && cameraController!.value.isInitialized) {
      setState(() {
        capturedImage = null;
        isProcessing = true;
        output = '';
      });

      await cameraController!.setFlashMode(FlashMode.auto); // Turn off flash
      await cameraController!
          .setFocusMode(FocusMode.locked); // Set locked focus mode
      await cameraController!
          .setExposureMode(ExposureMode.auto); // Set auto exposure mode

      final XFile? photo = await cameraController!.takePicture();
      if (photo != null) {
        runModelOnPhoto(File(photo.path));
      }
    }
  }

  Future<void> runModelOnPhoto(File photoFile) async {
    final predictions = await Tflite.runModelOnImage(
      path: photoFile.path,
      imageMean: 112,
      imageStd: 112,
      numResults: 2,
      threshold: 0.4,
    );

    setState(() {
      capturedImage = photoFile;
      isProcessing = false;

      if (predictions != null && predictions.isNotEmpty) {
        output = predictions[0]['label'];
        double confidence =
            predictions[0]['confidence']; // Extract confidence level

        if (displayConfidence) {
          output += '\nConfidence: ${(confidence * 100).toStringAsFixed(2)}%';
        }

        TextToSpeech.speak(output);

        if (displayConfidence) {
          HapticFeedback.vibrate();
        }
      } else {
        output = 'No prediction found';
        TextToSpeech.speak(output);
      }
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/cashcointest32.tflite",
      labels: "assets/labels2.txt",
    );
  }

  void _openSettingsPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsPage(
          onLanguageChanged: _handleLanguageChanged,
          onSpeedChanged: _handleSpeedChanged,
          selectedSpeed: selectedSpeed,
          selectedLanguage: selectedLanguage,
          displayConfidence: displayConfidence, // Pass the state
          onDisplayConfidenceChanged:
              toggleDisplayConfidence, // Pass the function
        ),
      ),
    );
  }

  Color _getTextColor(String output) {
    if (output.contains('1 Ringgit Malaysia')) {
      return AppColors.c1;
    } else if (output.contains('10 Ringgit Malaysia')) {
      return AppColors.c10;
    } else if (output.contains('100 Ringgit Malaysia')) {
      return AppColors.c100;
    } else if (output.contains('5 Ringgit Malaysia')) {
      return AppColors.c5;
    } else if (output.contains('50 Ringgit Malaysia')) {
      return AppColors.c50;
    } else if (output.contains('20 Ringgit Malaysia')) {
      return AppColors.c20;
    } else {
      return Colors.white70;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.remove_red_eye,
          color: AppColors.accentColor3,
        ), // Eye icon as leading widget
        title: Text(
          'CashVisionV2',
          style: TextStyle(
            color: AppColors.accentColor3,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: AppColors.accentColor3,
            ),
            onPressed: _openSettingsPage,
          ),
        ],
      ),
      body: GestureDetector(
        onDoubleTap: isProcessing ? null : captureAndRunModel,
        onTap: isProcessing ? null : captureAndRunModel,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6875,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  capturedImage != null
                      ? Image.file(capturedImage!)
                      : CameraPreview(cameraController!),
                  if (isProcessing)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: AppColors
                    .primaryColor2, // Background color for remaining space
                child: Center(
                  child: Text(
                    output,
                    style: TextStyle(
                      color: _getTextColor(output),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
