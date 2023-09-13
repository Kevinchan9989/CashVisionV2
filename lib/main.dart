import 'package:cashvisionv2/text2speech.dart';
import 'package:cashvisionv2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'splash_screen.dart';

List<CameraDescription>? cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TextToSpeech.initTTS();
  cameras = await availableCameras();
  // Disable auto-rotate and force portrait orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CashVisionV2',
      theme: ThemeData(
        primarySwatch: MaterialColor(AppColors.primaryColor2.value, const {
          50: AppColors.primaryColor2,
          100: AppColors.primaryColor2,
          200: AppColors.primaryColor2,
          300: AppColors.primaryColor2,
          400: AppColors.primaryColor2,
          500: AppColors.primaryColor2,
          600: AppColors.primaryColor2,
          700: AppColors.primaryColor2,
          800: AppColors.primaryColor2,
          900: AppColors.primaryColor2,
        }),
      ),
      home: SplashScreen(),
    );
  }
}
