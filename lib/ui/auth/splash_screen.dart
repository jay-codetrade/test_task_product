import 'package:flutter/material.dart';
import '../../utils/constants/font_sizes.dart';
import '../../utils/constants/route_constants.dart';
import '../../utils/localization/localization.dart';
import '../../utils/navigation.dart';
import '../../utils/constants/app_constants.dart';
import '../../extensions/scaffold_extension.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //Lifecycle Method
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      NavigationUtils.pushAndRemoveUntil(context, routeDashboard);
    });
  }

  //Build Method
  @override
  Widget build(BuildContext context) {
    getScreenSize(context);
    return Container(
      height: screenSize!.height,
      width: screenSize!.width,
      color: Colors.white,
      child: Center(
        child: Text(
          Localization.of(context).appName,
          style: TextStyle(fontSize: fontSize30, fontWeight: fontWeightBold),
        ),
      ),
    ).baseScaffold();
  }
}
