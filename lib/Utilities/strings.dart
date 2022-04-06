import 'dart:async';

import 'package:connectivity_plus_platform_interface/src/enums.dart';
import 'package:flutter/material.dart';

mixin Strings {
  static String authToken = '';
  static Color colorQuestion = const Color(0xffff8a65);
  static Color textColor = Colors.black.withOpacity(.7);

  static var editprofile = false;

  static StreamSubscription<ConnectivityResult>? connectivitySubscription ;

  static int? user_id;

  static String? data_name;

  static String? data_designation;

  static String? data_experience;

  static String? data_email;

  static String? data_mobile;

  static String? data_interests;
}
