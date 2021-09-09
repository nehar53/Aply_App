import 'package:aply_app/Screens/Success.dart';
import 'package:aply_app/components/SnackBar.dart';

import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'FirebaseApi.dart';

class UploadDocumentsPage extends StatefulWidget {
  @override
  _UploadDocumentsPageState createState() => _UploadDocumentsPageState();
}

class _UploadDocumentsPageState extends State<UploadDocumentsPage> {
  // TextEditingController _AdharCard = TextEditingController();
  // TextEditingController _Resume = TextEditingController();
  firebase_storage.UploadTask task_resume;
  File file_resume;
  firebase_storage.UploadTask task_adhaar;
  File file_adhaar;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var fileName_resume;
    fileName_resume =
        file_resume != null ? basename(file_resume.path) : 'No file selected';
    var fileName_adhaar;
    fileName_adhaar =
        file_adhaar != null ? basename(file_adhaar.path) : 'No file selected';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
          SizedBox(
            width: size.width * 0.9,
            height: 40,
            child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    //backgroundColor:  Color(0xFF4D88AF),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xFF009bff)),
                      borderRadius: BorderRadius.circular(25.0),
                    )),
                onPressed: () => selectFile_adhaar(),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    Icons.upload_file,
                    color: Colors.black87,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Upload Adhaar',
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ])),
          ),
          Text(
            fileName_adhaar,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: size.height * 0.03),
          SizedBox(
            width: size.width * 0.9,
            height: 40,
            child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    //backgroundColor:  Color(0xFF4D88AF),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xFF009bff)),
                      borderRadius: BorderRadius.circular(25.0),
                    )),
                onPressed: () => selectFile_resume(),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    Icons.upload_file,
                    color: Colors.black87,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Upload Resume/CV',
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ])),
          ),
          Text(
            fileName_resume,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: size.height * 0.05),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: RaisedButton(
              onPressed: () async {
                if (fileName_adhaar == 'No file selected' ||
                    fileName_adhaar == null &&
                        fileName_resume == 'No file selected' ||
                    fileName_resume == null) {
                  showSnackBar('Please Upload Documents!', context, Colors.red);
                } else {
                  uploadFiles_resume();
                  uploadFiles_adhaar();

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Success()));
                }
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
                  "Upload Documents",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future selectFile_resume() async {
    print('tappedd------------------------');
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return "Can't be empty";
    final path = result.files.single.path;
    setState(() {
      file_resume = File(path);
    });
  }

  Future selectFile_adhaar() async {
    print('tappedd- Adhaar -----------------------');
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return "Can't be empty";
    final path = result.files.single.path;
    setState(() {
      file_adhaar = File(path);
    });
  }

  Future uploadFiles_resume() async {
    if (file_resume == null) {
      return;
    }
    final fileName_resume = basename(file_resume.path);
    final destination_resume = 'Resume/$fileName_resume';
    task_resume = FirebaseApi.uploadFile(destination_resume, file_resume);
    setState(() {});
    if (task_resume == null) return;
    final snapshot = await task_resume.whenComplete(() {});
    final urlDownload_resume = await snapshot.ref.getDownloadURL();
    print('Download-Link-Resume: $urlDownload_resume');
  }

  Future uploadFiles_adhaar() async {
    if (file_adhaar == null) {
      return;
    }
    final fileName_adhaar = basename(file_adhaar.path);
    final destination_adhaar = 'Adhaar/$fileName_adhaar';
    task_resume = FirebaseApi.uploadFile(destination_adhaar, file_resume);
    setState(() {});
    if (task_resume == null) return;
    final snapshot = await task_resume.whenComplete(() {});
    final urlDownload_resume = await snapshot.ref.getDownloadURL();
    print('Download-Link-Adhaar: $urlDownload_resume');
  }

  Future<firebase_storage.UploadTask> uploadFile(
      File file, BuildContext context) async {
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

  Future<firebase_storage.UploadTask> uploadFile2(
      File file, BuildContext context) async {
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
