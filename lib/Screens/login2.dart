// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:skein_community/Models/LoginReq.dart';
// import 'package:skein_community/Screens/dashboard.dart';
// import 'package:skein_community/Screens/dashboard2.dart';
// import 'package:skein_community/Screens/signUp.dart';
// import 'package:skein_community/Screens/stepperPage.dart';
// import 'package:skein_community/functions/functions.dart';
// import 'package:skein_community/network/ApiService.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   bool _showPassword = false;

//   BuildContext? ctx;

//   void _togglevisibility() {
//     setState(() {
//       _showPassword = !_showPassword;
//     });
//   }

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   // var _formKey = GlobalKey<FormState>();
//   var isLoading = false;

//   //   bool _validate = false;
//   // bool _validate1 = false;

//   bool _isLoading = false;
//   var errorMsg;
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
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
//     return Provider<ApiService>(
//         create: (context) => ApiService.create(),
//         child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           body: Builder(builder: (BuildContext newContext) {
//             return login(newContext);
//           }),
//         ));
//   }

//   login(BuildContext context) {
//     ctx = context;
//     var media = MediaQuery.of(context).size;
//     return Container(
//       height: media.height * 1,
//       width: media.width * 1,
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage("assets/images/login_bg design.png"),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             SizedBox(
//               height: media.height * 0.2,
//             ),
//             Align(
//               widthFactor: media.width * 0.012,
//               alignment: Alignment.topLeft,
//               child: const Text(
//                 'Login',
//                 style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.w900,
//                     color: Colors.black),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(
//                   media.width * 0.075, media.height * 0.01, 0, 0),
//               child: const Align(
//                   alignment: Alignment.topLeft,
//                   child: Text(("Please sign in to continue."))),
//             ),
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(
//                     width: media.width * 1,
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 50, 20, 4),
//                       child: TextFormField(
//                         autofocus: false,
//                         onFieldSubmitted: (value) {
//                           //Validator
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Enter a valid Email';
//                           }
//                           return null;
//                         },
//                         controller: emailController,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           //labelText: 'Username',
//                           //labelStyle: TextStyle(
//                           //color: Colors.black54,),
//                           // errorText: _validate ? 'Value Can\'t Be Empty' : null,

//                           errorStyle: const TextStyle(
//                             color: Colors.red,
//                           ),
//                           hintText: 'email or mobile number',
//                           hintStyle: const TextStyle(
//                             color: Colors.black54,
//                           ),
//                           prefixIcon: const Icon(
//                             Icons.mail_outline,
//                             color: Colors.black54,
//                           ),
//                           contentPadding: const EdgeInsets.only(
//                               left: 14.0, bottom: 20.0, top: 20.0),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Colors.grey.shade300, width: 5),
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                         ),
//                         //           validator: (value) =>
//                         // value!.isEmpty ? 'Email cannot be blank' : null,
//                         keyboardType: TextInputType.emailAddress,
//                       ),
//                     ),
//                   ),

//                   Align(
//                     alignment: Alignment.centerRight,
//                     heightFactor: media.width * 0.008,
//                     widthFactor: media.width * 0.0068,
//                     child: InkWell(
//                       child: const Text(
//                         ('Forgot your password?'),
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Colors.orange,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       onTap: () {
//                         //signup screen
//                         // Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
//                       },
//                     ),
//                   ),

//                   //SizedBox(height: 10.0),
//                   Padding(
//                     padding: EdgeInsets.only(
//                         bottom: MediaQuery.of(context).viewInsets.bottom),
//                     child: SizedBox(
//                       width: media.width * 1,
//                       child: Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 0, 20, 4),
//                         child: TextFormField(
//                           autofocus: false,
//                           //           validator: (value) =>
//                           // value!.isEmpty ? 'Password cannot be blank' : null,
//                           onFieldSubmitted: (value) {
//                             //Validator
//                           },
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Enter a valid password';
//                             }
//                             return null;
//                           },

//                           //   if (val.isEmpty) {
//                           //   return 'Can\'t be empty';
//                           // } else {
//                           //   return null;
//                           // }
//                           controller: passwordController,
//                           obscureText: !_showPassword,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.white,
//                             // labelText: 'Password',
//                             // labelStyle: TextStyle(
//                             //   color: Colors.black54,),
//                             //when error has occured
//                             // errorText: _validate1 ? 'Value Can\'t Be Empty' : null,
//                             // errorStyle: TextStyle(
//                             //   color: Colors.red,
//                             //   ),
//                             hintText: 'Password',
//                             hintStyle: const TextStyle(
//                               color: Colors.black54,
//                             ),

//                             prefixIcon: const Icon(
//                               Icons.lock_outline,
//                               color: Colors.black54,
//                             ),
//                             contentPadding: const EdgeInsets.only(
//                                 left: 14.0, bottom: 20.0, top: 20.0),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide:
//                                   BorderSide(color: Colors.grey.shade300),
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Colors.grey.shade300, width: 5),
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             suffixIcon: GestureDetector(
//                               onTap: () {
//                                 _togglevisibility();
//                               },
//                               child: Icon(
//                                 _showPassword
//                                     ? Icons.visibility
//                                     : Icons.visibility_off,
//                                 color: Colors.orange,
//                               ),
//                             ),
//                           ),

//                           minLines: 1,
//                           keyboardType: TextInputType.emailAddress,
//                           //autofocus: false,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     heightFactor: media.width * 0.006,
//                     widthFactor: media.width * 0.006,
//                     child: SizedBox(
//                       height: media.height * 0.07,
//                       width: media.width * 0.4,
//                       child: InkWell(
//                         onTap: () {
//                           setState(
//                             () {
//                               _isLoading = true;
//                               final FormState? form = _formKey.currentState;
//                               if (form!.validate()) {
//                                 // DioClient controller =
//                                 //     Get.put(DioClient());
//                                 // controller.signInwithEmail2(
//                                 //   emailController.text,
//                                 // );
//                                 // signInwithEmail(emailController.text,
//                                 //     passwordController.text);
//                                 Navigator.of(context).pop();
//                                 Get.off(() => const DashPage());

//                                 print('Form is valid1');
//                               } else {
//                                 print('Form is invalid');
//                               }
//                             },
//                           );
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                                 begin: Alignment.centerLeft,
//                                 end: Alignment.centerRight,
//                                 colors: [
//                                   Colors.yellow.shade700,
//                                   Colors.orange.shade600
//                                 ]),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: const <Widget>[
//                               Text(
//                                 ('LOGIN'),
//                                 style: TextStyle(
//                                     fontSize: 18, color: Colors.white),
//                                 textAlign: TextAlign.center,
//                               ),
//                               Icon(
//                                 Icons.arrow_forward_sharp,
//                                 color: Colors.white,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   errorMsg == null
//                       ? Container()
//                       : Text(
//                           "${errorMsg}",
//                           style: const TextStyle(
//                             color: Colors.redAccent,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                 ],
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Row(
//                 children: <Widget>[
//                   const Text(
//                     "Don't have an account ?",
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   InkWell(
//                     child: const Text(
//                       ('  Sign Up'),
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.orange,
//                         fontWeight: FontWeight.w900,
//                       ),
//                     ),
//                     onTap: () {
//                       Get.off(() => StepperDemo());
//                     },
//                   )
//                 ],
//                 mainAxisAlignment: MainAxisAlignment.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//     // ));
//     // ),
//     // );
//   }

//   // void signInwithEmail(String email, String pass) {
//   //   LoginReq loginreq = LoginReq();
//   //   loginreq.email = email;
//   //   loginreq.password = pass;
//   //   print('email ${loginreq.email}');
//   //   print('pass ${loginreq.password}');
//   //   final api = Provider.of<ApiService>(ctx!, listen: false);
//   //   api.login(loginreq).then((response) {
//   //     print('response ${response.status}');
//   //     print("result:$response");

//   //     // if (response.status!) {
//   //     //   print("result:$response");
//   //     // }
//   //   });
//   // }
// }
