import 'package:discussion/provider/contact_provider.dart';
import 'package:discussion/services/api_services/profile_helper.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/tools/design_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactScreenState();
  }
}

class ContactScreenState extends State<ContactScreen> {
  ProfileHelper profileHelper = ProfileHelper();
  var contact;
  bool _isLoad = true;

  _getContact() {
    profileHelper.getContact().whenComplete(() {
      setState(() {
        contact = profileHelper.info;
        _isLoad = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          tr("call"),
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
      body: _isLoad == true ? AppLoading() : _contactListView(context),
    );
  }

  _contactListView(context) {
    return Consumer<ContactProvider>(
      builder: (
        final BuildContext context,
        final ContactProvider provider,
        final Widget child,
      ) {
        double width = MediaQuery.of(context).size.width;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text('contactMessage'.tr(),textAlign: TextAlign.center,style: TextStyle(
                    fontSize: 20,fontFamily: mainFont
                ),),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text('webMessage'.tr(),textAlign: TextAlign.center,style: TextStyle(
                    fontSize: 17,fontFamily: mainFont
                ),),
              ),

              InkWell(
                  onTap: () {
                    provider.launchURL(contact["website"]);
                  },
                  child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 0),
                          height: 34,width: 34,
                          alignment: Alignment.topRight,
                          decoration: BoxDecoration(

                            image: DecorationImage(image:
                            AssetImage(website)
                                ,fit: BoxFit.fill),
                            borderRadius: BorderRadius.all(Radius.circular(17)),
                            border: Border.all(color: Colors.white,width: 1),


                          ),

                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(15),
                        ),
                        Text(
                          '${contact["website"]}',
                          style: TextStyle(
                            color: mainColor,
                            fontFamily: mainFont,
                            fontSize: fontSize,
                          ),
                        )]),),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text('phoneMessage'.tr(),textAlign: TextAlign.center,style: TextStyle(
                    fontSize: 17,fontFamily: mainFont
                ),),
              ),
              _phoneData(),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Container(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text('contactThroughSocial'.tr(),textAlign: TextAlign.center,style: TextStyle(
                    fontSize: 17,fontFamily: mainFont
                ),),
              ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _socialButton(
                          onTap: () {
                            provider.launchURL(contact["facebook"]);
                          },
                          image: facebook,
                        ),
                        _socialButton(
                          onTap: () {
                            provider.launchURL(contact["twitter"]);
                          },
                          image: twitter,
                        ),
                        _socialButton(
                          onTap: () {
                            provider.launchURL(contact["instagram"]);
                          },
                          image: instagram,
                        ),
                        _socialButton(
                          onTap: () {
                            provider.launchURL(contact["snapchat"]);
                          },
                          image: snapchat,
                        ),
                        _socialButton(
                          onTap: () {
                            provider
                                .launchURL('https://wa.me/${contact["whatsapp"]}');
                          },
                          image: whatsapp,
                        ),
                      ],
                    ),

                  ],
                )
              ),

              Container(
                margin: EdgeInsets.only(top: 10),
                child: Image.asset("assets/images/company.png",width: 100,height: 100,),
              )
            ],
          ),
        );
      },
    );
  }

  _phoneData() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
          LimitedBox(
            maxHeight: ScreenUtil().setHeight(100000),
            maxWidth: ScreenUtil().setWidth(150),
            child: ListView.builder(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                itemCount: contact["phones"].length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 0),
                              height: 34,width: 34,
                              alignment: Alignment.topRight,
                              decoration: BoxDecoration(

                                image: DecorationImage(image:
                                AssetImage(telefone)
                                    ,fit: BoxFit.fill),
                                borderRadius: BorderRadius.all(Radius.circular(17)),
                                border: Border.all(color: Colors.white,width: 1),


                              ),

                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(15),
                            ),
                            Text(
                              '${contact["phones"][index]}',
                              style: TextStyle(
                                color: mainColor,
                                fontFamily: mainFont,
                                fontSize: fontSize,
                              ),
                            )]),
                    ),
                    onTap: (){
                       launch("tel:${contact["phones"][index]}");
                    },
                  );
                }),
      ),
    );
  }

  _socialButton({VoidCallback onTap, String image}) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(bottom: 0),
        height: 44,width: 44,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(

          image: DecorationImage(image:
          AssetImage(image)
              ,fit: BoxFit.fill),
          borderRadius: BorderRadius.all(Radius.circular(22)),
          border: Border.all(color: Colors.white,width: 1),


        ),

      ),
      onTap: onTap,
    );
  }
}
