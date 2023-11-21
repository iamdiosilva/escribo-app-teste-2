import 'package:flutter/cupertino.dart';

abstract class BaseController extends ChangeNotifier {
  void init();

  void get emit => notifyListeners();
}
