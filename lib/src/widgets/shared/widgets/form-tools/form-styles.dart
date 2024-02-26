import 'package:flutter/material.dart';

final OutlineInputBorder myinputborder = const OutlineInputBorder(
    //Outline border type for TextFeild
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(
      color: Colors.redAccent,
      width: 3,
    ));

final OutlineInputBorder myfocusborder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(
      color: Colors.greenAccent,
      width: 3,
    ));

Stack containerWithLabel({required Widget body, required String label}) =>
    Stack(children: [
      Container(
          margin: const EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: Colors.redAccent, width: 3),
          ),
          child: body),
      Container(
          margin: const EdgeInsets.only(top: 1, left: 12),
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(color: Colors.white),
          child: Text(label))
    ]);
