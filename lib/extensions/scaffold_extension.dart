import 'package:flutter/material.dart';
import '../widget/common_app_bar.dart';

import '../utils/constants/color_utils.dart';

GlobalKey globalBottomBarKey = GlobalKey(debugLabel: 'btm_app_bar');

extension ScaffoldExtension on Widget {
  Scaffold baseFloatingButton({IconData? iconName, VoidCallback? onPressed}) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: this,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: onPressed,
        child: Icon(
          iconName!,
          color: Colors.white,
        ),
      ),
    );
  }

  Scaffold baseScaffoldWithAppBar(
      {required String title,
      IconData? suffixIconName,
      IconData? prefixIconName,
      IconData? suffix2IconName,
      VoidCallback? suffixOnTap,
      VoidCallback? suffix2OnTap,
      VoidCallback? prefixTap,
      Widget? bottomWidget,
      required bool hasSuffix,
      required bool hasPrefix,
      Widget? widget}) {
    return Scaffold(
      appBar: CommonAppBar(
        title: title,
        suffix2OnTap: suffix2OnTap,
        prefixIconName: prefixIconName,
        suffixIconName: suffixIconName,
        suffixIcon2Name: suffix2IconName,
        suffixOnTap: suffixOnTap,
        prefixOnTap: prefixTap,
        appBarType: AppBarType.dashboard,
        hasSuffix: hasSuffix,
        hasPrefix: hasPrefix,
      ),
      bottomNavigationBar: bottomWidget,
      backgroundColor: whiteColor,
      body: this,
    );
  }

  Scaffold baseScaffold() {
    return Scaffold(
      backgroundColor: whiteColor,
      body: this,
    );
  }
}
