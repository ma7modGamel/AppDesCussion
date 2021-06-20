import 'package:discussion/models/nations_model.dart';
import 'package:discussion/provider/dropdownbuttons_provider.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/tools/design_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NationDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Nations>>(
        future: getNations(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Nations> data = snapshot.data;
            print(snapshot.data[0].name);
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
    return Consumer<NationProvider>(
      builder: (
        final BuildContext context,
        final NationProvider provider,
        final Widget child,
      ) {
        return Center(
          child: DropdownButtonHideUnderline(
              child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<String>(
              hint: ListTile(
                leading: SvgPicture.asset(building),
                title: Text(tr("country_button"),
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
                    ));
              }).toList(),
            ),
          )),
        );
      },
    );
  }
}
