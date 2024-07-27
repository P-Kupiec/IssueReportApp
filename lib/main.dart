import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:myflutterapp/views/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.cameras});
  final List<CameraDescription> cameras;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: HomePage(cameras: cameras),
    );
  }
}
