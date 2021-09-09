import 'package:aply_app/Screens/Upload/UploadPdf.dart';
import 'package:aply_app/components/SnackBar.dart';

import 'package:aply_app/components/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _phonenumber = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _dob = TextEditingController();

  final Future<FirebaseApp> _future = Firebase.initializeApp();
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  void addData(String _name, String _address, String _email, String _dob,
      String _phonenumber) {
    firestoreInstance
        .collection("users")
        .doc(firebaseUser.uid)
        .set({
          'name': _name,
          'DOB': _dob,
          'email': _email,
          'Address': _address,
          'Phone Number': _phonenumber,
        })
        .then((value) => showSnackBar(
            'Details Uploaded Successfully!', context, Colors.green))
        .then((value) => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => UploadDocumentsPage())));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "COMPLETE YOUR KYC",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2661FA),
                            fontSize: 30),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: size.height * 0.07),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _name,
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
                                borderSide:
                                    BorderSide(color: Color(0xFF009bff)),
                                borderRadius: BorderRadius.circular(30)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF009bff)),
                                borderRadius: BorderRadius.circular(30)),
                            prefixIcon: Icon(
                              Icons.person,
                              color: kBlue,
                            ),
                            hintText: 'Full Name'),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _phonenumber,
                        cursorColor: kBlue,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                        maxLength: 10,
                        decoration: InputDecoration(
                            counterText: '',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF009bff)),
                                borderRadius: BorderRadius.circular(30)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF009bff)),
                                borderRadius: BorderRadius.circular(30)),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: kBlue,
                            ),
                            hintText: 'Phone Number'),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _email,
                        cursorColor: kBlue,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                        maxLength: 30,
                        decoration: InputDecoration(
                            counterText: '',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF009bff)),
                                borderRadius: BorderRadius.circular(30)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF009bff)),
                                borderRadius: BorderRadius.circular(30)),
                            prefixIcon: Icon(
                              Icons.local_post_office_outlined,
                              color: kBlue,
                            ),
                            hintText: 'Email'),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _address,
                        cursorColor: kBlue,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                        maxLength: 50,
                        decoration: InputDecoration(
                            counterText: '',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF009bff)),
                                borderRadius: BorderRadius.circular(30)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF009bff)),
                                borderRadius: BorderRadius.circular(30)),
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: kBlue,
                            ),
                            hintText: 'Current Address'),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _dob,
                        cursorColor: kBlue,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                        readOnly: true,
                        validator: (v) {
                          if (v.length == 0) {
                            return 'Choose Date of Birth';
                          } else {
                            return null;
                          }
                        },
                        maxLength: 10,
                        decoration: InputDecoration(
                            counterText: '',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF009bff)),
                                borderRadius: BorderRadius.circular(30)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF009bff)),
                                borderRadius: BorderRadius.circular(30)),
                            prefixIcon: IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () async {
                                DateTime dateNow = await showDatePicker(
                                    context: context,
                                    initialDate: new DateTime.now(),
                                    firstDate: new DateTime(1900),
                                    lastDate: new DateTime(2100));
                                _dob.text =
                                    '${dateNow.year.toString()}-${dateNow.month < 10 ? '0' + dateNow.month.toString() : dateNow.month.toString()}-${dateNow.day < 10 ? '0' + dateNow.day.toString() : dateNow.day.toString()}';
                              },
                              color: kBlue,
                            ),
                            hintText: 'Choose the Date of Birth'),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      margin:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      child: RaisedButton(
                        onPressed: () async {
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.blueAccent),
                          );
                          if (_name.text == '' ||
                              _address.text == '' ||
                              _email.text == '' ||
                              _dob.text == '' ||
                              _phonenumber.text == '') {
                            showSnackBar(
                                'Please Fill Details!', context, Colors.red);
                          } else {
                            addData(_name.text, _address.text, _email.text,
                                _dob.text, _phonenumber.text);
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
                            "Next",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }));
  }
}
