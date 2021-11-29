import 'localization.dart';

class LocalizationEN implements Localization {
  //App name
  @override
  String get appName => "Test Task Product";

  //Network Messages
  @override
  String get internetConnectionFailed => "Internet connectivity failed";

  @override
  String get internetNotConnected => "Please check your network connection";

  @override
  String get alertPermissionNotRestricted =>
      "Please grant permission from settings to access this feature";

  //Common String
  @override
  String get ok => "ok";

  @override
  String get cancel => "Cancel";

  //String Constants
  @override
  String get noProduct => "No Product Available";

  @override
  String get addProduct => "Add Product";

  @override
  String get editProduct => "Edit Product";

  @override
  String get name => "Name";

  @override
  String get productName => "Product Name";

  @override
  String get date => "Date";

  @override
  String get site => "Site";

  @override
  String get rating => "Rating";

  @override
  String get productDate => "Product Date";

  @override
  String get productPopularity => "Product Popularity";

  @override
  String get productSite => "Product Site";

  @override
  String get save => "Save product";

  @override
  String get edit => "Edit";

  @override
  String get delete => "Delete";

  @override
  String get updateProduct => "Update Product";

  @override
  String get msgDate => "Please Select Date";

  @override
  String get msgName => "Please enter product name";

  @override
  String get msgSite => "Please enter site name";

  @override
  String get sorting => "Sorting";
}
