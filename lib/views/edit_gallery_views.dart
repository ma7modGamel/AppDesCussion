import 'package:discussion/models/gallery_model.dart';
import 'package:discussion/provider/gallery_provider.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/tools/design_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditGalleryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Gallery>>(
        future: getGallery(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Gallery> data = snapshot.data;
            print(snapshot.data);
            return _nationListView(context, data);
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Card(
                child: Container(
                  height: ScreenUtil().setHeight(150),
                  width: ScreenUtil().setWidth(250),
                  child: Center(
                    child: Text(tr('error_connection')),
                  ),
                ),
              ),
            );
          }
          print(snapshot.connectionState);
          print(snapshot.data);
          return Loading();
        });
  }

  _nationListView(context, data) {
    return Consumer<GalleryProvider>(
      builder: (
        final BuildContext context,
        final GalleryProvider provider,
        final Widget child,
      ) {
        return ListView.builder(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                provider.removeImg(data[index].id,index,data);
              },
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                semanticContainer: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(ScreenUtil().setWidth(8)),
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: ScreenUtil().setHeight(110),
                      width: ScreenUtil().setWidth(95),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(data[index].image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(110),
                      width: ScreenUtil().setWidth(95),
                      color: Colors.black.withOpacity(.3),
                      child: Center(
                        child: Text(
                          tr("remove"),
                          style: TextStyle(
                              color: Colors.red,
                              fontFamily: mainFont,
                              fontSize: dataFontSize),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
