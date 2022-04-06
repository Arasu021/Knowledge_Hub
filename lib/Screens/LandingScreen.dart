import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skein_community/Screens/dashboard2.dart';
import 'package:skein_community/Screens/empty.dart';
import 'package:skein_community/Screens/login.dart';
import 'package:skein_community/Screens/signUp.dart';
import 'package:skein_community/Screens/stepperPage.dart';
import 'package:skein_community/Utilities/strings.dart';
import 'package:skein_community/functions/functions.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  void initState() {
    super.initState();
    functions.checkConnectivity();
    //fcmtoken();
    // WidgetsBinding.instance!.addPostFrameCallback((_) => fcmtoken());
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Are you sure you want to exit?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  FlatButton(
                    child: Text('Yes, exit'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            });

        return value == true;
      },
      child: Scaffold(
        body: Container(
          height: media.height * 1,
          width: media.width * 1,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: Container(
                decoration: BoxDecoration(color: Colors.grey.shade300),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: media.height * 0.34,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Knowledge Hub.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                      ),
                      SizedBox(
                        height: media.height * 0.05,
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: media.height * 0.05,
            ),
            Container(
              width: media.width * 0.6,
              child: TextButton(
                onPressed: () {
                  Get.to(() => LoginPage());
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.orange)))),
                child: Text(
                  ('Sign In'),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.orange,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: media.height * 0.05,
            ),
            Container(
              width: media.width * 0.6,
              child: TextButton(
                onPressed: () {
                  Strings.editprofile == false;
                  Get.off(() => StepperDemo());
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.orange)))),
                child: Text(
                  ('Create Account'),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.orange,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: media.height * 0.05,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                onPressed: () {
                  // Get.to(() => SignUpPage());
                },
                child: Text(
                  ("fb"),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.orange,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  primary: Colors.grey.shade200,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  //  Get.to(() => MyCustomWidget());
                },
                child: Text(
                  ("in"),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.orange,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  primary: Colors.grey.shade200,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  // User? user = await signInWithGoogle(context: context);
                  // if (user != null) {
                  // Get.off(() => const rolePage());
                  // }
                },
                child: Text(
                  ("g+"),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.orange,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  primary: Colors.grey.shade200,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  //Get.off(() => MyAppPage());
                },
                child: Text(
                  ("tw"),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.orange,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  primary: Colors.grey.shade200,
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
