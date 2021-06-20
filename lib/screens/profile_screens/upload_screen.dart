import 'package:discussion/provider/gallery_provider.dart';
import 'package:discussion/provider/profile_provider.dart';
import 'package:discussion/services/api_services/profile_helper.dart';
import 'package:discussion/services/local_services/shared_prefrences.dart';
import 'package:discussion/tools/app_components.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/tools/design_utils.dart';
import 'package:discussion/views/edit_gallery_views.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class UploadImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);
    final gallery = Provider.of<GalleryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "",
          style: TextStyle(
              color: mainColor,
              fontFamily: mainFont,
              fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: mainColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(100),
          ),
          _imagesList(),
          SizedBox(
            height: ScreenUtil().setHeight(80),
          ),
          _uploadedImage(),
          SizedBox(
            height: ScreenUtil().setHeight(160),
          ),
          appButton(
            sidePadding: 90,
            buttonRadius: 8,
            buttonColor: mainColor,
            buttonText: tr("save"),
            fontFamily: mainFont,
            textColor: white,
            textSize: dataFontSize,
            onPressed: () {
              provider.addImage(gallery.imageFile);
            },
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
        ],
      ),
    );
  }

  _uploadedImage() {
    final gallery = Provider.of<GalleryProvider>(Get.context);
    return Center(
      child: GestureDetector(
        onTap: gallery.pickImage,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().radius(12))),
          ),
          child: (gallery.imageFile == null)
              ? Container(
                  height: ScreenUtil().setHeight(150),
                  width: ScreenUtil().setHeight(155),
                  child: Center(child: Icon(Icons.image, color: secColor)))
              : Image(
                  height: ScreenUtil().setHeight(150),
                  width: ScreenUtil().setHeight(155),
                  fit: BoxFit.fill,
                  image: FileImage(
                    gallery.imageFile,
                  ),
                ),
        ),
      ),
    );
  }

  _imagesList() {
    double width = MediaQuery.of(Get.context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        right: ScreenUtil().setWidth(30),
        left: ScreenUtil().setWidth(30),
      ),
      child: Container(
        width: width,
        height: ScreenUtil().setHeight(110),
        child: EditGalleryView(),
      ),
    );
  }
}
