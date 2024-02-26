import 'dart:io';

import 'package:flutter/material.dart';

AppBar CustomAppBar({required String title, List<Widget>? actions}) {
  return AppBar(title: Text(title), actions: actions);
}
