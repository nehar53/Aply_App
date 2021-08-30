import 'package:aply_app/Screens/Upload/Detail.dart';
import 'package:aply_app/components/TextFieldOTP.dart';
import 'package:aply_app/components/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:sms_autofill/sms_autofill.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId = " ";

  bool showLoading = false;

  String input1;
  String input2;
  String input3;
  String input4;
  String input5;
  String input6;

  final _input1 = FocusNode();
  final _input2 = FocusNode();
  final _input3 = FocusNode();
  final _input4 = FocusNode();
  final _input5 = FocusNode();
  final _input6 = FocusNode();

  @override
  void initState() {
    super.initState();
    _listenOtp();
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential?.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailsPage()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  getMobileFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        Container(
          width: 200,
          height: 200,
          child: Image.asset(
            'assets/images/logoo.jpeg',
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text('Registration', style: kTitleTextStyle),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Add your phone number. we'll send you a verification code so we know you're real",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 28,
        ),
        TextFormField(
          controller: phoneController,
          cursorColor: kBlue,
          keyboardType: TextInputType.number,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          maxLength: 10,
          decoration: InputDecoration(
              counterText: '',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF009bff)),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF009bff)),
                  borderRadius: BorderRadius.circular(10)),
              prefix: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '(+91)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              prefixIcon: Icon(
                Icons.phone,
                color: kBlue,
              )),
        ),
        SizedBox(
          height: 16,
        ),
        FlatButton(
          onPressed: () async {
            setState(() {
              showLoading = true;
            });

            await _auth.verifyPhoneNumber(
              phoneNumber: '+91' + phoneController.text,
              verificationCompleted: (phoneAuthCredential) async {
                setState(() {
                  showLoading = false;
                });
                //signInWithPhoneAuthCredential(phoneAuthCredential);
              },
              verificationFailed: (verificationFailed) async {
                setState(() {
                  showLoading = false;
                });
                _scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text(verificationFailed.message)));
              },
              codeSent: (verificationId, resendingToken) async {
                setState(() {
                  showLoading = false;
                  currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                  this.verificationId = verificationId;
                });
              },
              codeAutoRetrievalTimeout: (verificationId) async {},
            );
          },
          child: Text("SEND"),
          color: Colors.blue,
          textColor: Colors.white,
        ),
        Spacer(),
      ],
    );
  }

  getOtpFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        Container(
          width: 200,
          height: 200,
          child: Image.asset(
            'assets/images/logoo.jpeg',
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text('Verification', style: kTitleTextStyle),
        const SizedBox(
          height: 10,
        ),
        Text(
          "We sent a One Time Password (OTP) to ${phoneController.text}",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 28,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFieldOtp(
                    focusNodeP: _input1,
                    focusNodeN: _input2,
                    onChanged: (v) {
                      input1 = v;
                      if (v.length == 1) {
                        FocusScope.of(context).requestFocus(_input2);
                      }
                    },
                  ),
                  TextFieldOtp(
                    focusNodeP: _input2,
                    focusNodeN: _input3,
                    onChanged: (v) {
                      input2 = v;
                      if (v.length == 1) {
                        FocusScope.of(context).requestFocus(_input3);
                      }
                      if (v.length == 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                  TextFieldOtp(
                    focusNodeP: _input3,
                    focusNodeN: _input4,
                    onChanged: (v) {
                      input3 = v;
                      if (v.length == 1) {
                        FocusScope.of(context).requestFocus(_input4);
                      }
                      if (v.length == 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                  TextFieldOtp(
                    focusNodeP: _input4,
                    onChanged: (v) {
                      input4 = v;
                      if (v.length == 1) {
                        FocusScope.of(context).requestFocus(_input5);
                      }
                      if (v.length == 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                  TextFieldOtp(
                    focusNodeP: _input5,
                    onChanged: (v) {
                      input5 = v;
                      if (v.length == 1) {
                        FocusScope.of(context).requestFocus(_input6);
                      }
                      if (v.length == 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                  TextFieldOtp(
                    focusNodeP: _input6,
                    onChanged: (v) {
                      input6 = v;
                      if (v.length == 1) {}
                      if (v.length == 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
        const SizedBox(
          height: 18,
        ),
        Text(
          "Didn't you receive any code?",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 18,
        ),
        SelectableText(
          "Resend New Code",
          onTap: () {
            Navigator.of(context).pop();
          },
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        FlatButton(
          onPressed: () async {
            String otp = input1 + input2 + input3 + input4 + input5 + input6;

            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
                    verificationId: verificationId, smsCode: otp);

            signInWithPhoneAuthCredential(phoneAuthCredential);
          },
          child: Text("VERIFY"),
          color: Colors.blue,
          textColor: Colors.white,
        ),
        Spacer(),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: Container(
          child: showLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
          padding: const EdgeInsets.all(16),
        ));
  }

  void _listenOtp() async {
    await SmsAutoFill().listenForCode;
  }
}
