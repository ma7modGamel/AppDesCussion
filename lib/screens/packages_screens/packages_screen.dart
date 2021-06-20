import 'package:discussion/provider/profile_provider.dart';
import 'package:discussion/screens/packages_screens/package_screen.dart';
import 'package:discussion/services/api_services/package_helper.dart';
import 'package:discussion/tools/app_components.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/tools/design_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:getwidget/types/gf_progress_type.dart';
import 'package:provider/provider.dart';

class PackagesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PackagesScreenState();
  }
}

class PackagesScreenState extends State<PackagesScreen> {
  PackageHelper profileHelper = PackageHelper();
  var packages;
  bool _isLoad = true;
  int currentindex=0;

  _getPackages() {
    profileHelper.getPackages().whenComplete(() {
      setState(() {
        packages = profileHelper.info["data"];
        _isLoad = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getPackages();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProfileProvider>(context, listen: false)
          .getCurrentSub();
    });
  }

  ProfileProvider profileProvider;

  @override
  Widget build(BuildContext context) {

    profileProvider=Provider.of<ProfileProvider>(context, listen: true);
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          : Column(
        children: [
          Expanded(

            child: Container(

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(20)),
                  gradient: LinearGradient(colors: [Color(0xff3063A4),Colors.white,Colors.white],begin: Alignment.topRight,end: Alignment.bottomLeft,)
              ),
              child: ListView(
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  profileProvider.subscription != null?
                  _getCurrentPackge():Container(),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  /*_packagesTitle(),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  SvgPicture.asset(choice),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),*/
                  __packagesList(),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                ],
              ),
            )
          ),
        ],
      )
    );
  }
  
  _getCurrentPackge(){
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 20,right: 20),
        /*decoration: BoxDecoration(
          border: Border.all(width: 1,
              color: mainColor),
          color: Color(0xffFAFAFA),
          borderRadius: BorderRadius.circular(10),

        ),*/
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Container(
              margin: EdgeInsets.only(top: 7,bottom: 10),
              child: Row(

                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/p${profileProvider.subscription.package['id']}.png"),
                    radius: ScreenUtil().radius(25),
                  ),
                  Container(
                    //padding: EdgeInsets.only(top:10),
                    child: Text("انت الان على باقه  ",textAlign: TextAlign.center,style:TextStyle(fontFamily: mainFont,color: Colors.white,fontSize: 20,fontWeight: FontWeight.normal)),
                  ),
                  Container(
                    // padding: EdgeInsets.only(top:10),
                    child: Text("${profileProvider.subscription.package['name'][Get.locale.languageCode]}",textAlign: TextAlign.center,style:TextStyle(fontFamily: mainFont,color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),

            Container(
              margin: EdgeInsets.only(right: 0,left: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Column(
                    children: [

                      SizedBox(
                        width: 100,
                        height: 100,
                        child: GFProgressBar(
                            percentage: (profileProvider.subscription.restDays*100)/((profileProvider.subscription.expiredDays+profileProvider.subscription.restDays)*100),
                            width:90,
                            radius: 90,
                            lineHeight: 100,

                            type: GFProgressType.circular,
                            backgroundColor : Colors.white70,
                            child: Container(
                              width: 100,
                              height: 82,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(50))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Text("${profileProvider.subscription.restDays}",style:TextStyle(fontWeight: FontWeight.bold,fontFamily: mainFont,color: Color(0xff3063A4),fontSize: 17)),

                                  Container(
                                    margin: EdgeInsets.only(right: 0,left: 0,top: 0,bottom: 5),
                                    child:Text("يوم",style:TextStyle(fontWeight: FontWeight.bold,fontFamily: mainFont,color: Color(0xff3063A4),fontSize: 13)),
                                  ),


                                ],
                              ),
                            ),
                            alignment: MainAxisAlignment.end,
                            progressBarColor: Color(0xff3063A4),
                          circleWidth: 3,
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(right: 0,left: 0,top: 10,bottom: 5),
                        child:Text("المتبقي",style:TextStyle(fontWeight: FontWeight.normal,fontFamily: mainFont,color: Color(0xff3063A4),fontSize: 15)),
                      ),

                    ],
                  ),

                  Column(
                    children: [

                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Container(
                          //color: Colors.white,
                          child: GFProgressBar(
                            percentage: (profileProvider.subscription.expiredDays*100)/((profileProvider.subscription.expiredDays+profileProvider.subscription.restDays)*100),
                            width:90,
                            radius: 90,
                            lineHeight: 100,
                            type: GFProgressType.circular,
                            backgroundColor : Colors.white70,
                            child: Container(

                              width: 100,
                              height: 82,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(50))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Text("${profileProvider.subscription.expiredDays}",style:TextStyle(fontWeight: FontWeight.bold,fontFamily: mainFont,color: Color(0xff3063A4),fontSize: 17)),

                                  Container(
                                    margin: EdgeInsets.only(right: 0,left: 0,top: 0,bottom: 5),
                                    child:Text("يوم",style:TextStyle(fontWeight: FontWeight.bold,fontFamily: mainFont,color: Color(0xff3063A4),fontSize: 13)),
                                  ),

                                ],
                              ),
                            ),
                            alignment: MainAxisAlignment.end,
                            progressBarColor: Color(0xff3063A4),
                            circleWidth: 3,
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(right: 0,left: 0,top: 10,bottom: 5),
                        child:Text("المستهلك",style:TextStyle(fontWeight: FontWeight.normal,fontFamily: mainFont,color: Color(0xff3063A4),fontSize: 15)),
                      )

                    ],
                  )

                ],
              ),
            ),

            /*Container(
              margin: EdgeInsets.only(top: 7,bottom: 7),
              child: Row(

                children: [
                  Container(
                    //padding: EdgeInsets.only(top:10),
                    child: Text("باقي على الانتهاء  ",textAlign: TextAlign.center,style:TextStyle(fontFamily: mainFont,color: mainColor,fontSize: 17,fontWeight: FontWeight.normal)),
                  ),
                  Container(
                    // padding: EdgeInsets.only(top:10),
                    child: Text("${profileProvider.subscription.restDays}",textAlign: TextAlign.center,style:TextStyle(fontFamily: mainFont,color: mainColor,fontSize: 15,fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    //padding: EdgeInsets.only(top:10),
                    child: Text(" يوم",textAlign: TextAlign.center,style:TextStyle(fontFamily: mainFont,color: mainColor,fontSize: 17,fontWeight: FontWeight.normal)),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),*/

          ],
        )

    );
  }

  _packagesTitle() {
    return Center(
      //padding: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
      child: Container(
        //width: ScreenUtil().setWidth(140),
        child: Text(
          tr("choose_package"),
          softWrap: true,
          overflow: TextOverflow.visible,
          style: TextStyle(
              color: mainColor, fontFamily: mainFont, fontSize: 17),
        ),
      ),
    );
  }

  __packagesList() {
    double width = MediaQuery.of(Get.context).size.width;
    return Container(
      width: 300,
      height: MediaQuery.of(context).size.height/2,
      child: Column(
        children: [

          Expanded(
            child: Swiper(
              itemCount: packages.length,
              autoplay: false,
              viewportFraction: 0.5,
              onIndexChanged: (i){
                setState(() {

                  currentindex=i;
                });
              },
              scale: 0.7,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  semanticContainer: true,
                  //shadowColor: mainColor,
                  elevation: 0.0,
                  color: Colors.transparent,
                  /*shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(ScreenUtil().radius(8)),
              ),
              side: BorderSide(
                color: mainColor,
                width: ScreenUtil().setWidth(1),
              ),
            ),*/
                  child: Container(
                    height: ScreenUtil().setHeight(110),
                    width: ScreenUtil().setWidth(110),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 0),
                          height: 106,width: 106,
                          alignment: Alignment.topRight,
                          decoration: BoxDecoration(

                              image: DecorationImage(image:
                              AssetImage("assets/images/p${packages[index]["id"]}.png")
                                  ,fit: BoxFit.fill),
                              borderRadius: BorderRadius.all(Radius.circular(53)),
                              border: Border.all(color: mainColor,width: 2),
                              boxShadow: [
                                BoxShadow(color: Color(0xff00000029),blurRadius: 6,offset: Offset(0, 6)),
                                BoxShadow(color: Color(0xff00000029),blurRadius: 6,offset: Offset(0, 6)),
                                BoxShadow(color: Color(0xff00000029),blurRadius: 6,offset: Offset(0, 6)),
                                BoxShadow(color: Color(0xff00000029),blurRadius: 6,offset: Offset(0, 6))
                              ]

                          ),),
                        Center(
                          child: Text(
                            packages[index]["name"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: mainColor,
                                fontFamily: mainFont,
                                fontSize: titleFontSize),
                          ),
                        ),




                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: Text(
              'يمكنك ترقيه حسابك والحصول علي افضل النتائج',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: mainColor,
                  fontFamily: mainFont,
                  fontSize: 15),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 25,bottom: 0,left: 20,right: 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(45),color:
            Color(0xff3063A4)),
            child: FlatButton(onPressed: (){
              Get.to(() => PackageScreen(
                id: packages[currentindex]["id"],
              ));
            },child: Column(
              children: [
                Text("اشترك الان",

                  style: TextStyle(color: Colors.white,fontSize: 19,fontFamily: mainFont,fontWeight: FontWeight.normal),
                ),
                Text("${packages[currentindex]["name"]}/ ${packages[currentindex]["currency"]} ${packages[currentindex]["price"]}",

                  style: TextStyle(color: Colors.white,fontSize: 19,fontFamily: mainFont,fontWeight: FontWeight.normal),
                )
              ],
            ),
              padding: EdgeInsets.all(0),
            ),
          ),


        ],
      )
    );
  }
}
