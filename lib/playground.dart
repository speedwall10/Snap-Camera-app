import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

bool hFace = false;

class TextRecog extends StatefulWidget {
  @override
  _TextRecogState createState() => _TextRecogState();
}

class _TextRecogState extends State<TextRecog> {
  File _imageFile;
  bool isLoading = false;
  List<Widget> _objectLabl = [];
  ui.Image _image;
  String text = '';
  _getImageAndDetectFaces(String value) async {
    var imageFile;
    if (value == 'camera') {
      imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      isLoading = true;
      _objectLabl = [];
    });
    final image = FirebaseVisionImage.fromFile(imageFile);
    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();
    final VisionText visionText = await textRecognizer.processImage(image);
    String text = visionText.text;
    for (TextBlock block in visionText.blocks) {
      final Rect boundingBox = block.boundingBox;
      final List<Offset> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<RecognizedLanguage> languages = block.recognizedLanguages;
      hFace = true;
      String s = "";
      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        s = "";
        for (TextElement element in line.elements) {
          print(element.text);
          s += element.text + " ";
        }
        _objectLabl.add(SelectableText.rich(
          TextSpan(text: s),
          showCursor: true,
          onTap: () {},
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Times new Roman',
            fontSize: 20,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ));
      }
    }

    if (mounted) {
      setState(() {
        _imageFile = imageFile;
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
                        'Find out the texts in the image!',
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
                            flex: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(color: Colors.red, width: 2),
                                  right:
                                      BorderSide(color: Colors.red, width: 2),
                                  top: BorderSide(color: Colors.red, width: 2),
                                  bottom:
                                      BorderSide(color: Colors.red, width: 2),
                                ),
                                image: DecorationImage(
                                    image: FileImage(_imageFile),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          (hFace
                              ? Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 8, 0, 0),
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
                                      // color: Colors.black38,
                                      child: ListView(
                                        scrollDirection: Axis.vertical,
                                        children: _objectLabl,
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
