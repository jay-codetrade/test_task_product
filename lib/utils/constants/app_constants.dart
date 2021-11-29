import 'package:flutter/material.dart';

Size? screenSize;

void getScreenSize(BuildContext context) {
  screenSize = MediaQuery.of(context).size;
}

//AppBar size
const double appBarSize = 120.0;

// Last Year
int lastYear = 50;

// Image Picked Quality
const int imageQuality = 50;

// Regex Pattern
const Pattern validEmailRegex =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
const Pattern validPasswordRegex =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~%]).{8,32}$';
const Pattern validMobileRegex = r'(^(?:[+0]9)?[0-9]{10,12}$)';

//App Constants
const String supportEmail = "hello@ymewhatnow.co.uk";
const String deviceAndroid = "Android";
const String deviceIOS = "iOS";
