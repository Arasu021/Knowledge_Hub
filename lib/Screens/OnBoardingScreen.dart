import 'dart:async';
import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skein_community/Screens/LandingScreen.dart';
import 'package:skein_community/Screens/dashboard2.dart';
import 'package:skein_community/Utilities/strings.dart';
import 'package:skein_community/network/ApiService.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool _a = false;

  BuildContext? ctx;

  @override
  void initState() {
    super.initState();

    // getProfile();
    Timer(Duration(milliseconds: 700), () {
      setState(() {
        _a = !_a;
      });
    });
    Timer(Duration(milliseconds: 2000), () {
      Refreshid();
      // Navigator.of(context)
      //     .pushReplacement(SlideTransitionAnimation(SecondScreen()));
    });
  }

  // getProfile() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   Strings.authToken = sharedPreferences.getString("token")!;
  //   int? user_id = sharedPreferences.getInt("user_id");
  //   final api = Provider.of<ApiService>(ctx!, listen: false);
  //   api.getUser(user_id!).then((response) {
  //     print("response ${response.status}");
  //     if (response.status == true) {
  //       Strings.myprofile = response.data;
  //     }
  //   }).catchError((onError) {
  //     print(onError.toString());
  //   });
  // }

  Future<void> Refreshid() async {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      // var user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('User is currently signed out!');

        Navigator.of(context)
            .pushReplacement(SlideTransitionAnimation(SecondScreen()));
      } else {
        print("---User:$user");
        print('User is signed in!');
        Navigator.of(context)
            .pushReplacement(SlideTransitionAnimation(DashPage()));
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return FeedsPage1(newContext);
          }),
        ));
  }

  FeedsPage1(BuildContext context) {
    ctx = context;
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.orange,
      body: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 2000),
            curve: Curves.fastLinearToSlowEaseIn,
            width: _a ? _width : 0,
            height: _height,
            color: Colors.white,
          ),
          Center(
            child: Text(
              'Knowledge Hub',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SlideTransitionAnimation extends PageRouteBuilder {
  final Widget page;

  SlideTransitionAnimation(this.page)
      : super(
            pageBuilder: (context, animation, anotherAnimation) => page,
            transitionDuration: Duration(milliseconds: 2000),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
              );
              return SlideTransition(
                position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                    .animate(animation),
                textDirection: TextDirection.rtl,
                child: page,
              );
            });
}

// class SecondPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: Text('HOME PAGE'),
//           centerTitle: true,
//           brightness: Brightness.dark,
//           backgroundColor: Colors.black),
//       body: Center(
//         child: Text(
//           "APP HOME PAGE",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//       ),
//     );
//   }
// }
