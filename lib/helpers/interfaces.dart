import 'package:flutter/material.dart';

abstract class IWithAppBar {
  final Widget appBar = null;
}

abstract class IWithNavigatorKey {
  Key navigatorKey;
}