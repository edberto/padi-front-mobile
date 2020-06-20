import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import '../../models/main.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class plant_detector extends StatefulWidget {
  final MainModel model;

  plant_detector(this.model);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _plant_detector();
  }
}

class _plant_detector extends State<plant_detector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyImagePicker(widget.model),
    );
  }
}

class MyImagePicker extends StatefulWidget {
  final MainModel model;
  MyImagePicker(this.model);
  @override
  MyImagePickerState createState() => MyImagePickerState();
}

class MyImagePickerState extends State<MyImagePicker> {
  File imageURI;
  String result;
  String path;
  String index_output;
  String label_output;
  String confidence_output;
  String _uploadedFileURL;
  String description;
  Map<String, dynamic> hasilPrediksiModel;
  Map<String, dynamic> hasilPrediksiModel_temp = {
    'label': "isLoading",
    'description': "isLoading",
    'effect': "isLoading",
    'solution': "isLoading",
    'prevention': "isLoading",
  };

bool isSaved;

 void initState() {
   hasilPrediksiModel= hasilPrediksiModel_temp;
   isSaved = false;
  // assert(_debugLifecycleState == _StateLifecycle.created);
  super.initState();
}
 
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
    path = null;
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      isSaved = false;
      hasilPrediksiModel = hasilPrediksiModel_temp;
      imageURI = image;
      if (imageURI != null) {
        path = image.path;
      }
    });
  }

  Future getImageFromGallery() async {
    path = null;
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      isSaved = false;
      hasilPrediksiModel = hasilPrediksiModel_temp;
      imageURI = image;
      if (imageURI != null) {
        path = image.path;
      }
    });
  }

  Future addProduct (String imageURL, String prediction,BuildContext context) async {
    await widget.model.addProduct(imageURL, prediction);
    print('masuk');
      setState(() {
        
        isSaved = true;
        alertDialog(context);

      });
  }

  Future classifyImage() async {
    var output = null;
    var output_addProduct = null;
    await Tflite.loadModel(
        model: "assets/models/model.tflite",
        labels: "assets/models/labels.txt",
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
      print(index_output);
      widget.model.getPrediction(index_output);
      output_addProduct = widget.model.hasilPrediksi;
      confidence_output =
          (100 * output[0]['confidence']).toString().substring(0, 4);
      // description = output_addProduct['label'];
      if (output_addProduct != null) {
        hasilPrediksiModel = output_addProduct;
      } else {
        hasilPrediksiModel = hasilPrediksiModel_temp;
      }
      print(hasilPrediksiModel);
    });
  }

  Future<bool> alertDialog(BuildContext context) async {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Model saved!",
      desc: "Your model histories can be found in history section. Enjoy !",
      buttons: [
        DialogButton(
          child: Text(
            "BACK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
    // : Container();
  }
  
  void _openImagePicker(BuildContext context) {
    setState(() {
      uploadFile();
    });
    // print(label_output);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 300.0,
              padding: EdgeInsets.all(10.0),
              child: result == null
                  ? Center(child: CircularProgressIndicator())
                  : datalabel()
              // : Column(children: [
              //     Text(
              //       label_output,
              //       style: TextStyle(fontWeight: FontWeight.bold),
              //     ),
              //     Center(
              //       child: Text("Confidence : " + confidence_output + "%"),
              //     ),
              //     SizedBox(
              //       height: 10.0,
              //     ),
              //     // Text(label_output)

              //   ]),
              );
        });
    setState(() {});
  }

  Widget datalabel() {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Index',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Value',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Label')),
            DataCell(Text(hasilPrediksiModel['label'])),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Description')),
            DataCell(Text(hasilPrediksiModel['description'])),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Effect')),
            DataCell(Text(hasilPrediksiModel['effect'])),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // TODO: implement build
    return Container(
      child: Scaffold(
          backgroundColor: Colors.green[300],
          body: Stack(
            children: <Widget>[
              middleWare(context, size),
              path != null && hasilPrediksiModel['label'] != 'isLoading'
                  ? Container(
                      padding: EdgeInsets.all(25.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: isSaved == false ? FloatingActionButton(
                          onPressed: () {
                            addProduct(_uploadedFileURL, index_output, context);
                            print(isSaved);
                          },
                          backgroundColor: Colors.red,
                          child: Icon(Icons.save),
                          tooltip: 'Press to save',
                        ):FloatingActionButton(
                          // onPressed: () {},
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.done_outline),
                          tooltip: 'Model is saved',
                        ),
                      ),
                    ) : Container()
            ],
          )),
    );
  }

  Widget middleWare(BuildContext context, Size size) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
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
                    child: SvgPicture.asset("assets/icons/cactus.svg"),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Text('No image selected.')
                ],
              ),
            )
          : Image.file(imageURI, width: 300, height: 200, fit: BoxFit.cover),
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
                onPressed: () {
                  _openImagePicker(context);
                  if(hasilPrediksiModel['label'] == 'isLoading'){
                    classifyImage();
                  }
                }, // classifyImage(),
                child: Text('Classify Image'),
                textColor: Colors.black,
                color: Colors.green[500],
                padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
              )),
      // result == null || path == null ? Text('') : Text(result)
    ]));
  }
}
