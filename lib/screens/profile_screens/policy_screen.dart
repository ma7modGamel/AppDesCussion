import 'package:discussion/services/api_services/profile_helper.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/tools/design_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PolicyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PolicyScreenState();
  }
}

class PolicyScreenState extends State<PolicyScreen> {
  ProfileHelper profileHelper = ProfileHelper();
  var policy;
  bool _isLoad = true;

  _getPolicy() {
    profileHelper.getPolicy().whenComplete(() {
      setState(() {
        policy = profileHelper.info;
        _isLoad = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getPolicy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          tr("terms"),
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
      body: _isLoad == true ? AppLoading() : _policyListView(context),
    );
  }

  _policyListView(context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text(policy["content"],
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: mainFont,
                    fontSize: 20,
                    fontWeight: FontWeight.normal)),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          // GestureDetector(
          //     onTap: provider.launchURL(Policy["website"]), child: Logo()),
          // SizedBox(
          //   height: ScreenUtil().setHeight(30),
          // ),
          // // _phoneData(),
          // SizedBox(
          //   height: ScreenUtil().setHeight(30),
          // ),
          // Container(
          //   width: width,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       _socialButton(
          //         onTap: provider.launchURL(Policy["facebook"]),
          //         image: facebook,
          //       ),
          //       _socialButton(
          //         onTap: provider.launchURL(Policy["twitter"]),
          //         image: twitter,
          //       ),
          //       _socialButton(
          //         onTap: provider.launchURL(Policy["instagram"]),
          //         image: instagram,
          //       ),
          //       _socialButton(
          //         onTap: provider.launchURL(Policy["snapshot"]),
          //         image: snapchat,
          //       ),
          //       _socialButton(
          //         onTap: provider
          //             .launchURL('https://wa.me/${Policy["whatsapp"]}'),
          //         image: whatsapp,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  // _phoneData() {
  //   return Column(
  //     children: [],
  //   );
  // }

  _socialButton({VoidCallback onTap, String image}) {
    return Padding(
      padding: EdgeInsets.only(
        right: ScreenUtil().setWidth(6),
        left: ScreenUtil().setWidth(6),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Image.asset(
          image,
          fit: BoxFit.contain,
          height: ScreenUtil().setHeight(35),
        ),
      ),
    );
  }
}
