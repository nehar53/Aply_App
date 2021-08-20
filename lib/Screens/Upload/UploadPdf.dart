import 'package:aply_app/Screens/HomeScreen/master.dart';

import 'package:aply_app/components/background.dart';
import 'package:aply_app/components/constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadDocumentsPage extends StatefulWidget {
  @override
  _UploadDocumentsPageState createState() => _UploadDocumentsPageState();
}

class _UploadDocumentsPageState extends State<UploadDocumentsPage> {
  TextEditingController _AdharCard = TextEditingController();
  TextEditingController _Resume = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Upload Documents to Complete your KYC",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2661FA),
                    fontSize: 26),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                readOnly: true,
                cursorColor: kBlue,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
                maxLength: 30,
                decoration: InputDecoration(
                    counterText: '',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF009bff)),
                        borderRadius: BorderRadius.circular(30)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF009bff)),
                        borderRadius: BorderRadius.circular(30)),
                    prefixIcon: IconButton(
                      icon: Icon(Icons.upload_file),
                      onPressed: () async {
                        final path = await FlutterDocumentPicker.openDocument();
                        print(path);

                        File Adharfile = File(path);
                        firebase_storage.UploadTask task =
                            await uploadFile(Adharfile);
                      },
                      color: kBlue,
                    ),
                    hintText: 'Upload your Adhar Card pdf Format'),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                readOnly: true,
                cursorColor: kBlue,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
                maxLength: 30,
                decoration: InputDecoration(
                    counterText: '',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF009bff)),
                        borderRadius: BorderRadius.circular(30)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF009bff)),
                        borderRadius: BorderRadius.circular(30)),
                    prefixIcon: IconButton(
                      icon: Icon(Icons.upload_file),
                      onPressed: () async {
                        final path = await FlutterDocumentPicker.openDocument();
                        print(path);

                        File Resumefile = File(path);
                        firebase_storage.UploadTask task =
                            await uploadFile(Resumefile);
                      },
                      color: kBlue,
                    ),
                    hintText: 'Upload your Resume in pdf Format'),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RaisedButton(
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Master()));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: new LinearGradient(
                          colors: [Colors.blue, Colors.blue[700]])),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "Upload Document",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<firebase_storage.UploadTask> uploadFile(File file) async {
    if (file == null) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Unable to Upload")));
      return null;
    }

    firebase_storage.UploadTask uploadTask;

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Resume')
        .child('/resume.pdf');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'file/pdf',
        customMetadata: {'picked-file-path': file.path});
    print("Uploading..!");

    uploadTask = ref.putData(await file.readAsBytes(), metadata);

    print("done..!");
    return Future.value(uploadTask);
  }

  Future<firebase_storage.UploadTask> uploadFile2(File file) async {
    if (file == null) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Unable to Upload")));
      return null;
    }

    firebase_storage.UploadTask uploadTask;

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Adhar')
        .child('/adhar.pdf');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'file/pdf',
        customMetadata: {'picked-file-path': file.path});
    print("Uploading..!");

    uploadTask = ref.putData(await file.readAsBytes(), metadata);

    print("done..!");
    return Future.value(uploadTask);
  }
}
