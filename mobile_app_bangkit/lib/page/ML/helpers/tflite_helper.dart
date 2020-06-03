import 'dart:async';

import 'package:camera/camera.dart';
import '../models/result.dart';
import 'package:tflite/tflite.dart';

import './app_helper.dart';

class TFLiteHelper {

  static StreamController<List<Result>> tfLiteResultsController = new StreamController.broadcast();
  static List<Result> _outputs = List();
  static var modelLoaded = false;

  static Future<String> loadModel() async{
    AppHelper.log("loadModel", "Loading model..");

    return await Tflite.loadModel(
      model: "assets/models/plant_disease_model.tflite",
      labels: "assets/models/plant_labels.txt",
      numThreads: 1, // defaults to 1
      isAsset: true 
    );
  }

  static classifyImage(CameraImage image) async {

    await Tflite.runModelOnFrame(
            bytesList: image.planes.map((plane) {
              return plane.bytes;
            }).toList(),
            numResults: 5)
        .then((value) {
      if (value.isNotEmpty) {
        AppHelper.log("classifyImage", "Results loaded. ${value.length}");

        //Clear previous results
        _outputs.clear();

        value.forEach((element) {
          _outputs.add(Result(
              element['confidence'], element['index'], element['label']));

          AppHelper.log("classifyImage",
              "${element['confidence']} , ${element['index']}, ${element['label']}");
        });
      }

      //Sort results according to most confidence
      _outputs.sort((a, b) => a.confidence.compareTo(b.confidence));

      //Send results
      tfLiteResultsController.add(_outputs);
    });
  }

  static void disposeModel(){
    Tflite.close();
    tfLiteResultsController.close();
  }
}