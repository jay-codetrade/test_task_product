import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../utils/common_methods.dart';
import '../../utils/dialog_utils.dart';
import '../add_product/add_product_screen.dart';
import '../../utils/constants/route_constants.dart';
import '../../utils/navigation.dart';
import '../../model/product_model.dart';
import '../../utils/constants/font_sizes.dart';
import '../../utils/constants/color_utils.dart';
import '../../utils/localization/localization.dart';
import '../../extensions/scaffold_extension.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  ValueNotifier<List<ProductModel>> _productList =
      ValueNotifier<List<ProductModel>>([]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16, end: 16, top: 10),
      child: _productList.value.isEmpty
          ? Center(
              child: Text(
                Localization.of(context).noProduct,
                style: TextStyle(fontSize: fontSize18, color: blackColor),
              ),
            )
          : ValueListenableBuilder(
              valueListenable: _productList,
              builder: (context, value, child) {
                return SingleChildScrollView(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (c, i) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: _productList.value.length,
                    itemBuilder: (c, i) {
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          padding: EdgeInsetsDirectional.only(
                              top: 10, bottom: 10, start: 15, end: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: whiteColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _productList.value[i].title.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: fontSize18,
                                        fontWeight: fontWeightExtraBold),
                                  ),
                                  RatingBarIndicator(
                                    rating: _productList.value[i].rating,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: yellowColor,
                                    ),
                                    itemCount: 5,
                                    itemSize: 15.0,
                                    unratedColor: yellowColor.withAlpha(50),
                                    direction: Axis.horizontal,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                _productList.value[i].date,
                                style: TextStyle(
                                    fontSize: fontSize18,
                                    fontWeight: fontWeightBold),
                              ),
                              InkWell(
                                onTap: () async {
                                  launchURL(
                                      "https://www.youtube.com/");
                                },
                                child: Text(
                                  _productList.value[i].site,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: fontSize18,
                                      color: primaryGradientColor,
                                      fontWeight: fontWeightSemiBold),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      NavigationUtils.push(
                                          context, routeAddProduct,
                                          arguments: {
                                            "productList": _productList.value,
                                            "productModel":
                                                _productList.value[i],
                                            "pageType": PageType.editProduct
                                          }).then((value) {
                                        _productList.value[i] = value;
                                        setState(() {});
                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 100,
                                      alignment: Alignment.center,
                                      padding: EdgeInsetsDirectional.only(
                                          start: 15,
                                          end: 15,
                                          top: 7,
                                          bottom: 5),
                                      decoration: BoxDecoration(
                                          color: blueColor,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Text(
                                        Localization.of(context).edit,
                                        style: TextStyle(color: whiteColor),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      showOkCancelAlertDialog(
                                          context: context,
                                          cancelButtonTitle: "No",
                                          message:
                                              "Do you really want to delete?",
                                          okButtonAction: () {
                                            _productList.value.removeAt(i);
                                            setState(() {});
                                          },
                                          okButtonTitle: "Yes");
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 30,
                                      alignment: Alignment.center,
                                      padding: EdgeInsetsDirectional.only(
                                          start: 15,
                                          end: 15,
                                          top: 7,
                                          bottom: 5),
                                      decoration: BoxDecoration(
                                          color: redColor,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Text(
                                        Localization.of(context).delete,
                                        style: TextStyle(color: whiteColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    ).baseScaffoldWithAppBar(
        title: Localization.of(context).appName,
        hasSuffix: true,
        hasPrefix: false,
        suffix2OnTap: () async {
          // _productList.value.sort((a, b) => a.title.compareTo(b.title));
          setState(() {});
          await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(Localization.of(context).sorting),
                content: SizedBox(
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _onTapSort(
                          title: Localization.of(context).name,
                          onTap: () {
                            _productList.value
                                .sort((a, b) => a.title.compareTo(b.title));
                            setState(() {});
                            NavigationUtils.pop(context, args: true);
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      _onTapSort(
                          title: Localization.of(context).rating,
                          onTap: () {
                            _productList.value
                                .sort((a, b) => a.rating.compareTo(b.rating));
                            setState(() {});
                            NavigationUtils.pop(context);
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      _onTapSort(
                          title: Localization.of(context).date,
                          onTap: () {
                            _productList.value
                                .sort((a, b) => a.date.compareTo(b.date));
                            setState(() {});
                            NavigationUtils.pop(context);
                          }),
                    ],
                  ),
                ),
              );
            },
          );
          setState(() {});
        },
        suffix2IconName: Icons.sort_by_alpha,
        suffixOnTap: () async {
          var data = await NavigationUtils.push(context, routeAddProduct,
              arguments: {
                "productList": _productList.value,
                "pageType": PageType.addProduct
              });
          _productList.value.add(data);
          setState(() {});
        },
        suffixIconName: Icons.add_box);
  }

  Widget _onTapSort({required VoidCallback onTap, required String title}) {
    return InkWell(onTap: onTap, child: Text(title));
  }
}
