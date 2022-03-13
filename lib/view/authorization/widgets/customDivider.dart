// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
        child: const Divider(
          indent: 40,
          endIndent: 10,
          color: Colors.black,
          height: 36,
        ));
  }
}
