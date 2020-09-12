import 'package:gpp_app/util/size_config.dart';
import 'package:flutter/material.dart';

// Header lv1
final h1Style = TextStyle(
  fontSize: getBlockSizeHorizontal(10),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  // height: 1.5, // about text baseline
);

// Header lv2
final h2Style = TextStyle(
  fontSize: getBlockSizeHorizontal(7),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  // height: 1.5,
);

// Header lv3
final h3Style = TextStyle(
  fontSize: getBlockSizeHorizontal(5),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  // height: 1.5,
);

// Plain text
final pStyle = TextStyle(
  fontSize: getBlockSizeHorizontal(4),
  fontWeight: FontWeight.normal,
  color: Colors.black,
  // height: 1.5,
);

// Footer text
final footerStyle = TextStyle(
  fontSize: getBlockSizeHorizontal(3),
  fontWeight: FontWeight.normal,
  color: Colors.grey,
);

// Default Button
final defaultButtonStyle = TextStyle(
  fontSize: getBlockSizeHorizontal(4),
  fontWeight: FontWeight.normal,
  color: Colors.white,
);
