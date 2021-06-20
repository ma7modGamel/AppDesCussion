import 'package:discussion/provider/bottomnavigationbar_provider.dart';
import 'package:discussion/provider/profile_provider.dart';
import 'package:discussion/screens/main_screens/all_calls_screen.dart';
import 'package:discussion/screens/main_screens/profile_screen.dart';
import 'package:discussion/services/local_services/shared_prefrences.dart';
import 'package:discussion/tools/app_constants.dart';
import 'package:discussion/views/bottomnavigationbar_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  final int number;
  MainScreen({this.number});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  SharedPrefService databaseHelper = SharedPrefService();
  List<Widget> _pageOption;
  Widget currentPage;
  HomeScreen home;
  ProfileScreen profile;

  @override
  void initState() {
    home = HomeScreen();
    profile = ProfileScreen();

    _pageOption = [
      home,
      profile,
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final btmBar = Provider.of<BottomNavigationBarProvider>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xffF4F0EC),
        body: _pageOption[btmBar.selectedIndex],
        extendBody: Device.get().hasNotch ? false : true,
        floatingActionButton: FloatingActionButton(
          backgroundColor: white,
          onPressed: () {
            Provider.of<ProfileProvider>(context, listen: false)
                .getCalls();
            Get.to(() => AllCallsScreen());
          },
          child: SvgPicture.asset(logo),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Device.get().hasNotch
            ? SafeArea(
                bottom: true,
                child: BottomNavigationBarView(),
              )
            : BottomNavigationBarView(),
      ),
    );
  }
}
