import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../extensions/scaffold_extension.dart';
import '../../extensions/string_extension.dart';
import '../../model/product_model.dart';
import '../../utils/common_methods.dart';
import '../../utils/constants/color_utils.dart';
import '../../utils/constants/font_sizes.dart';
import '../../utils/localization/localization.dart';
import '../../utils/navigation.dart';
import '../../widget/common_text_field.dart';

enum PageType { addProduct, editProduct }

class AddProductScreen extends StatefulWidget {
  final List<ProductModel> productList;
  final PageType pageType;
  final ProductModel? productModel;

  AddProductScreen(
      {required this.productList, required this.pageType, this.productModel});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  //Variables
  TextEditingController nameController = TextEditingController();
  TextEditingController siteController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<double> ratings = ValueNotifier<double>(0.0);
  bool isSameProduct = false;

  @override
  void initState() {
    super.initState();
    if (widget.pageType == PageType.editProduct) {
      nameController.text = widget.productModel!.title;
      dateController.text = widget.productModel!.date;
      siteController.text = widget.productModel!.site;
      ratings.value = widget.productModel!.rating;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 16, end: 16, top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              CommonTextField(
                controller: nameController,
                hintText: Localization.of(context).name,
                validation: (v) {
                  return v!.trim().isEmptyValue(context,
                      message: Localization.of(context).msgName);
                },
                readOnly:
                    widget.pageType == PageType.editProduct ? true : false,
              ),
              const SizedBox(
                height: 15,
              ),
              CommonTextField(
                controller: siteController,
                hintText: Localization.of(context).site,
                validation: (v) {
                  return v!.trim().isEmptyValue(context,
                      message: Localization.of(context).msgSite);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              CommonTextField(
                controller: dateController,
                hintText: Localization.of(context).date,
                readOnly: true,
                onTap: () {
                  if (Platform.isIOS) {
                    openCupertinoDatePicker(context, dateController);
                  } else {
                    openMaterialDatePicker(context, dateController);
                  }
                },
                validation: (v) {
                  return v!.trim().isEmptyValue(context,
                      message: Localization.of(context).msgDate);
                },
                suffixIcon: Icon(
                  Icons.calendar_today,
                  color: blackColor,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(Localization.of(context).rating,
                  style: TextStyle(
                      fontSize: fontSize12,
                      color: blackColor,
                      fontWeight: fontWeightBold)),
              const SizedBox(
                height: 10,
              ),
              ValueListenableBuilder<double>(
                valueListenable: ratings,
                builder: (context, value, child) => RatingBar(
                  initialRating: value,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  ratingWidget: RatingWidget(
                    full: Icon(
                      Icons.star,
                      color: yellowColor,
                    ),
                    half: Icon(
                      Icons.star_half,
                      color: yellowColor,
                    ),
                    empty: Icon(
                      Icons.star_border,
                      color: yellowColor,
                    ),
                  ),
                  itemPadding: EdgeInsetsDirectional.only(start: 4.0, end: 4.0),
                  onRatingUpdate: (rating) {
                    print(rating);
                    ratings.value = rating;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ).baseScaffoldWithAppBar(
        title: widget.pageType == PageType.addProduct
            ? Localization.of(context).addProduct
            : Localization.of(context).editProduct,
        prefixTap: () {
          NavigationUtils.pop(context);
        },
        prefixIconName: Icons.arrow_back,
        hasPrefix: true,
        hasSuffix: false,
        bottomWidget: SafeArea(
          top: false,
          child: InkWell(
            onTap: () async {
              print("Hello");
              if (ratings.value == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please give rating')));
              } else if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (widget.pageType == PageType.editProduct) {
                  popMethod();
                } else if (widget.pageType == PageType.addProduct) {
                  if (widget.productList.isNotEmpty) {
                    widget.productList.forEach((element) {
                      if (element.title.toLowerCase() ==
                          nameController.text.trim().toLowerCase()) {
                        isSameProduct = true;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Product name has already taken')));
                      }
                    });
                    if(!isSameProduct){
                      popMethod();
                    }
                  } else {
                    popMethod();
                  }
                }
              }
            },
            child: Container(
              margin:
                  EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 20),
              alignment: Alignment.center,
              height: 48,
              decoration: BoxDecoration(
                  color: primaryGradientColor,
                  borderRadius: BorderRadius.circular(24)),
              child: Text(
                widget.pageType == PageType.editProduct
                    ? Localization.of(context).updateProduct
                    : Localization.of(context).save,
                style: TextStyle(
                    color: whiteColor,
                    fontWeight: fontWeightBold,
                    fontSize: fontSize16),
              ),
            ),
          ),
        ));
  }

  void popMethod() {
    NavigationUtils.pop(context,
        args: ProductModel(
            date: dateController.text.trim(),
            title: nameController.text.trim(),
            rating: ratings.value,
            site: siteController.text.trim()));
  }
}
