import '../utils/constants/color_utils.dart';
import '../utils/constants/font_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AppBarType { dashboard }

class CommonAppBar extends StatefulWidget with PreferredSizeWidget {
  final AppBarType appBarType;
  final String title;
  final VoidCallback? prefixOnTap;
  final VoidCallback? suffixOnTap;
  final VoidCallback? suffix2OnTap;
  final IconData? suffixIconName;
  final IconData? suffixIcon2Name;
  final IconData? prefixIconName;
  final bool hasSuffix;
  final bool hasPrefix;

  CommonAppBar({
    required this.title,
    this.prefixOnTap,
    this.suffixOnTap,
    this.suffixIconName,
    required this.appBarType,
    this.prefixIconName,
    this.suffix2OnTap,
    this.suffixIcon2Name,
    required this.hasPrefix,
    required this.hasSuffix,
  });

  @override
  _CommonAppBarState createState() => _CommonAppBarState();

  @override
  Size get preferredSize => Size(0, 60);
}

class _CommonAppBarState extends State<CommonAppBar> {
  //Build Method
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
    return _getAppBarWithType();
  }

  //Returns app bar with the type defined
  Widget _getAppBarWithType() {
    switch (widget.appBarType) {
      case AppBarType.dashboard:
        return _getDashboardAppBar();
      default:
        return _getDashboardAppBar();
    }
  }

  Widget _getDashboardAppBar() => PreferredSize(
        preferredSize: Size(0, 60),
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [primaryGradientColor, secondaryGradientColor])),
            child: SafeArea(
              bottom: false,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  widget.hasPrefix
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                              onPressed: widget.prefixOnTap,
                              icon: Icon(
                                widget.prefixIconName!,
                                size: 21,
                                color: whiteColor,
                              )),
                        )
                      : SizedBox.shrink(),
                  Text(
                    widget.title,
                    style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.w700,
                        fontSize: fontSize16),
                  ),
                  widget.hasSuffix
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                              onPressed: widget.suffixOnTap,
                              icon: Icon(
                                widget.suffixIconName!,
                                size: 21,
                                color: whiteColor,
                              )),
                        )
                      : SizedBox.shrink(),
                  widget.hasSuffix
                      ? Container(
                          margin: EdgeInsets.only(right: 30),
                          alignment: Alignment.centerRight,
                          child: IconButton(
                              onPressed: widget.suffix2OnTap,
                              icon: Icon(
                                widget.suffixIcon2Name!,
                                size: 21,
                                color: whiteColor,
                              )),
                        )
                      : SizedBox.shrink()
                ],
              ),
            )),
      );
}
