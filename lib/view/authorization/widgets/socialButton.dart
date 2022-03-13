// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget socialButton(String svg, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1.3, color: Colors.white)),
      child: SvgPicture.asset(
        svg,
        height: 40,
      ),
    ),
  );
}
