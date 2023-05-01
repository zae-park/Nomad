import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as imglib;

typedef convert_func = Pointer<Uint32> Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, Int32, Int32, Int32, Int32);
typedef Convert = Pointer<Uint32> Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, int, int, int, int);

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
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CameraController? _camera;
  bool _cameraInitialized = false;
  CameraImage? _savedImage;
  late imglib.Image lateImg;
  bool picked = false;
  Future<CameraImage>? lateCamImg;

  StreamController myStreamController = StreamController();

  final DynamicLibrary convertImageLib = Platform.isAndroid
      ? DynamicLibrary.open("libconvertImage.so")
      : DynamicLibrary.process();
  late Convert conv;

  @override
  void initState() {
    super.initState();
    // Load the convertImage() function from the library
    conv = convertImageLib
        .lookup<NativeFunction<convert_func>>('convertImage')
        .asFunction<Convert>();

    _initializeCamera();
  }

  void _initializeCamera() async {
    // Get list of cameras of the device
    List<CameraDescription> cameras = await availableCameras();

    // Create the CameraController
    _camera = CameraController(cameras[0], ResolutionPreset.veryHigh);
    _camera!.initialize().then((_) async {
      // Start ImageStream
      await _camera!
          .startImageStream((CameraImage image) => _processCameraImage(image));
      setState(() {
        _cameraInitialized = true;
      });
    });
    myStreamController.stream.listen((camImg) {
      lateCamImg = camImg;
    });
  }

  void _processCameraImage(CameraImage image) async {
    setState(() {
      _savedImage = image;
    });
  }

  imglib.Image converting(CameraImage pic) {
    // Allocate memory for the 3 planes of the image
    Pointer<Uint8> p = malloc(pic.planes[0].bytes.length);
    Pointer<Uint8> p1 = malloc(pic.planes[1].bytes.length);
    Pointer<Uint8> p2 = malloc(pic.planes[2].bytes.length);

    // Assign the planes data to the pointers of the image
    Uint8List pointerList = p.asTypedList(pic.planes[0].bytes.length);
    Uint8List pointerList1 = p1.asTypedList(pic.planes[1].bytes.length);
    Uint8List pointerList2 = p2.asTypedList(pic.planes[2].bytes.length);
    pointerList.setRange(0, pic.planes[0].bytes.length, pic.planes[0].bytes);
    pointerList1.setRange(0, pic.planes[1].bytes.length, pic.planes[1].bytes);
    pointerList2.setRange(0, pic.planes[2].bytes.length, pic.planes[2].bytes);

    // Call the convertImage function and convert the YUV to RGB
    Pointer<Uint32> imgP = conv(p, p1, p2, pic.planes[1].bytesPerRow,
        pic.planes[1].bytesPerPixel!, pic.width, pic.height);
    // Get the pointer of the data returned from the function to a List
    List<int> imgData = imgP.asTypedList((pic.width * pic.height));

    // Generate image from the converted data
    imglib.Image img = imglib.Image.fromBytes(
        height: pic.height,
        width: pic.width,
        bytes: Uint8List.fromList(imgData).buffer);

    // Free the memory space allocated
    // from the planes and the converted data
    malloc.free(p);
    malloc.free(p1);
    malloc.free(p2);
    malloc.free(imgP);

    return img;
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
            : const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Pointer<Uint8> p = malloc(_savedImage!.planes[0].bytes.length);
          Pointer<Uint8> p1 = malloc(_savedImage!.planes[1].bytes.length);
          Pointer<Uint8> p2 = malloc(_savedImage!.planes[2].bytes.length);

          // Assign the planes data to the pointers of the image
          Uint8List pointerList =
              p.asTypedList(_savedImage!.planes[0].bytes.length);
          Uint8List pointerList1 =
              p1.asTypedList(_savedImage!.planes[1].bytes.length);
          Uint8List pointerList2 =
              p2.asTypedList(_savedImage!.planes[2].bytes.length);
          pointerList.setRange(0, _savedImage!.planes[0].bytes.length,
              _savedImage!.planes[0].bytes);
          pointerList1.setRange(0, _savedImage!.planes[1].bytes.length,
              _savedImage!.planes[1].bytes);
          pointerList2.setRange(0, _savedImage!.planes[2].bytes.length,
              _savedImage!.planes[2].bytes);

          // Call the convertImage function and convert the YUV to RGB
          Pointer<Uint32> imgP = conv(
              p,
              p1,
              p2,
              _savedImage!.planes[1].bytesPerRow,
              _savedImage!.planes[1].bytesPerPixel!,
              _savedImage!.width,
              _savedImage!.height);
          // Get the pointer of the data returned from the function to a List
          List<int> imgData =
              imgP.asTypedList((_savedImage!.width * _savedImage!.height));

          Uint8List imgBytes = Uint8List.fromList(imgData);
          if (imgBytes.length != imgBytes.buffer.lengthInBytes) {
            print('\t insane length !!');
            // ref: https://stackoverflow.com/questions/51801051/how-to-use-bytedata-and-bytebuffer-in-flutter-without-mirror-package
            imgBytes = Uint8List.fromList(imgBytes); // from list again
          }

          // Generate image from the converted data
          imglib.Image? img = imglib.decodeImage(imgBytes);

          // imglib.Image img = imglib.Image.fromBytes(
          //     height: _savedImage!.height,
          //     width: _savedImage!.width,
          //     bytes: imgBytes.buffer);

          // Free the memory space allocated
          // from the planes and the converted data
          malloc.free(p);
          malloc.free(p1);
          malloc.free(p2);
          malloc.free(imgP);

          if (img != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ImagePreview(img: img)));
          } else {
            print('what??');
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.camera_alt),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ImagePreview extends StatelessWidget {
  final imglib.Image img;

  const ImagePreview({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview Image"),
      ),
      body: Center(child: Image.memory(imglib.encodePng(img))),
    );
  }
}
