import 'package:discussion/provider/profile_provider.dart';
import 'package:discussion/tools/app_components.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/tools/design_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController _searchController = TextEditingController();
  ProfileProvider profileProvider;

  @override
  void initState() {


    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
  }


  @override
  void dispose() {
    //profileProvider.search(null);
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
          Container(
            margin: EdgeInsets.only(bottom: 12,right: MediaQuery.of(context).size.width*.27,left: MediaQuery.of(context).size.width*.27),
            child: SizedBox(

              width: MediaQuery.of(context).size.width*.27,
              child: RaisedButton(onPressed: (){
                if(_searchController.text.isNotEmpty)
                  profileProvider.getCallers(_searchController.text);
              },

                child:Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(tr("searchNow"),
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,fontFamily: mainFont,color: Colors.white),).tr(),
                  ],
                )
                ,padding: EdgeInsets.all(0),color: mainColor,shape: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(17)),
                    borderSide: BorderSide.none),),
            ),
          ),
          profileProvider.callersLoading?
          AppLoading():
              profileProvider.callers == null || profileProvider.callers.length<=0?
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
                      child: new Center(
                        child: Text(
                          tr("noSearch"),
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
        itemCount: profileProvider.callers.length,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
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
                              backgroundImage: profileProvider.callers[index]["image"] != null?NetworkImage(
                                profileProvider.callers[index]["image"].contains("http")?profileProvider.callers[index]["image"]:serverdomain+"/"+profileProvider.callers[index]["image"],
                  )
                        : profileProvider.callers[index]["gender"]['id'] == 1 ? AssetImage(boy)
                      : AssetImage(girl),
                              radius: ScreenUtil().radius(25),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(6),
                            ),


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
                                  '${profileProvider.callers[index]['name']}',
                                  overflow: TextOverflow.visible,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: mainColor,
                                    fontFamily: mainFont,
                                    fontSize: fontSize,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              child: Icon(Icons.call,
                                  color: Colors.green,
                                  size: ScreenUtil().setWidth(30)),
                              onTap: (){
                                profileProvider.call(profileProvider.callers[index]['id'].toString(), context);
                              },
                            )

                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            /*onTap: (){
              showUserPopUp(context,
                  profileProvider.calls[index]['firstuser']!=profileProvider.id?profileProvider.calls[index]['firstuser']:profileProvider.calls[index]['seconduser']);
            },*/
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
