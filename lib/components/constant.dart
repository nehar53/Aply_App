import 'package:aply_app/components/sizeconfig.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Colors.blue;
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Colors.blue, Colors.blueAccent],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

const keTextColor = Color(0xFF0D1333);
const kBlueColor = Color(0xFF6E8AFA);
const kBestSellerColor = Color(0xFFFFD073);
const kGreenColor = Color(0xFF49CC96);
const kBlue = Color(0xff081029);
const kRed = Color(0xffAA1110);

const kHeadingextStyle = TextStyle(
  fontSize: 28,
  color: kTextColor,
  fontWeight: FontWeight.bold,
);
const kSubheadingextStyle = TextStyle(
  fontSize: 24,
  color: Color(0xFF61688B),
  height: 2,
);
const kSubTextStyle = TextStyle(
  fontSize: 18.0,
  color: Colors.black,
);
const kFixPadding = 16.0;
const kTitleTextStyle = TextStyle(
  fontSize: 20,
  color: kTextColor,
  fontWeight: FontWeight.bold,
);
const kDefaultPadding = 24.0;
const kSubtitleTextStyle = TextStyle(
  fontSize: 18,
  color: kTextColor,
  // fontWeight: FontWeight.bold,
);

BoxDecoration kTextContainer = BoxDecoration(
    color: Colors.white54, borderRadius: BorderRadius.all(Radius.circular(20)));
InputDecoration kTextDeco = InputDecoration(
  prefixIcon: Icon(
    Icons.lock,
    color: kBlue,
  ),
  hintText: 'Password',
  border: OutlineInputBorder(
    borderSide: BorderSide(color: kBlue, width: 4),
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kRed.withOpacity(0.8), width: 4),
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
  ),
);

BoxDecoration kBackgroundContainer = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topCenter,
        colors: [
      Colors.white.withOpacity(0.1),
      Colors.white.withOpacity(0.1),
    ]));
