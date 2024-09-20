import 'package:flutter/material.dart';

class EditorsState {
  final List<Widget>? actions;
  final String? currentEditorTitle;
  final List<Widget>? persistentFooterButtons;

  EditorsState({this.actions, this.currentEditorTitle, this.persistentFooterButtons});
}