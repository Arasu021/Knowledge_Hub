// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:skein_community/Screens/login.dart';
// import 'package:skein_community/functions/functions.dart';

// class SignUpPage extends StatefulWidget {
//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   // var _formKey = GlobalKey<FormState>();
//   var isLoading = false;

//   //   bool _validate = false;
//   // bool _validate1 = false;

//   bool _isLoading = false;
//   var errorMsg;
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController mobileController = TextEditingController();
//   //  final FirebaseMessaging Messaging = FirebaseMessaging.instance;

//   @override
//   void initState() {
//     //setvalues();
//     super.initState();
//     // Refreshid();
//     //fcmtoken();
//     // WidgetsBinding.instance!.addPostFrameCallback((_) => fcmtoken());
//   }

//   @override
//   Widget build(BuildContext context) {
//     var media = MediaQuery.of(context).size;
//     return WillPopScope(
//         onWillPop: () async {
//           print('Back');
//           // Navigator.pop(context, true);
//           Get.back();
//           return true;
//         },
//         child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           body: Container(
//             height: media.height * 1,
//             width: media.width * 1,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("assets/images/login_bg design.png"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   SizedBox(
//                     height: media.height * 0.2,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(
//                         media.width * 0.075, media.height * 0.01, 0, 0),
//                     child: Align(
//                       alignment: Alignment.topLeft,
//                       child: const Text(
//                         'Create Account',
//                         style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.w900,
//                             color: Colors.black),
//                       ),
//                     ),
//                   ),
//                   Form(
//                     key: _formKey,
//                     child: Column(
//                       children: <Widget>[
//                         SizedBox(
//                           width: media.width * 1,
//                           child: Padding(
//                             padding: const EdgeInsets.fromLTRB(20, 50, 20, 4),
//                             child: TextFormField(
//                               autofocus: false,
//                               onFieldSubmitted: (value) {
//                                 //Validator
//                               },
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Enter your name';
//                                 }
//                                 return null;
//                               },
//                               controller: nameController,
//                               decoration: InputDecoration(
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 //labelText: 'Username',
//                                 //labelStyle: TextStyle(
//                                 //color: Colors.black54,),
//                                 // errorText: _validate ? 'Value Can\'t Be Empty' : null,

//                                 errorStyle: const TextStyle(
//                                   color: Colors.red,
//                                 ),
//                                 hintText: 'Full Name',
//                                 hintStyle: const TextStyle(
//                                   color: Colors.black54,
//                                 ),
//                                 prefixIcon: const Icon(
//                                   Icons.person_outline_rounded,
//                                   color: Colors.black54,
//                                 ),
//                                 contentPadding: const EdgeInsets.only(
//                                     left: 14.0, bottom: 20.0, top: 20.0),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: Colors.grey.shade300),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 enabledBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Colors.grey.shade300, width: 5),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                               ),
//                               //           validator: (value) =>
//                               // value!.isEmpty ? 'Email cannot be blank' : null,
//                               keyboardType: TextInputType.emailAddress,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: media.height * 0.01),
//                         SizedBox(
//                           width: media.width * 1,
//                           child: Padding(
//                             padding: const EdgeInsets.fromLTRB(20, 0, 20, 4),
//                             child: TextFormField(
//                               autofocus: false,
//                               onFieldSubmitted: (value) {
//                                 //Validator
//                               },
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Enter a valid Email';
//                                 }
//                                 return null;
//                               },
//                               controller: emailController,
//                               decoration: InputDecoration(
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 //labelText: 'Username',
//                                 //labelStyle: TextStyle(
//                                 //color: Colors.black54,),
//                                 // errorText: _validate ? 'Value Can\'t Be Empty' : null,

//                                 errorStyle: const TextStyle(
//                                   color: Colors.red,
//                                 ),
//                                 hintText: 'Email',
//                                 hintStyle: const TextStyle(
//                                   color: Colors.black54,
//                                 ),
//                                 prefixIcon: const Icon(
//                                   Icons.mail_outline,
//                                   color: Colors.black54,
//                                 ),
//                                 contentPadding: const EdgeInsets.only(
//                                     left: 14.0, bottom: 20.0, top: 20.0),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: Colors.grey.shade300),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 enabledBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Colors.grey.shade300, width: 5),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                               ),
//                               //           validator: (value) =>
//                               // value!.isEmpty ? 'Email cannot be blank' : null,
//                               keyboardType: TextInputType.emailAddress,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: media.height * 0.01),
//                         SizedBox(
//                           width: media.width * 1,
//                           child: Padding(
//                             padding: const EdgeInsets.fromLTRB(20, 0, 20, 4),
//                             child: TextFormField(
//                               autofocus: false,
//                               //           validator: (value) =>
//                               // value!.isEmpty ? 'Password cannot be blank' : null,
//                               onFieldSubmitted: (value) {
//                                 //Validator
//                               },
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Enter Your Mobile Nummber';
//                                 }
//                                 return null;
//                               },
//                               controller: mobileController,
//                               decoration: InputDecoration(
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 hintText: 'Mobile Number',
//                                 hintStyle: const TextStyle(
//                                   color: Colors.black54,
//                                 ),
//                                 prefixIcon: const Icon(
//                                   Icons.phone_android,
//                                   color: Colors.black54,
//                                 ),
//                                 contentPadding: const EdgeInsets.only(
//                                     left: 14.0, bottom: 20.0, top: 20.0),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: Colors.grey.shade300),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 enabledBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Colors.grey.shade300, width: 5),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                               ),
//                               minLines: 1,
//                               keyboardType: TextInputType.number,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: media.height * 0.01),
//                         SizedBox(
//                           width: media.width * 1,
//                           child: Padding(
//                             padding: const EdgeInsets.fromLTRB(20, 0, 20, 4),
//                             child: TextFormField(
//                               autofocus: false,
//                               //           validator: (value) =>
//                               // value!.isEmpty ? 'Password cannot be blank' : null,
//                               onFieldSubmitted: (value) {
//                                 //Validator
//                               },
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Enter a valid password';
//                                 }
//                                 return null;
//                               },
//                               controller: passwordController,
//                               decoration: InputDecoration(
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 hintText: 'Password',
//                                 hintStyle: const TextStyle(
//                                   color: Colors.black54,
//                                 ),
//                                 prefixIcon: const Icon(
//                                   Icons.lock_outline,
//                                   color: Colors.black54,
//                                 ),
//                                 contentPadding: const EdgeInsets.only(
//                                     left: 14.0, bottom: 20.0, top: 20.0),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: Colors.grey.shade300),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 enabledBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Colors.grey.shade300, width: 5),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                               ),
//                               minLines: 1,
//                               keyboardType: TextInputType.emailAddress,
//                             ),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           heightFactor: media.width * 0.006,
//                           widthFactor: media.width * 0.006,
//                           child: SizedBox(
//                             height: media.height * 0.07,
//                             width: media.width * 0.4,
//                             child: InkWell(
//                               onTap: () {
//                                 setState(
//                                   () {
//                                     _isLoading = true;
//                                     final FormState? form =
//                                         _formKey.currentState;
//                                     if (form!.validate()) {
//                                       print("email:${emailController.text}");
//                                       // DioClient controller =
//                                       //     Get.put(DioClient());
//                                       // controller.signInwithEmail2(
//                                       //   emailController.text,
//                                       // );
//                                       // signUpwithEmail(
//                                       //     nameController.text,
//                                       //     emailController.text,
//                                       //     mobileController.text,
//                                       //     passwordController.text);
//                                       print('Form is valid');
//                                     } else {
//                                       print('Form is invalid');
//                                     }
//                                   },
//                                 );
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                       begin: Alignment.centerLeft,
//                                       end: Alignment.centerRight,
//                                       colors: [
//                                         Colors.yellow.shade700,
//                                         Colors.orange.shade600
//                                       ]),
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: const <Widget>[
//                                     Text(
//                                       ('SIGN UP'),
//                                       style: TextStyle(
//                                           fontSize: 18, color: Colors.white),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                     Icon(
//                                       Icons.arrow_forward_sharp,
//                                       color: Colors.white,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         errorMsg == null
//                             ? Container()
//                             : Text(
//                                 "${errorMsg}",
//                                 style: const TextStyle(
//                                   color: Colors.redAccent,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                       ],
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Row(
//                       children: <Widget>[
//                         const Text(
//                           "Already have an account ?",
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.black54,
//                           ),
//                         ),
//                         InkWell(
//                           child: const Text(
//                             ('  Sign In'),
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: Colors.orange,
//                               fontWeight: FontWeight.w900,
//                             ),
//                           ),
//                           onTap: () {
//                             Get.off(() => LoginPage());
//                           },
//                         )
//                       ],
//                       mainAxisAlignment: MainAxisAlignment.center,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ));
//     // ),
//     // );
//   }
// }
