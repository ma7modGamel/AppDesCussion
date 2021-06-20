import 'dart:convert';
import 'dart:io';
import 'package:discussion/services/api_services/profile_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class GalleryProvider with ChangeNotifier {
  // List<Nations> _nations;
  String _image;
  int _id;
  int imageId;
  File imageFile;

  get image {
    return this._image;
  }

  get id {
    return this._id;
  }

  set image(String item) {
    this._image = item;
    notifyListeners();
  }

  set id(int item) {
    this._id = item;
    notifyListeners();
  }

  Future pickImage() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    print(base64Image);
    notifyListeners();
    return imageFile;
  }

  removeImg(id,index,data)async{
    var res=await ProfileHelper.deleteImage(id);
    data.removeAt(index);
    notifyListeners();

  }
}
