// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
//
// class CameraScreen extends StatefulWidget {
//   const CameraScreen({super.key});
//
//   @override
//   CameraScreenState createState() => CameraScreenState();
// }
//
// class CameraScreenState extends State<CameraScreen> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     // To display the current output from the Camera,
//     // create a CameraController.
//     _controller = CameraController(cameras[0],
//       // Define the resolution to use.
//       ResolutionPreset.medium,
//     );
//
//     // Next, initialize the controller. This returns a Future.
//     _initializeControllerFuture = _controller.initialize();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(children: [
//         FutureBuilder(future: _initializeControllerFuture, builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return SizedBox(
//               height: MediaQuery.of(context).size.height,
//               child: CameraPreview(_controller));
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         }
//       ],),
//     )
//   }
// }