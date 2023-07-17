import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monkeybox_final/utilities/app_colors.dart';
import 'package:tflite/tflite.dart';
import 'package:sizer/sizer.dart';

import '../../controller/dio/dio_helper.dart';
import '../../controller/dio/endpoints.dart';
import '../../model/addImage_model.dart';

class detectionScreen extends StatefulWidget {
  @override
  State<detectionScreen> createState() => _detectionScreenState();
}

bool _loading = true;
File? _image;
List? _output;
final picker = ImagePicker();
AddImageModel addImageModel = AddImageModel();

class _detectionScreenState extends State<detectionScreen> {
  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  addImage(File img, String status) async {
    FormData upload = FormData.fromMap({
      'image': await MultipartFile.fromFile(_image!.path),
      'status': status,
    });
    DioHelper.postImage(
            endPoint: EndPoint.addImage,
            data: upload,
            token: EndPoint.userToken)
        .then((value) {
      addImageModel = AddImageModel.fromJson(value.data);
      print("Image added :" + addImageModel.imagePath.toString());
      Fluttertoast.showToast(
          msg: "Image uploaded successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: clr.primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: "Ann error occurred while uploading the image",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: clr.primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
    );
    setState(() {
      _output = output;
      _loading = false;
    });
    print(":::::::::::::::" + _output.toString());
    addImage(_image!, '${_output![0]['label']}');
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/converted_model.tflite", labels: "assets/labels.txt");
  }

  pickImageFromGallery() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image!);
  }

  pickImageFromCamera() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_loading == true?"Upload your photo":"",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp)),
              SizedBox(
                height: 3.h,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Container(
                            child: Center(
                              child: _loading == true
                                  ? const SizedBox() //show nothing if no picture selected
                                  : Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Image.file(
                                            _image!,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        _output != null
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5.h),
                                                child: Text(
                                                  'The object is: ${_output![0]['label']}!',
                                                  style: TextStyle(
                                                      color: clr.primaryColor,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ])),
            ]),
      )),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: clr.primaryColor,
        activeBackgroundColor: Colors.deepPurpleAccent,
        //background color when menu is expanded
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,

        elevation: 8.0,
        //shadow elevation of button

        children: [
          SpeedDialChild(
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
              ),
              backgroundColor: clr.lightRed,
              label: 'Add from camera',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: pickImageFromCamera),
          SpeedDialChild(
            child: Icon(Icons.image, color: Colors.white),
            backgroundColor: clr.lightBlue,
            label: 'Add from gallery',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: pickImageFromGallery,
          ),
        ],
      ),
    );
  }
}
