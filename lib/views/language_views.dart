import 'package:discussion/provider/dropdownbuttons_provider.dart';
import 'package:discussion/services/local_services/shared_prefrences.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LanguageDropdown extends StatelessWidget {
  SharedPrefService databaseHelper = SharedPrefService();
  @override
  Widget build(final BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (
        final BuildContext context,
        final LanguageProvider language,
        final Widget child,
      ) {
        return Center(
          child: DropdownButtonHideUnderline(
              child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<String>(
              isExpanded: true,
              onChanged: (t) {
                language.name = t;
                databaseHelper.setValue('language', language.name);
              },
              value: language.name,
              items: language.languageList
                  .map<DropdownMenuItem<String>>((dynamic value) {
                return DropdownMenuItem<String>(
                    value: value["name"],
                    child: ListTile(
                      title: Text(value["name"],
                          style: TextStyle(
                            color: black,
                            fontFamily: mainFont,
                            fontSize: buttonFontSize,
                          )),
                      leading: Image.asset(
                        value["image"],
                        height: ScreenUtil().setHeight(30),
                        width: ScreenUtil().setWidth(30),
                        fit: BoxFit.contain,
                      ),
                    ));
              }).toList(),
            ),
          )),
        );
      },
    );
  }
}
