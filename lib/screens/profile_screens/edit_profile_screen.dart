import 'dart:io';
import 'package:discussion/provider/dropdownbuttons_provider.dart';
import 'package:discussion/provider/gallery_provider.dart';
import 'package:discussion/provider/profile_provider.dart';
import 'package:discussion/screens/profile_screens/upload_screen.dart';
import 'package:discussion/views/gallery_views.dart';
import 'package:discussion/screens/packages_screens/packages_screen.dart';
import 'package:discussion/tools/app_components.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/views/gendre_views.dart';
import 'package:discussion/views/nations_views.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final String bio;
  final String name;
  final String image;
  final String gendre;
  final int likeCount;
  final int callCount;
  EditProfileScreen(
      {this.bio,
      this.name,
      this.image,
      this.gendre,
      this.likeCount,
      this.callCount});
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
    print('image: ${widget.image}');
  }

  @override
  Widget build(BuildContext context) {
    final country = Provider.of<NationProvider>(context);
    final gendre = Provider.of<GendreProvider>(context);
    final gallery = Provider.of<GalleryProvider>(context, listen: true);
    return ChangeNotifierProvider(
      create: (_) => ProfileProvider(),
      child: Consumer<ProfileProvider>(
          builder: (context, provider, child) => Scaffold(
                backgroundColor: white,
                appBar: AppBar(
                  backgroundColor: white,
                  elevation: 0.0,
                  centerTitle: true,
                  title: Text(
                    tr("edit_profile"),
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
                      height: ScreenUtil().setHeight(50),
                    ),
                    _profileInfo(),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    _titleProfile(
                      title: tr("gallery"),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    _profileGallery(),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    appTextField(
                      controller: provider.name,
                      sidePadding: 30,
                      autofocus: false,
                      isPassword: false,
                      fontFamily: mainFont,
                      fontSize: buttonFontSize,
                      hintColor: textColor,
                      hintText: tr('name'),
                      textColor: black,
                      borderColor: Colors.grey[300],
                      prefixImage: man,
                      prefixSize: 20,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return tr("validation_message");
                        }
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    appTextField(
                      controller: provider.bio,
                      sidePadding: 30,
                      autofocus: false,
                      isPassword: false,
                      fontFamily: mainFont,
                      fontSize: buttonFontSize,
                      hintColor: textColor,
                      hintText: tr('bio'),
                      textColor: black,
                      borderColor: Colors.grey[300],
                      prefixImage: bio,
                      prefixSize: 20,
                      maxLength: 100,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return tr("validation_message");
                        }
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    _nationButton(),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    _gendreButton(),
                    SizedBox(
                      height: ScreenUtil().setHeight(40),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => PackagesScreen());
                      },
                      child: Center(
                        child: Text(
                          tr('promote'),
                          style: TextStyle(
                              color: mainColor,
                              fontFamily: mainFont,
                              fontSize: homeFontSize,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(15),
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
                        provider.editProfile(
                            1,
                            provider.name.text.trim(),
                            country.id,
                            gendre.id,
                            provider.bio.text.trim(),
                            // imageId.toString(),
                            gallery.imageFile);
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(40),
                    ),
                  ],
                ),
              )),
    );
  }

  _gendreButton() {
    double width = MediaQuery.of(Get.context).size.width;
    return Padding(
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(35),
          right: ScreenUtil().setWidth(35),
        ),
        child: Container(
            width: width,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[300],
                ),
              ),
            ),
            child: GendreDropDown()));
  }

  _profileGallery() {
    double width = MediaQuery.of(Get.context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        right: ScreenUtil().setWidth(45),
        left: ScreenUtil().setWidth(45),
      ),
      child: Container(
        width: width,
        height: ScreenUtil().setHeight(110),
        child: GalleryView(),
      ),
    );
  }

  _titleProfile({String title}) {
    return Padding(
      padding: EdgeInsets.only(
        right: ScreenUtil().setWidth(40),
        left: ScreenUtil().setWidth(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: mainColor,
                fontFamily: mainFont,
                fontSize: buttonFontSize,
                fontWeight: FontWeight.w700),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => UploadImage());
            },
            child: Text(
              tr('edit_gallery'),
              style: TextStyle(
                  color: mainColor,
                  fontFamily: mainFont,
                  fontSize: fontSize,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  _profileInfo() {
    final provider = Provider.of<GalleryProvider>(context, listen: true);
    final country = Provider.of<NationProvider>(context);
    final gendre = Provider.of<GendreProvider>(context);
    final gallery = Provider.of<GalleryProvider>(context, listen: true);
    return Padding(
      padding: EdgeInsets.only(
        right: ScreenUtil().setWidth(40),
        left: ScreenUtil().setWidth(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () async{
              print("####1");
              var res=await provider.pickImage();
              print(res);
              print("####1");
              if(res != null && res.toString() != "-1"){
                Provider.of<ProfileProvider>(context, listen: false).editProfile(
                    1,
                    Provider
                        .of<ProfileProvider>(context, listen: false)
                        .name
                        .text
                        .trim(),
                    country.id,
                    gendre.id,
                    Provider
                        .of<ProfileProvider>(context, listen: false)
                        .bio
                        .text
                        .trim(),
                    // imageId.toString(),
                    gallery.imageFile);
              }
            },
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              semanticContainer: true,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(ScreenUtil().radius(23))),
              ),
              child: Stack(
                children: [
                  widget.image != null
                      ? Image.network(
                          widget.image,
                          fit: BoxFit.fill,
                          height: ScreenUtil().setHeight(100),
                          width: ScreenUtil().setWidth(100),
                        )
                      : provider.imageFile != null
                          ? Image(
                              height: ScreenUtil().setHeight(100),
                              width: ScreenUtil().setHeight(100),
                              fit: BoxFit.fill,
                              image: FileImage(
                                provider.imageFile,
                              ),
                            )
                          : widget.gendre == "Male" || widget.gendre == "ذكر"
                              ? Image.asset(
                                  boy,
                                  fit: BoxFit.fill,
                                  height: ScreenUtil().setHeight(100),
                                  width: ScreenUtil().setWidth(100),
                                )
                              : Image.asset(
                                  girl,
                                  fit: BoxFit.fill,
                                  height: ScreenUtil().setHeight(100),
                                  width: ScreenUtil().setWidth(100),
                                ),
                  Container(
                    height: ScreenUtil().setHeight(100),
                    width: ScreenUtil().setWidth(100),
                    color: black.withOpacity(0.3),
                    child: Center(
                      child: Text(
                        tr("edit"),
                        style: TextStyle(
                            color: white,
                            fontFamily: mainFont,
                            fontSize: dataFontSize),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              SvgPicture.asset(
                like,
                height: ScreenUtil().setHeight(20),
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),
              Text(
                tr("likes"),
                style: TextStyle(
                  color: textColor,
                  fontFamily: mainFont,
                  fontSize: smallFontSize,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),
              Text(
                '${widget.likeCount}',
                style: TextStyle(
                  color: textColor,
                  fontFamily: mainFont,
                  fontSize: smallFontSize,
                ),
              ),
            ],
          ),
          Column(
            children: [
              SvgPicture.asset(
                phone,
                height: ScreenUtil().setHeight(20),
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),
              Text(
                tr('calls'),
                style: TextStyle(
                  color: textColor,
                  fontFamily: mainFont,
                  fontSize: smallFontSize,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),
              Text(
                '${widget.callCount}',
                style: TextStyle(
                  color: textColor,
                  fontFamily: mainFont,
                  fontSize: smallFontSize,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _nationButton() {
    double width = MediaQuery.of(Get.context).size.width;
    return Padding(
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(35),
          right: ScreenUtil().setWidth(35),
        ),
        child: Container(
          width: width,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[300],
              ),
            ),
          ),
          child: NationDropdown(),
        ));
  }
}
