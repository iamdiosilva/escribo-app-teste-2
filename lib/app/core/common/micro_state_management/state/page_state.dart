import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controllers/base_controller.dart';

abstract class PageState<T extends StatefulWidget, C extends BaseController>
    extends State<T> {
  final C _controller = Modular.get<C>();

  C get controller => _controller;

  @override
  void initState() {
    super.initState();
    controller.init();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
