import 'package:discussion/models/gendre_model.dart';
import 'package:discussion/provider/dropdownbuttons_provider.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/tools/design_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class GendreDropDown extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return FutureBuilder<List<Gendre>>(
        future: getGendre(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Gendre> data = snapshot.data;
            print(snapshot.data[0].name);
            return _gendreListView(context, data);
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

  _gendreListView(context, data) {
    return Consumer<GendreProvider>(builder: (
      final BuildContext context,
      final GendreProvider provider,
      final Widget child,
    ) {
      return Center(
        child: DropdownButtonHideUnderline(
            child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
            hint: ListTile(
              leading: Container(
                width: ScreenUtil().setWidth(40),
                child: Row(
                  children: [
                    SvgPicture.asset(male),
                    SvgPicture.asset(female),
                  ],
                ),
              ),
              title: Text(tr("gendre_button"),
                  style: TextStyle(
                    color: black,
                    fontFamily: mainFont,
                    fontSize: buttonFontSize,
                  )),
            ),
            isExpanded: true,
            onChanged: (t) {
              provider.name = t;
            },
            value: provider.name,
            items: data.map<DropdownMenuItem<String>>((dynamic value) {
              return DropdownMenuItem<String>(
                  onTap: () {
                    provider.id = value.id;
                    provider.name = value.name;
                    print(provider.id);
                    print(provider.name);
                  },
                  value: value.name,
                  child: ListTile(
                    title: Text(value.name,
                        style: TextStyle(
                          color: black,
                          fontFamily: mainFont,
                          fontSize: buttonFontSize,
                        )),
                    leading: Image.network(
                      value.image,
                      height: ScreenUtil().setHeight(30),
                      width: ScreenUtil().setWidth(30),
                      fit: BoxFit.contain,
                    ),
                  ));
            }).toList(),
          ),
        )),
      );
    });
  }
}
