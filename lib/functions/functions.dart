import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skein_community/Models/Feeds/postFeedCommentReq.dart';
import 'package:skein_community/Screens/login.dart';
import 'package:skein_community/Utilities/strings.dart';
import 'package:skein_community/network/ApiService.dart';
import 'package:intl/intl.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
ConnectivityResult _connectionStatus = ConnectivityResult.none;
final Connectivity _connectivity = Connectivity();
// StreamSubscription<ConnectivityResult> _connectivitySubscription;

// // void signInwithEmail(email, pass) async {
// //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
// //   Map data = {'user_name': email, 'password': pass};
// //   String body = json.encode(data);
// //   var jsonResponse = null;
// //   final Uri url = Uri.parse(
// //       'https://6253748c-ff16-4430-a991-72faf7b9a7d0.mock.pstmn.io/users/login');
// //   final response = await http.post(url,
// //       headers: {"Content-type": "application/json"}, body: body);
// //   if (response.statusCode == 200) {
// //     jsonResponse = json.decode(response.body);
// //     print(response.body);
// //     print("-----" + response.statusCode.toString());
// //     if (jsonResponse['status'].toString() == "false") {
// //       Fluttertoast.showToast(
// //         msg: "" + jsonResponse['message'],
// //         toastLength: Toast.LENGTH_SHORT,
// //         gravity: ToastGravity.BOTTOM,
// //         timeInSecForIosWeb: 4,
// //         backgroundColor: Colors.indigo,
// //         textColor: Colors.white,
// //         // fontSize: 16.0
// //       );
// //       Get.to(() => LoginPage());
// //     } else if (jsonResponse != null) {
// //       // setState(() {
// //       //   _isLoading = false;
// //       // });
// //       sharedPreferences.setString("token", jsonResponse['token'].toString());
// //       //print(jsonResponse['token']);
// //       sharedPreferences.setString(
// //           "user_id", jsonResponse['user_id'].toString());
// //       print("Loged in successfully");

// //       // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => UserList()));
// //     } else {
// //       // setState(() {
// //       //   _isLoading = false;
// //       // });
// //       // errorMsg = response.body;
// //       // print("The error message is: ${response.body}");
// //     }
// //   }
// // }

// // void signUpwithEmail(name, email, mobile, pass) async {
// //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
// //   Map data = {
// //     'full_name': name,
// //     "email_id": email,
// //     "mobile_no": mobile,
// //     'password': pass
// //   };
// //   String body = json.encode(data);
// //   var jsonResponse = null;
// //   final Uri url = Uri.parse(
// //       'https://6253748c-ff16-4430-a991-72faf7b9a7d0.mock.pstmn.io/users/signup');
// //   final response = await http.post(url,
// //       headers: {"Content-type": "application/json"}, body: body);
// //   if (response.statusCode == 200) {
// //     jsonResponse = json.decode(response.body);
// //     print(response.body);
// //     print("-----" + response.statusCode.toString());
// //     if (jsonResponse['status'].toString() == "false") {
// //       Fluttertoast.showToast(
// //         msg: "" + jsonResponse['message'],
// //         toastLength: Toast.LENGTH_SHORT,
// //         gravity: ToastGravity.BOTTOM,
// //         timeInSecForIosWeb: 4,
// //         backgroundColor: Colors.indigo,
// //         textColor: Colors.white,
// //         // fontSize: 16.0
// //       );
// //       Get.to(() => LoginPage());
// //     } else if (jsonResponse != null) {
// //       // setState(() {
// //       //   _isLoading = false;
// //       // });
// //       sharedPreferences.setString("token", jsonResponse['token'].toString());
// //       //print(jsonResponse['token']);
// //       sharedPreferences.setString(
// //           "user_id", jsonResponse['user_id'].toString());
// //       print("Loged in successfully");

// //       // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => UserList()));
// //     } else {
// //       // setState(() {
// //       //   _isLoading = false;
// //       // });
// //       // errorMsg = response.body;
// //       // print("The error message is: ${response.body}");
// //     }
// //   }
// // }

// void signInwithEmail(email, pass) {
//   LoginReq loginreq = LoginReq();
//   loginreq.email = email;
//   loginreq.password = pass;
//   print('email ${loginreq.email}');
//   print('email ${loginreq.password}');
//   final api = Provider.of<ApiService>(context, listen: false);
//   api.login(loginreq).then((response) {
//     print('response ${response.status}');

//     if (response.status!) {
//       print("result:$response");
//     }
//   });
// }

class functions {
  static logout() async {
    /// Method to Logout the `FirebaseUser` (`_firebaseUser`)
    try {
      // signout code
      await FirebaseAuth.instance.signOut();
      final pref = await SharedPreferences.getInstance();
      int? name = pref.getInt("user_id");
      print("user:$name");
      await pref.clear();
      print("user:$name");
      Get.off(() => LoginPage());
    } catch (e) {
      print(e.toString());
    }
  }

  static void showprogress() {
    EasyLoading.show(status: 'loading...');

    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
    });
    // });
  }

  static void dismissDialog() {
    // print("dismissProgressDialog");
    // dismissProgressDialog();
    EasyLoading.dismiss();
  }

  static void showErrors(context, title, message, okTab) {
    dismissDialog();

    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      borderSide: BorderSide(color: Color(0xfff05043), width: 2),
      width: 400,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: true,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: message,
      showCloseIcon: false,
      btnOkOnPress: okTab != "" ? okTab : () {},
      btnOkColor: Color(0xfff05043),
    ).show();
  }

  static void checkConnectivity() async {
    try {
      Strings.connectivitySubscription =
          _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  static void _updateConnectionStatus(ConnectivityResult result) async {
    print("result$result");
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      showStatus(result, true);
    } else {
      showStatus(result, false);
    }
  }

  static void showStatus(ConnectivityResult result, bool status) {
    Get.snackbar(
      "${status ? 'ONLINE' : 'OFFLINE'} ",
      "${status ? 'You are now connected' : 'Internet Connection not available!'}",
      icon: Icon(
          status ? Icons.signal_cellular_alt_outlined : Icons.block_outlined,
          color: status ? Colors.white : Colors.red),
      backgroundColor: status ? Colors.orange : Colors.grey.shade600,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      colorText: Colors.white,
      duration: Duration(seconds: 4),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static void createSnackBar(scaffoldContext, String message) {
    final snackBar =
        new SnackBar(content: new Text(message), backgroundColor: Colors.red);

    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    ScaffoldMessenger.of(scaffoldContext).showSnackBar(snackBar);
  }

  static void getProfile(ctx) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //functions.showprogress();
    Strings.authToken = sharedPreferences.getString("token")!;
    print("token:" + Strings.authToken);
    int? user_id = sharedPreferences.getInt("user_id");
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.getUser(user_id!).then((response) {
      print("response ${response.status}");
      Strings.myprofile = response.data;
      // String raw1 = jsonEncode(_myprofile);
      // sharedPreferences.setString("list", raw1);
      // print(raw1.toString());
    }).catchError((onError) {
      print(onError.toString());
    });
  }

    static void addFeedComment(FUid, Fid, uid, comment, ctx, context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    PostFeedCommentReq feedComments = PostFeedCommentReq();
    feedComments.userId = FUid;
    feedComments.feedId = Fid;
    feedComments.clickUserId = Strings.user_id;
    feedComments.comment = comment;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.postFeedComment(feedComments).then((response) {
      if (response.status == true) {
        // getFeeds();
        // commentController.clear();
      } else {
        createSnackBar(context, response.message.toString());
      }
    });
  }
}

class TimeAgo {
  // static String timeAgoSinceDate(String dateString,
  //     {bool numericDates = false}) {
  //   DateTime notificationDate = DateFormat("yyyy-MM-dd h:mm").parse(dateString);
  //   print("date:" + notificationDate.toString());
  //   final date2 = DateTime.now();
  //   print("date2" + date2.toString());
  //   final difference = date2.difference(notificationDate);

  //   if (difference.inDays > 8) {
  //     return dateString;
  //   } else if ((difference.inDays / 7).floor() >= 1) {
  //     return (numericDates) ? '1 week ago' : 'Last week';
  //   } else if (difference.inDays >= 2) {
  //     return '${difference.inDays} days ago';
  //   } else if (difference.inDays >= 1) {
  //     return (numericDates) ? '1 day ago' : 'Yesterday';
  //   } else if (difference.inHours >= 2) {
  //     return '${difference.inHours} hours ago';
  //   } else if (difference.inHours >= 1) {
  //     return (numericDates) ? '1 hour ago' : 'An hour ago';
  //   } else if (difference.inMinutes >= 2) {
  //     return '${difference.inMinutes} minutes ago';
  //   } else if (difference.inMinutes >= 1) {
  //     return (numericDates) ? '1 minute ago' : 'A minute ago';
  //   } else if (difference.inSeconds >= 3) {
  //     return '${difference.inSeconds} seconds ago';
  //   } else {
  //     return 'Just now';
  //   }
  // }

  static String calculateTimeDifferenceBetween(String? createdAt) {
    DateTime startDate = DateTime.parse(createdAt!);
    //print(DateFormat.MMMEd().format(startDate));
    DateTime endDate = DateTime.now();

    // var dateUtc = DateTime.now().toUtc();
    // var strToDateTime = DateTime.parse(dateUtc.toString());
    // final convertLocal = strToDateTime.toLocal();
    // var newFormat = DateFormat("yy-MM-dd hh:mm:ss aaa");
    // String updatedDt = newFormat.format(convertLocal);
    // print(dateUtc);
    // print(convertLocal);
    // print(updatedDt);

    int seconds = endDate.difference(startDate).inSeconds;
    if (seconds < 60)
      return '${seconds.abs()} second ago';
    else if (seconds >= 60 && seconds < 3600)
      return '${startDate.difference(endDate).inMinutes.abs()} minute ago';
    else if (seconds >= 3600 && seconds < 86400)
      return '${startDate.difference(endDate).inHours.abs()} hour ago';
    else
      return '${startDate.difference(endDate).inDays.abs()} day ago';
  }
}
