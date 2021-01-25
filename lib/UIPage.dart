import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

String global;
bool hFace = false;

class FacePage extends StatefulWidget {
  @override
  _FacePageState createState() => _FacePageState();
}

class _FacePageState extends State<FacePage> {
  File _imageFile;
  List<Face> _faces;
  bool isLoading = false;
  ui.Image _image;
  String text = '';
  List<int> prob;
  _getImageAndDetectFaces(String value) async {
    var imageFile;
    if (value == 'camera') {
      imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      isLoading = true;
    });
//
//    final labeler = FirebaseVision.instance.imageLabeler();
//    final List<ImageLabel> labels = await labeler.processImage(image);
//    for (ImageLabel label in labels) {
//      final String text = label.text;
//      final String entityId = label.entityId;
//      final double confidence = label.confidence;
//      print(text);
//      print(entityId);
//      print(confidence);
//    }                            //   IMAGE_LABELER

//    final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
//    final VisionText visionText = await textRecognizer.processImage(image);
//    String text = visionText.text;
//    //print(visionText.blocks);
//    List<Rect> main1 = [];
//    for (TextBlock block in visionText.blocks) {
//      final Rect boundingBox = block.boundingBox;
//      final List<Offset> cornerPoints = block.cornerPoints;
//      final String text = block.text;
//      final List<RecognizedLanguage> languages = block.recognizedLanguages;
//      main1.add(boundingBox);
//    }
//
//    print(main1);
    final image = FirebaseVisionImage.fromFile(imageFile);
    FaceDetectorOptions options =
        FaceDetectorOptions(enableClassification: true, enableContours: true);

    final faceDetector = FirebaseVision.instance.faceDetector(options);
    List<Face> faces = await faceDetector.processImage(image);

    if (mounted) {
      setState(() {
        _imageFile = imageFile;
        _faces = faces;
        _loadImage(imageFile);
      });
    }
  }

  _loadImage(File file) async {
    final data = await file.readAsBytes();
    await decodeImageFromList(data).then(
      (value) => setState(() {
        _image = value;
        isLoading = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : (_imageFile == null)
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Compare your smile with others!',
                        style: TextStyle(
                          fontFamily: 'Times new Roman',
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Container(
                        child: Image.asset('images/india.jpeg'),
                      ),
                      Text(
                        'No image Selected',
                        style: TextStyle(
                          fontFamily: 'Times new Roman',
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ))
                : SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                  //borderRadius: BorderRadius.circular(10),
                                  border: Border(
                                left: BorderSide(color: Colors.red, width: 2),
                                right: BorderSide(color: Colors.red, width: 2),
                                top: BorderSide(color: Colors.red, width: 2),
                                bottom: BorderSide(color: Colors.red, width: 2),
                              )),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: SizedBox(
                                  width: _image.width.toDouble(),
                                  height: _image.height.toDouble(),
                                  child: CustomPaint(
                                    painter: FacePainter(_image, _faces),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          (hFace
                              ? Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border(
                                            left: BorderSide(
                                                color: Colors.green, width: 2),
                                            right: BorderSide(
                                                color: Colors.green, width: 2),
                                            top: BorderSide(
                                                color: Colors.green, width: 2),
                                            bottom: BorderSide(
                                                color: Colors.green, width: 2),
                                          ),
                                          shape: BoxShape.rectangle,
                                          color: Colors.black38),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '$global',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Times new Roman',
                                            fontSize: 20,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Text(''),
                                )),
                        ],
                      ),
                    ),
                  ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_home,
          animatedIconTheme: IconThemeData(size: 30),
          backgroundColor: Colors.brown,
          visible: true,
          curve: Curves.bounceIn,
          children: [
            // FAB 1
            SpeedDialChild(
                child: Icon(
                  Icons.camera,
                  size: 40,
                ),
                backgroundColor: Colors.orangeAccent,
                onTap: () {
                  _getImageAndDetectFaces('camera');
                },
                label: 'Click Now',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16.0),
                labelBackgroundColor: Color(0xFF801E48)),
            // FAB 2
            SpeedDialChild(
                child: Icon(
                  Icons.file_upload,
                  size: 40,
                ),
                backgroundColor: Colors.orangeAccent,
                onTap: () {
                  _getImageAndDetectFaces('gallery');
                },
                label: 'Pick from Gallery',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16.0),
                labelBackgroundColor: Color(0xFF801E48))
          ],
        ));
  }
}

class FacePainter extends CustomPainter {
  final ui.Image image;
  final List<Face> faces;
  final List<Rect> rects = [];
  int j = 0;

  FacePainter(this.image, this.faces) {
    if (faces.length > 0) {
      hFace = true;
      double max = faces[0].smilingProbability;
      for (var i = 1; i < faces.length; i++) {
//      print({
//        'Smile': faces[i].smilingProbability,
//        '2nd': faces[i].leftEyeOpenProbability,
//        '3rd': faces[i].rightEyeOpenProbability
//      });
        print(faces[i].getContour(FaceContourType.face));
        if (max < faces[i].smilingProbability) {
          j = i;
          max = faces[i].smilingProbability;
        }
      }
      global = 'Smile Probability : ' + ((max * 100).toStringAsFixed(2)) + '%';
      print(global);
      rects.add(faces[j].boundingBox);
    }
  }

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0
      ..color = Colors.yellow;

    canvas.drawImage(image, Offset.zero, Paint());
    canvas.drawRect(rects[0], paint);
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    return image != oldDelegate.image || faces != oldDelegate.faces;
  }
}
