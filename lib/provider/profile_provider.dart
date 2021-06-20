import 'dart:io';
import 'package:discussion/models/subscription.dart';
import 'package:discussion/provider/base_provider.dart';
import 'package:discussion/screens/main_screens/profile_screen.dart';
import 'package:discussion/screens/packages_screens/packages_screen.dart';
import 'package:discussion/services/api_services/package_helper.dart';
import 'package:discussion/services/api_services/profile_helper.dart';
import 'package:discussion/tools/app_components.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/tools/design_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileProvider extends BaseProvider {
  ProfileHelper profileHelper = ProfileHelper();
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();
  bool callsLoading=true;
  Subscription subscription;
  var currentIserId;
  var id;
  var calls=[];
  ProfileProvider() {
    profileHelper.getProfile().whenComplete(() {
      print("errrrrrrrrrrr");
      name.text = profileHelper.info["data"]["user"]["name"];
      bio.text = profileHelper.info["data"]["user"]["bio"];
      id = profileHelper.info["data"]["user"]["id"];
    });
  }

  void editProfile(
      int id, String name, int country, int gendre, String bio, File image) {
    setState(ProviderState.Loading);
    profileHelper
        .editProfile(id, name, country, gendre, bio, image)
        .whenComplete(() {
      showToast(msg: profileHelper.msgStatus);
      print('edit: ${profileHelper.msgStatus}');
      Get.to(() => ProfileScreen());
    });
  }

  void addImage(File image) {
    setState(ProviderState.Loading);
    profileHelper.addImage(image).whenComplete(() {
      showToast(msg: profileHelper.msgStatus);
      // Get.to(() => ProfileScreen());
    });
  }

  getCalls()async{
    await profileHelper.getProfile();
    id=profileHelper.info["data"]["user"]["id"];
    print("######");
    var res=await ProfileHelper.getCalls(id);
    if(res != null && res['success']){
      calls=res['calls'];
    }
    callsLoading=false;
    notifyListeners();
  }

  subscribe(packageId)async{
    await profileHelper.getProfile();
    id=profileHelper.info["data"]["user"]["id"];
    var res=await PackageHelper.subscribe(id,packageId);
    if(res != null && res['success']){
    }
    await getCurrentSub();
    notifyListeners();
  }

  getCurrentSub()async{
    await profileHelper.getProfile();
    id=profileHelper.info["data"]["user"]["id"];
    subscription=await PackageHelper.getCurrentSub(id);
    notifyListeners();
  }

  showLikeDialog(context)async{
    print("####");
    if(currentIserId != null){
      print("####");
      showDialog(context: context, builder: (_)=>AlertDialog(
        backgroundColor: Colors.white,
        content: Container(
          height: MediaQuery.of(context).size.height/3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text("evaluateCall",style: TextStyle(color: Colors.black.withOpacity(.5),fontFamily: mainFont,fontSize: 20,fontWeight: FontWeight.bold),).tr(),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: FlatButton(onPressed: ()async{
                  await ProfileHelper.addLike(currentIserId.toString());
                  Navigator.pop(context);
                }, child: SvgPicture.asset(
                  like,
                  height: 50,
                  fit: BoxFit.fill,
                ),)
              ),

              subscription == null?
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text("forMoreFeatures",style: TextStyle(color: mainColor.withOpacity(.7),fontFamily: mainFont,fontSize: 20,),).tr(),
              ):Container(),

              subscription == null?
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: appButton(
                  sidePadding: 0,
                  buttonRadius: 15,
                  buttonText: tr("subscribe_now"),
                  buttonColor: Colors.red,
                  fontFamily: mainFont,
                  textColor: white,
                  textSize: 17,
                  isBold: false,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PackagesScreen()));
                  },
                ),
              ):Container()





            ],
          ),
        ),
        actions: [
          //FlatButton(onPressed: (){}, child: Text("close",style: TextStyle(color: Colors.red,fontFamily: mainFont)).tr()),
          //FlatButton(onPressed: (){}, child: Text("subscribe",style: TextStyle(color: Colors.green,fontFamily: mainFont)).tr()),
        ],
      ));
    }
  }
}


