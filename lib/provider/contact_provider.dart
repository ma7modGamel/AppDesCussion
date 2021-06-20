import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactProvider extends ChangeNotifier {
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
      throw 'Could not launch $url';
    }
  }
}
