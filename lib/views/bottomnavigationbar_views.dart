import 'package:discussion/provider/bottomnavigationbar_provider.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final btmBar = Provider.of<BottomNavigationBarProvider>(context);
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 2.0,
      clipBehavior: Clip.antiAlias,
      color: white,
      elevation: 2.0,
      child: BottomNavigationBar(
          currentIndex: btmBar.selectedIndex,
          onTap: (index) {
            btmBar.selectedIndex = index;
          },
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
              fontFamily: mainFont,
              fontWeight: FontWeight.bold,
              fontSize: smallFontSize),
          unselectedLabelStyle: TextStyle(
              fontFamily: mainFont,
              fontWeight: FontWeight.bold,
              fontSize: smallFontSize),
          items: [
            BottomNavigationBarItem(
              label: ' ',
              icon: Column(
                children: [
                  SvgPicture.asset(house,
                      height: ScreenUtil().setHeight(25), fit: BoxFit.contain),
                  SizedBox(
                    height: ScreenUtil().setHeight(5),
                  ),
                  Icon(
                    Icons.circle,
                    size: ScreenUtil().setWidth(4),
                    color: btmBar.selectedIndex == 0 ? mainColor : Colors.transparent,
                  )
                ],
              ),
            ),
            BottomNavigationBarItem(
              label: ' ',
              icon: Column(
                children: [
                  SvgPicture.asset(man,
                      height: ScreenUtil().setHeight(25), fit: BoxFit.contain),
                  SizedBox(
                    height: ScreenUtil().setHeight(5),
                  ),
                  Icon(
                    Icons.circle,
                    size: ScreenUtil().setWidth(5),
                    color: btmBar.selectedIndex == 1 ? mainColor : Colors.transparent,
                  )
                ],
              ),
            ),
          ]),
    );
  }
}
