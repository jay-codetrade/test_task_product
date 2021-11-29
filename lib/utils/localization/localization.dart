import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'localization_en.dart';

class MyLocalizationsDelegate extends LocalizationsDelegate<Localization> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [
        'en',
      ].contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) => _load(locale);

  static Future<Localization> _load(Locale locale) async {
    final String? name =
        (locale.countryCode == null) ? locale.languageCode : locale.toString();

    final localeName = Intl.canonicalizedLocale(name);
    Intl.defaultLocale = localeName;


    return LocalizationEN();
  }

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) => false;
}

abstract class Localization {
  static Localization of(BuildContext context) {
    return Localizations.of<Localization?>(context, Localization)!;
  }

  //App name
  String get appName;

  //Network Message
  String get internetConnectionFailed;
  String get alertPermissionNotRestricted;
  String get internetNotConnected;

  //Common
  String get ok;
  String get cancel;

  //String Constants
  String get addProduct;
  String get noProduct;
  String get editProduct;
  String get name;
  String get productName;
  String get productDate;
  String get productSite;
  String get site;
  String get rating;
  String get productPopularity;
  String get date;
  String get save;
  String get updateProduct;
  String get msgDate;
  String get msgName;
  String get msgSite;
  String get edit;
  String get delete;
  String get sorting;
}
