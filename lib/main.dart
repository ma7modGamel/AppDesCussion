import 'dart:io';
import 'package:discussion/provider/auth_provider.dart';
import 'package:discussion/provider/bottomnavigationbar_provider.dart';
import 'package:discussion/provider/contact_provider.dart';
import 'package:discussion/provider/dropdownbuttons_provider.dart';
import 'package:discussion/provider/gallery_provider.dart';
import 'package:discussion/provider/intro_provider.dart';
import 'package:discussion/provider/load_provider.dart';
import 'package:discussion/provider/prefrences_provider.dart';
import 'package:discussion/provider/profile_provider.dart';
import 'package:discussion/screens/intro_screens/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android) {
    InAppPurchaseConnection.enablePendingPurchases();
  }
  runApp(EasyLocalization(
      supportedLocales: [Locale('ar'), Locale('en')],
      path: "assets/translate",
      saveLocale: true,
      startLocale: Locale('ar'),
      useOnlyLangCode: true,
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return ScreenUtilInit(
      designSize: Size(375, 812),
      allowFontScaling: true,
      builder: () => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoadProvider()),
          ChangeNotifierProvider(create: (_) => ContactProvider()),
          ChangeNotifierProvider(create: (_) => GalleryProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => PrefrencesProvider()),
          ChangeNotifierProvider(create: (_) => NationProvider()),
          ChangeNotifierProvider(create: (_) => IntroProvider()),
          ChangeNotifierProvider(create: (_) => GendreProvider()),
          ChangeNotifierProvider(create: (_) => LanguageProvider()),
          ChangeNotifierProvider(create: (_) => ProfileProvider()),
          ChangeNotifierProvider(create: (_) => BottomNavigationBarProvider()),
        ],
        child: GetMaterialApp(
          title: "Discussion",
          theme: ThemeData(
              primarySwatch: Colors.blue,
              buttonColor: Colors.blue,
          ),
          defaultTransition: Transition.upToDown,
          fallbackLocale: context.fallbackLocale,
          locale: context.locale,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          home: SplashScreen(),
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
