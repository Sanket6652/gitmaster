import 'package:flutter/foundation.dart';

class ScrollEventNotifier with ChangeNotifier {
  bool _isScrolling;
  ScrollEventNotifier( this._isScrolling);

  bool get isScrolling => _isScrolling;
  set isScrolling(bool scrollStatus) {
    _isScrolling = scrollStatus;
    notifyListeners();
  }
}
