import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_pick/image_pick.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
  ImagePick.instance.initializeAvailableCamera();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Image Pick",
      home: HomeMainView(),
    );
  }
}

class HomeMainView extends StatefulWidget {
  @override
  _HomeMainViewState createState() => _HomeMainViewState();
}

class _HomeMainViewState extends State<HomeMainView> {
  PickedFile _file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image pick"),
      ),
      body: Center(
        child: _file != null ? Image.file(File(_file.path),) : SizedBox(),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.camera_alt),
            onPressed: () async {
              PickedFile _image = await ImagePick.instance.getImageWithMemoryDecision(ImagePickWithMemoryConfiguration(
                camera: ImagePickSourceCamera(context: context),
                picker: ImagePickSourcePicker(pickerSource: PickerSource.camera),
              ));

              setState(() {
                _file = _image;
              });
            },
          )
        ],
      ),
    );
  }
}