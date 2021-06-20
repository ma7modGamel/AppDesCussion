import 'package:easy_localization/easy_localization.dart';

class Subscription{
  var id;
  var package_id;
  var end_at;
  var created_at;
  var expiredDays;
  var restDays;
  DateTime endDateAsDate;
  DateTime creationAsDate;
  bool isEnded=false;
  var package;

  static mapToObject(json){
    Subscription sub=Subscription();
    sub.id=json['id'];
    sub.package_id=json['package_id'];
    sub.package=json['package'];
    sub.end_at=json['end_at'];
    sub.created_at=json['created_at'].toString().substring(0,10);
    sub.creationAsDate=mapStringToDateTime(sub.created_at);
    sub.endDateAsDate=mapStringToDateTime(sub.end_at);
    sub.isEnded=DateTime.now().isAfter(sub.endDateAsDate);
    var total =sub.endDateAsDate.difference(sub.creationAsDate).inDays;
    if(sub.isEnded){
      sub.restDays=0;
      sub.expiredDays=total;
    }else{
      sub.restDays=total-(DateTime.now().difference(sub.creationAsDate).inDays);
      sub.expiredDays=DateTime.now().difference(sub.creationAsDate).inDays;
    }
    return sub;
  }

  static mapStringToDateTime(String date){
    if(date != null){
      //date="2018-01-04";
      var format = DateFormat('yyyy-MM-dd',"en");
      var newDate=format.parse(date);
      print(newDate.isUtc);
      return newDate;
    }
    return null;
  }
}