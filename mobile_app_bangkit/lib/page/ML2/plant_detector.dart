import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class plant_detector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyImagePicker(),
    );
  }
}

class MyImagePicker extends StatefulWidget {
  @override
  MyImagePickerState createState() => MyImagePickerState();
}

class MyImagePickerState extends State {
  File imageURI;
  String result;
  String path;
  String index_output;
  String label_output;
  String confidence_output;
  String _uploadedFileURL;

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(imageURI.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(imageURI);
    await uploadTask.onComplete;
    print('File Uploaded');
    
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        classifyImage();
        print(_uploadedFileURL);
      });
    });
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageURI = image;
      if (imageURI != null) {
        path = image.path;
      }
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageURI = image;
      if (imageURI != null) {
        path = image.path;
      }
    });
  }

  Future classifyImage() async {
    var output = null;
    await Tflite.loadModel(
        model: "assets/models/padi.tflite",
        labels: "assets/models/padi_labels.txt",
        numThreads: 1, // defaults to 1
        isAsset: true);

    if (path != null) {
      output = await Tflite.runModelOnImage(path: path, numResults: 1);
      // uploadFile();
      
    }


    setState(() {
      result = output.toString();
      index_output = output[0]['index'].toString();
      label_output = output[0]['label'].toString();
      confidence_output =
          (100 * output[0]['confidence']).toString().substring(0, 4);
    });
  }

  void _openImagePicker(BuildContext context) {
    uploadFile();
    print(label_output);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: result == null
                ? Center(child: CircularProgressIndicator())
                : Column(children: [
                    Text(
                      label_output,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Center(
                      child: Text("Confidence : " + confidence_output + "%"),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry')
                  ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // TODO: implement build
    return Container(
      child: Scaffold(
          backgroundColor: Colors.green[300],
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                imageURI == null
                    ? Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Color(0xFFF1F8E9),
                                shape: BoxShape.circle,
                              ),
                              child:
                                  SvgPicture.asset("assets/icons/cactus.svg"),
                            ),
                            SizedBox(
                              height: size.height * 0.1,
                            ),
                            Text('No image selected.')
                          ],
                        ),
                      )
                    : Image.file(imageURI,
                        width: 300, height: 200, fit: BoxFit.cover),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                    child: RaisedButton(
                      onPressed: () => getImageFromCamera(),
                      child: Text('Click Here To Select Image From Camera'),
                      textColor: Colors.black,
                      color: Colors.green[500],
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: RaisedButton(
                      onPressed: () => getImageFromGallery(),
                      child: Text('Click Here To Select Image From Gallery'),
                      textColor: Colors.black,
                      color: Colors.green[500],
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                    )),
                path == null
                    ? Container()
                    : Container(
                        margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                        child: RaisedButton(
                          onPressed: () =>
                              _openImagePicker(context), // classifyImage(),
                          child: Text('Classify Image'),
                          textColor: Colors.black,
                          color: Colors.green[500],
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                        )),
                result == null || path == null ? Text('') : Text(result)
              ]))),
    );
  }
}
