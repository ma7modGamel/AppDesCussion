import 'dart:async';

import 'package:discussion/provider/profile_provider.dart';
import 'package:discussion/services/api_services/package_helper.dart';
import 'package:discussion/tools/app_components.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/tools/design_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PackageScreen extends StatefulWidget {
  int id;
  PackageScreen({this.id});
  @override
  State<StatefulWidget> createState() {
    return PackageScreenState();
  }
}

class PackageScreenState extends State<PackageScreen> {
  PackageHelper profileHelper = PackageHelper();
  var packages;
  bool _isLoad = true;
  StreamSubscription<List<PurchaseDetails>> _subscription;

  _getPackage() {
    profileHelper.getPackage(widget.id).whenComplete(() {
      setState(() {
        packages = profileHelper.info["data"];
        _isLoad = false;
      });
    });
  }

  @override
  void initState() {
    final Stream purchaseUpdated =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    super.initState();
    _getPackage();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        print("purchase is pending");
        //_showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {

          print(purchaseDetails.error);
          showDialog(context: context, builder: (_)=>AlertDialog(
            backgroundColor: Colors.white,
            content: Text("errorDuringPayment",style: TextStyle(color: Colors.black,fontFamily: mainFont),).tr(),
            actions: [
              FlatButton(onPressed: (){}, child: Text("close",style: TextStyle(color: Colors.red,fontFamily: mainFont)).tr()),
            ],
          ));


        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.purchased) {
            print("purchase is purchased");
            await Provider.of<ProfileProvider>(context, listen: false).subscribe(widget.id);
            showDialog(context: context, builder: (_)=>AlertDialog(
              backgroundColor: Colors.white,
              content: Text("trasactionDone",style: TextStyle(color: Colors.black,fontFamily: mainFont),).tr(),
              actions: [
                FlatButton(onPressed: (){}, child: Text("close",style: TextStyle(color: Colors.red,fontFamily: mainFont)).tr()),
              ],
            ));
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchaseConnection.instance
              .completePurchase(purchaseDetails);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          tr("packages"),
          style: TextStyle(
              color: mainColor,
              fontFamily: mainFont,
              fontSize: feautreFontSize),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: mainColor),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: _isLoad == true
          ? AppLoading()
          : ListView(
              children: [
                SizedBox(height: ScreenUtil().setHeight(20)),
                _packageTitle(),
                _packagePrice(),
                SizedBox(height: ScreenUtil().setHeight(45)),
                _featuresList(),
                SizedBox(height: ScreenUtil().setHeight(45)),
                appButton(
                  sidePadding: 35,
                  buttonRadius: 23,
                  buttonText: tr("subscribe_now"),
                  buttonColor: mainColor,
                  fontFamily: mainFont,
                  textColor: white,
                  textSize: centFontSize,
                  onPressed: () async{

                    Set<String> _kIds = <String>{widget.id.toString()};
                    final ProductDetailsResponse response =
                        await InAppPurchaseConnection.instance.queryProductDetails(_kIds);
                    if (response.notFoundIDs.isNotEmpty) {
                      // Handle the error.
                      print("no products found");
                    }
                    List<ProductDetails> products = response.productDetails;

                    final ProductDetails productDetails = products[0];// Saved earlier from queryProductDetails().
                    final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
                    InAppPurchaseConnection.instance.buyConsumable(purchaseParam: purchaseParam);

                  },
                ),
              ],
            ),
    );
  }

  _featuresList() {
    double width = MediaQuery.of(Get.context).size.width;
    return Padding(
      padding: EdgeInsets.only(right: ScreenUtil().setWidth(45.0)),
      child: LimitedBox(
        maxWidth: width,
        maxHeight: ScreenUtil().setHeight(10000),
        child: ListView.builder(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          itemCount: packages["features"].length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                Icon(Icons.arrow_forward,
                    size: ScreenUtil().setWidth(20), color: logoColor),
                SizedBox(width: ScreenUtil().setWidth(20)),
                Expanded(
                  child: Text(
                    packages["features"][index],
                    style: TextStyle(
                      overflow: TextOverflow.visible,
                      color: mainColor,
                      fontFamily: mainFont,
                      fontSize: feautreFontSize,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  _packagePrice() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: ScreenUtil().setWidth(80.0)),
          child: Text(
            '${packages["price"]}',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: mainColor,
                fontFamily: mainFont,
                fontSize: priceFontSize),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(80.0)),
          child: Text(
            '${packages["currency"]}',
            textAlign: TextAlign.right,
            style: TextStyle(
                color: mainColor, fontFamily: mainFont, fontSize: centFontSize),
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(40)),
        SvgPicture.asset(choice),
      ],
    );
  }

  _packageTitle() {
    return Padding(
      padding: EdgeInsets.only(right: ScreenUtil().setWidth(45)),
      child: Text(
        packages["name"],
        softWrap: true,
        overflow: TextOverflow.visible,
        style: TextStyle(
            color: mainColor, fontFamily: mainFont, fontSize: titleFontSize),
      ),
    );
  }
}
