import 'package:flutter/material.dart';

Widget buildSection(String sectionTitle, List<Widget> body) {
  return Container(
      //width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(5),
      child: Card(
          child: Column(children: [
        Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            //width: MediaQuery.of(context).size.width,
            child: Text(
              sectionTitle,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16),
            )),
        ...body
      ])));
}