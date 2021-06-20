import 'package:discussion/models/user_model.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/tools/design_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class HomeViews extends StatelessWidget {
  final String token;
  HomeViews({this.token});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
        future: getUser(token),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<User> data = snapshot.data;
            print(snapshot.data[0].name);
            return _profileListView(context, data);
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Card(
                child: Container(
                  height: ScreenUtil().setHeight(150),
                  width: ScreenUtil().setWidth(250),
                  child: Center(
                    child: Text('${snapshot.error}'),
                  ),
                ),
              ),
            );
          }
          print('home: ${snapshot.data}');
          print('error ${snapshot.error}');
          return Loading();
        });
  }

  _profileListView(context, data) {
    return Padding(
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(35),
        right: ScreenUtil().setWidth(35),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SvgPicture.asset(
                crown,
                height: ScreenUtil().setHeight(20),
                fit: BoxFit.contain,
              ),
              CircleAvatar(
                backgroundImage: data[0].image == null
                    ? AssetImage(example)
                    : NetworkImage(data[0].image),
                radius: ScreenUtil().radius(50),
              ),
            ],
          ),
          Column(
            children: [
              LimitedBox(
                maxHeight: data[0].bio == null
                    ? ScreenUtil().setHeight(40)
                    : ScreenUtil().setHeight(150),
                maxWidth: ScreenUtil().setWidth(130),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${data[0].name}",
                        softWrap: true,
                        style: TextStyle(
                            color: mainColor,
                            fontFamily: mainFont,
                            fontSize: packageFontSize,
                            fontWeight: FontWeight.w700)),
                    data[0].bio == null
                        ? Container()
                        : Text('${data[0].bio}',
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              color: mainColor,
                              fontFamily: mainFont,
                              fontSize: infoFontSize,
                            )),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(45),
              ),
              Padding(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(20.0)),
                child: Row(
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(like),
                        SizedBox(
                          height: ScreenUtil().setHeight(4),
                        ),
                        Text("${data[0].likeCount}",
                            style: TextStyle(
                              color: mainColor,
                              fontFamily: mainFont,
                              fontSize: buttonFontSize,
                            )),
                      ],
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(50),
                    ),
                    Column(
                      children: [
                        SvgPicture.asset(phone),
                        SizedBox(
                          height: ScreenUtil().setHeight(4),
                        ),
                        Text("${data[0].callCount}",
                            style: TextStyle(
                              color: mainColor,
                              fontFamily: mainFont,
                              fontSize: buttonFontSize,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
