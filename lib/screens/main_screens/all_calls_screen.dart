import 'package:discussion/provider/profile_provider.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/tools/design_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AllCallsScreen extends StatefulWidget {
  @override
  _AllCallsScreenState createState() => _AllCallsScreenState();
}

class _AllCallsScreenState extends State<AllCallsScreen> {

  TextEditingController _searchController = TextEditingController();
  ProfileProvider profileProvider;

  @override
  void initState() {

    /*WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProfileProvider>(context, listen: true)
          .getCalls();
    });*/
  }

  @override
  Widget build(BuildContext context) {

    profileProvider= Provider.of<ProfileProvider>(context,listen: true);
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          tr("my_calls"),
          style: TextStyle(
              color: mainColor,
              fontFamily: mainFont,
              fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: mainColor),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: ListView(
        children: [

          Provider.of<ProfileProvider>(context, listen: false).subscription != null?Container(
            margin: EdgeInsets.only(top: 20),
            child:_searchBar()
          ):Container(),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          profileProvider.callsLoading?
          AppLoading():
              profileProvider.calls == null || profileProvider.calls.length<=0?
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
                      child: new Center(
                        child: Text(
                          tr("noCalls"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: mainFont,
                              fontSize: 18,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                  ):
          _callsList(),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
        ],
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(45), right: ScreenUtil().setWidth(45)),
      child: Container(
        height: ScreenUtil().setHeight(40),
        child: TextFormField(
          controller: _searchController,
          style:
              TextStyle(color: black, fontFamily: mainFont, fontSize: fontSize),
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[300],
                ),
                borderRadius:
                    BorderRadius.all(Radius.circular(ScreenUtil().radius(20))),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[300],
                ),
                borderRadius:
                    BorderRadius.all(Radius.circular(ScreenUtil().radius(20))),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[300],
                ),
                borderRadius:
                    BorderRadius.all(Radius.circular(ScreenUtil().radius(20))),
              ),
              filled: true,
              fillColor: Colors.grey[300],
              hintText: tr("search"),
              hintStyle: TextStyle(
                color: textColor,
                fontFamily: mainFont,
                fontSize: fontSize,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: textColor,
              )),
        ),
      ),
    );
  }

  _callsList() {
    double width = MediaQuery.of(context).size.height;
    return LimitedBox(
      maxWidth: width,
      maxHeight: ScreenUtil().setHeight(100000),
      child: ListView.builder(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        itemCount: profileProvider.calls.length,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          var anotherUser=profileProvider.calls[index]['firstuser']['id']!=profileProvider.id?profileProvider.calls[index]['firstuser']:profileProvider.calls[index]['seconduser'];
          return InkWell(
            child: Padding(
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(45),
                right: ScreenUtil().setWidth(45),
              ),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 1.0,
                semanticContainer: true,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(ScreenUtil().radius(8))),
                ),
                child: Container(
                  height: ScreenUtil().setHeight(100),
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: ScreenUtil().setWidth(10),
                      left: ScreenUtil().setWidth(10),
                    ),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: anotherUser["image"] != null?NetworkImage(
                    anotherUser["image"].toString().contains("http")?anotherUser["image"]:serverdomain+"/"+anotherUser["image"],
                  )
                        : anotherUser["gender_id"] == 1 ? AssetImage(boy)
                      : AssetImage(girl),
                              radius: ScreenUtil().radius(25),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(6),
                            ),
                            anotherUser["package_id"] == null?
                            Container():
                            anotherUser["package_id"] != 4?
                            SvgPicture.asset(
                              anotherUser["package_id"]==3?crown:
                              anotherUser["package_id"] == 2?stars:star,
                              height: ScreenUtil().setHeight(15),
                              fit: BoxFit.contain,
                            ):Image.asset(stars3,height: ScreenUtil().setHeight(15),
                              fit: BoxFit.contain,),

                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(25),
                              right: ScreenUtil().setWidth(25)),
                          child: Container(
                            width: ScreenUtil().setWidth(100),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${profileProvider.calls[index]['firstuser']['id']!=profileProvider.id?profileProvider.calls[index]['firstuser']['name']:profileProvider.calls[index]['seconduser']['name']}',
                                  overflow: TextOverflow.visible,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: mainColor,
                                    fontFamily: mainFont,
                                    fontSize: fontSize,
                                  ),
                                ),
                                Text(
                                  '${mapDate(profileProvider.calls[index]['created_at'].toString().substring(0,10))}',
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: mainFont,
                                      fontSize: smallFontSize),
                                ),
                                Text(
                                  '${profileProvider.calls[index]['call_min']??''}',
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: mainFont,
                                      fontSize: fontSize),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.message,
                                color: mainColor,
                                size: ScreenUtil().setWidth(35)),
                            Text('${profileProvider.calls[index]['topic']['name'][Get.locale.languageCode]}',
                                style: TextStyle(
                                    color: mainColor,
                                    fontSize: fontSize,
                                    fontFamily: mainFont)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            onTap: (){
              showUserPopUp(context,
                  profileProvider.calls[index]['firstuser']!=profileProvider.id?profileProvider.calls[index]['firstuser']:profileProvider.calls[index]['seconduser']);
            },
          );
        },
      ),
    );
  }

  static mapDate( date){
    var dateformat = DateFormat('yyyy-MM-dd',"en");
    var newDate=dateformat.parse(date);
    var format = DateFormat('EEEE dd MMMM',Get.locale.languageCode);
    return format.format(newDate);
  }
}
