import 'package:discussion/provider/base_provider.dart';
import 'package:discussion/provider/dropdownbuttons_provider.dart';
import 'package:discussion/screens/auth_screens/login_screen.dart';
import 'package:discussion/screens/main_screens/main_screen.dart';
import 'package:discussion/services/api_services/auth_helper.dart';
import 'package:discussion/services/local_services/shared_prefrences.dart';
import 'package:discussion/tools/design_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AuthProvider extends BaseProvider {
  AuthHelper authHelper = AuthHelper();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  String errorMessage;
  String _token;

  void login() {
    setState(ProviderState.Loading);
    authHelper
        .loginData(name.text.trim(), password.text.trim())
        .whenComplete(() {
      if (authHelper.status == true) {
        showToast(msg: 'مرحبًا بك');
        Get.to(() => MainScreen(
              number: 0,
            ));
      } else {
        errorMessage = authHelper.msgStatus;
        showToast(msg: errorMessage);
        setState(ProviderState.Initial);
      }
    });
  }

  void register() {
    final gendre = Provider.of<GendreProvider>(Get.context, listen: false);
    final country = Provider.of<NationProvider>(Get.context, listen: false);
    setState(ProviderState.Loading);
    authHelper
        .registerData(name.text.trim(), email.text.trim(), password.text.trim(),
            gendre.id, country.id, phone.text.trim())
        .whenComplete(() {
      if (authHelper.status == true) {
        showToast(msg: 'مرحبًا بك');
        Get.to(() => MainScreen(
              number: 0,
            ));
      } else {
        errorMessage = authHelper.msgStatus;
        showToast(msg: errorMessage);
        setState(ProviderState.Initial);
      }
    });
  }

  void logout() {
    setState(ProviderState.Loading);
    authHelper.logoutData().whenComplete(() {
      //if (authHelper.status == true) {
        showToast(msg: 'إلى اللقاء');
        Get.to(() => LoginScreen());
      //}
    });
  }

  get token {
    return this._token;
  }

  set token(SharedPrefService databaseHelper) {
    databaseHelper.getValue('token');
    this._token = databaseHelper.value;
    print('provider: ${this._token}');
    notifyListeners();
  }
}
