import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constants/font_sizes.dart';
import 'dialog_utils.dart';

import 'constants/app_constants.dart';
import 'constants/color_utils.dart';
import 'localization/localization.dart';

// Get Text Widget
Widget getTextWidget(
        {String? title,
        Color textColor = Colors.white,
        double textFontSize = fontSize14,
        FontWeight textFontWeight = fontWeightRegular,
        TextAlign textAlign = TextAlign.left,
        TextDecoration decoration = TextDecoration.none,
        int? maxLines}) =>
    Text(
      title!,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(
        decoration: decoration,
        fontSize: textFontSize,
        color: textColor,
        fontWeight: textFontWeight,
      ),
    );

//Launch Url
void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

// Get Bottom Sheet
Widget getBottomSheetAction(
        {required BuildContext context,
        IconData? icon,
        String? title,
        required Function onTap}) =>
    GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            ClipOval(
              child: Container(
                color: primaryColor,
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            ),
            getTextWidget(title: title, textFontSize: fontSize14),
          ],
        ),
      ),
    );

//Remove Focus
void removeFocus(BuildContext context) =>
    FocusScope.of(context).requestFocus(FocusNode());

// To Open App Settings
void openSettings(BuildContext context) {
  showOkCancelAlertDialog(
    context: context,
    message: Localization.of(context).alertPermissionNotRestricted,
    cancelButtonTitle: Localization.of(context).cancel,
    okButtonTitle: Localization.of(context).ok,
    okButtonAction: () {
      AppSettings.openAppSettings();
    },
  );
}

// To Get the Device ID
Future<String> getDeviceId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
  }
}

Future<DateTime> pickDate(
    {required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate}) async {
  final picked = await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: firstDate ?? DateTime.now(),
    lastDate: lastDate ?? DateTime(DateTime.now().year + lastYear),
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light().copyWith(primary: primaryColor),
        ),
        child: child!,
      );
    },
  );
  return picked ?? initialDate!;
}

void mailToAddress(String email) {
  final _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email,
  );
  launch(_emailLaunchUri.toString());
}

Future<void> openCupertinoDatePicker(
  BuildContext context,
  TextEditingController controller,
) {
  return showCupertinoModalPopup(
    context: context,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: CupertinoDatePicker(
        backgroundColor: Colors.white,
        onDateTimeChanged: (pickedDate) {
          controller.text = pickedDate.toString().split(" ").first;
        },
        initialDateTime: DateTime.now(),
        minimumDate: DateTime(DateTime.now().year - 50),
        maximumDate: DateTime.now(),
        minuteInterval: 1,
        mode: CupertinoDatePickerMode.date,
      ),
    ),
  );
}

Future<Null> openMaterialDatePicker(
  BuildContext context,
  TextEditingController controller,
) async {
  final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 50),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data:
              ThemeData(primaryColor: primaryColor, accentColor: primaryColor),
          child: child!,
        );
      });
  if (pickedDate != null) {
    controller.text = pickedDate.toString().split(" ").first;
  }
}
