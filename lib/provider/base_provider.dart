import 'package:flutter/cupertino.dart';

enum ProviderState { Initial, Loading, Loaded, Empty, HasError }

class BaseProvider<P> extends ChangeNotifier {
  void Function() refresh;
  ProviderState state = ProviderState.Initial;
  void setState(ProviderState state) {
    this.state = state;
    notifyListeners();
  }
}