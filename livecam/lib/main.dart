import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Camera App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CameraController? _camera;
  bool _cameraInitialized = false;
  CameraImage? _savedImage;

  void _initializeCamera() async {
    // Get list of cameras of the device
    List<CameraDescription> cameras = await availableCameras();
    // Create the CameraController
    _camera = CameraController(cameras[0], ResolutionPreset.veryHigh);
    // Initialize the CameraController
    _camera!.initialize().then((_) async {
      // Start ImageStream
      await _camera!
          .startImageStream((CameraImage image) => _processCameraImage(image));
      setState(() {
        _cameraInitialized = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _processCameraImage(CameraImage image) async {
    setState(() {
      _savedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: (_cameraInitialized)
              ? AspectRatio(
                  aspectRatio: _camera!.value.aspectRatio,
                  child: CameraPreview(_camera!),
                )
              : const CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.camera_alt),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

/////////////////////////////////////////


