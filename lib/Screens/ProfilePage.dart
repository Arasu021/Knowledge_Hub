import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skein_community/Models/Auth/GetUserRes.dart';
import 'package:skein_community/Screens/ProfileEdit.dart';
import 'package:skein_community/Screens/dashboard2.dart';
import 'package:skein_community/Screens/stepperPage.dart';
import 'package:skein_community/Utilities/strings.dart';
import 'package:skein_community/functions/functions.dart';
import 'package:skein_community/network/ApiService.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  BuildContext? ctx;

  List<ProfileData>? _myprofile;

  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController designationController = TextEditingController();
  // final TextEditingController mobileController = TextEditingController();
  // final TextEditingController interestController = TextEditingController();
  // final TextEditingController experienceController = TextEditingController();

  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  getProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //functions.showprogress();
    Strings.authToken = sharedPreferences.getString("token")!;
    print("token:" + Strings.authToken);
    int? user_id = sharedPreferences.getInt("user_id");
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.getUser(user_id!).then((response) {
      print("response ${response.status}");
      setState(() {
        _myprofile = response.data;
        // String raw1 = jsonEncode(_myprofile);
        // sharedPreferences.setString("list", raw1);
        // print(raw1.toString());
      });
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => getProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return Profile(newContext);
          }),
        ));
  }

  Profile(BuildContext context) {
    ctx = context;
    var media = MediaQuery.of(context).size;
    print("data:" + _myprofile.toString());
    return Scaffold(
      body: (_myprofile != null)
          ? Column(
              children: [
                Container(
                  height: media.height * 0.5,
                  width: media.width * 1,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.centerRight,
                          colors: [
                        Color.fromARGB(255, 252, 114, 125),
                        Color.fromARGB(255, 240, 188, 17),
                      ])),
                  child: Column(
                    children: [
                      SizedBox(
                        height: media.height * 0.03,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 50,
                          width: 50,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => DashPage()),
                                  (Route<dynamic> route) => false);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        child: ClipOval(
                          child: Center(
                            child: (_myprofile![0].profilePicture == "" ||
                                    _myprofile![0].profilePicture == null ||
                                    _myprofile![0].profilePicture ==
                                        "undefined")
                                ? Icon(
                                    Icons.person,
                                    color: Colors.grey.shade600,
                                    size: 70,
                                  )
                                : Image.network(
                                    "https://demo.emeetify.com:3422/${_myprofile![0].profilePicture}",
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                          ),
                        ),
                        radius: 50,
                        backgroundColor: Colors.grey.shade300,
                      ),
                      SizedBox(
                        height: media.height * 0.03,
                      ),
                      Text(
                        // "Arasueswaran R",
                        _myprofile![0].fullName.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        _myprofile![0].designation.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(
                        height: media.height * 0.05,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Feeds",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "15",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Questions",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "15",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Answers",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "2000",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                            elevation: 30,
                            shadowColor: Colors.white,
                            color: Color.fromRGBO(255, 255, 255, 1),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.person_outline_rounded,
                                      size: 30),
                                  trailing: IconButton(
                                    icon: Icon(Icons.edit_outlined),
                                    onPressed: () {
                                      Strings.editprofile = true;
                                      Get.to(() => ProfileEdit(_myprofile));
                                    },
                                  ),
                                  title: Text(
                                    'User Name',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  subtitle: Text(
                                    _myprofile![0].fullName.toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.work_outline_outlined,
                                      size: 30),
                                  title: Text(
                                    'Designation',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  subtitle: Text(
                                    _myprofile![0].designation.toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                ListTile(
                                  leading:
                                      Icon(Icons.bookmark_outline, size: 30),
                                  title: Text(
                                    'Interests',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  subtitle: Text(
                                    _myprofile![0].interests.toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                ListTile(
                                  leading:
                                      Icon(Icons.assessment_outlined, size: 30),
                                  title: Text(
                                    'Work Experience',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  subtitle: Text(
                                    _myprofile![0].workExperience.toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.mail_outline, size: 30),
                                  title: Text(
                                    'Email Id',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  subtitle: Text(
                                    _myprofile![0].email.toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.phone_android, size: 30),
                                  title: Text(
                                    'Mobile Number',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  subtitle: Text(
                                    _myprofile![0].mobileNo.toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : SizedBox(),
    );
  }
}
    
  

  // void GetUserDetails() {
  //   // functions.showprogress();
  //   final api = Provider.of<ApiService>(ctx!, listen: false);
  //   api.getFeed().then((response) {
  //     print("response ${response.status}");
  //     setState(() {
  //       // functions.dismissDialog();

  //       _FeedsSummary = response.data;
  //       print("Data" + _FeedsSummary.toString());
  //     });
  //   }).catchError((onError) {
  //     print(onError.toString());
  //     _FeedsSummary = [];
  //     // functions.dismissDialog();
  //   });
  // }
  // void openBottomSheet() {
  //   var media = MediaQuery.of(context).size;
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return Scaffold(
  //           backgroundColor: Colors.transparent.withOpacity(.15),
  //           body: SingleChildScrollView(
  //             child: Container(
  //               height: media.height * 1,
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(30),
  //                     topRight: Radius.circular(30)),
  //               ),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: <Widget>[
  //                   SizedBox(
  //                     width: media.width * 1,
  //                     child: TextFormField(
  //                       autofocus: false,
  //                       onFieldSubmitted: (value) {
  //                         //Validator
  //                       },
  //                       onChanged: (value) {
  //                         _formKey.currentState!.reset();
  //                       },
  //                       validator: (value) {
  //                         if (value == null || value.isEmpty) {
  //                           return 'Enter your name';
  //                         }
  //                         return null;
  //                       },
  //                       controller: nameController,
  //                       decoration: InputDecoration(
  //                         filled: true,
  //                         fillColor: Colors.transparent,
  //                         //labelText: 'Username',
  //                         //labelStyle: TextStyle(
  //                         //color: Colors.black54,),
  //                         // errorText: _validate ? 'Value Can\'t Be Empty' : null,

  //                         errorStyle: const TextStyle(
  //                           color: Colors.red,
  //                         ),
  //                         hintText: 'Full Name',
  //                         hintStyle: const TextStyle(
  //                           color: Colors.black54,
  //                         ),
  //                         prefixIcon: const Icon(
  //                           Icons.person_outline_rounded,
  //                           color: Colors.black54,
  //                         ),
  //                         contentPadding: const EdgeInsets.only(
  //                             left: 14.0, bottom: 20.0, top: 20.0),
  //                         focusedBorder: OutlineInputBorder(
  //                           borderSide: BorderSide(color: Colors.grey.shade300),
  //                           borderRadius: BorderRadius.circular(5),
  //                         ),
  //                         enabledBorder: UnderlineInputBorder(
  //                           borderSide: BorderSide(
  //                               color: Colors.grey.shade300, width: 5),
  //                           borderRadius: BorderRadius.circular(5),
  //                         ),
  //                       ),
  //                       //           validator: (value) =>
  //                       // value!.isEmpty ? 'Email cannot be blank' : null,
  //                       keyboardType: TextInputType.emailAddress,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: media.width * 1,
  //                     child: TextFormField(
  //                       autofocus: false,
  //                       onFieldSubmitted: (value) {
  //                         //Validator
  //                       },
  //                       onChanged: (value) {
  //                         _formKey.currentState!.reset();
  //                       },
  //                       validator: (value) {
  //                         if (value == null || value.isEmpty) {
  //                           return 'Enter your designation';
  //                         }
  //                         return null;
  //                       },
  //                       controller: designationController,
  //                       decoration: InputDecoration(
  //                         filled: true,
  //                         fillColor: Colors.white,
  //                         //labelText: 'Username',
  //                         //labelStyle: TextStyle(
  //                         //color: Colors.black54,),
  //                         // errorText: _validate ? 'Value Can\'t Be Empty' : null,

  //                         errorStyle: const TextStyle(
  //                           color: Colors.red,
  //                         ),
  //                         hintText: 'Designation',
  //                         hintStyle: const TextStyle(
  //                           color: Colors.black54,
  //                         ),
  //                         prefixIcon: const Icon(
  //                           Icons.work_outline_outlined,
  //                           color: Colors.black54,
  //                         ),
  //                         contentPadding: const EdgeInsets.only(
  //                             left: 14.0, bottom: 20.0, top: 20.0),
  //                         focusedBorder: OutlineInputBorder(
  //                           borderSide: BorderSide(color: Colors.grey.shade300),
  //                           borderRadius: BorderRadius.circular(5),
  //                         ),
  //                         enabledBorder: UnderlineInputBorder(
  //                           borderSide: BorderSide(
  //                               color: Colors.grey.shade300, width: 5),
  //                           borderRadius: BorderRadius.circular(5),
  //                         ),
  //                       ),
  //                       //           validator: (value) =>
  //                       // value!.isEmpty ? 'Email cannot be blank' : null,
  //                       keyboardType: TextInputType.emailAddress,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: media.width * 1,
  //                     child: TextFormField(
  //                       autofocus: false,
  //                       onFieldSubmitted: (value) {
  //                         //Validator
  //                       },
  //                       onChanged: (value) {
  //                         _formKey.currentState!.reset();
  //                       },
  //                       validator: (value) {
  //                         if (value == null || value.isEmpty) {
  //                           return 'Enter your Work experience';
  //                         }
  //                         return null;
  //                       },
  //                       controller: experienceController,
  //                       decoration: InputDecoration(
  //                         filled: true,
  //                         fillColor: Colors.white,
  //                         //labelText: 'Username',
  //                         //labelStyle: TextStyle(
  //                         //color: Colors.black54,),
  //                         // errorText: _validate ? 'Value Can\'t Be Empty' : null,

  //                         errorStyle: const TextStyle(
  //                           color: Colors.red,
  //                         ),
  //                         hintText: 'Work Experience',
  //                         hintStyle: const TextStyle(
  //                           color: Colors.black54,
  //                         ),
  //                         prefixIcon: const Icon(
  //                           Icons.assessment_outlined,
  //                           color: Colors.black54,
  //                         ),
  //                         contentPadding: const EdgeInsets.only(
  //                             left: 14.0, bottom: 20.0, top: 20.0),
  //                         focusedBorder: OutlineInputBorder(
  //                           borderSide: BorderSide(color: Colors.grey.shade300),
  //                           borderRadius: BorderRadius.circular(5),
  //                         ),
  //                         enabledBorder: UnderlineInputBorder(
  //                           borderSide: BorderSide(
  //                               color: Colors.grey.shade300, width: 5),
  //                           borderRadius: BorderRadius.circular(5),
  //                         ),
  //                       ),
  //                       //           validator: (value) =>
  //                       // value!.isEmpty ? 'Email cannot be blank' : null,
  //                       keyboardType: TextInputType.emailAddress,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: media.width * 1,
  //                     child: TextFormField(
  //                       autofocus: false,
  //                       onFieldSubmitted: (value) {
  //                         //Validator
  //                       },
  //                       onChanged: (value) {
  //                         _formKey.currentState!.reset();
  //                       },
  //                       validator: (value) {
  //                         if (value == null || value.isEmpty) {
  //                           return 'Enter your interests';
  //                         }
  //                         return null;
  //                       },
  //                       controller: interestController,
  //                       decoration: InputDecoration(
  //                         filled: true,
  //                         fillColor: Colors.white,
  //                         //labelText: 'Username',
  //                         //labelStyle: TextStyle(
  //                         //color: Colors.black54,),
  //                         // errorText: _validate ? 'Value Can\'t Be Empty' : null,

  //                         errorStyle: const TextStyle(
  //                           color: Colors.red,
  //                         ),
  //                         hintText: 'Interests',
  //                         hintStyle: const TextStyle(
  //                           color: Colors.black54,
  //                         ),
  //                         prefixIcon: const Icon(
  //                           Icons.bookmark_outline,
  //                           color: Colors.black54,
  //                         ),
  //                         contentPadding: const EdgeInsets.only(
  //                             left: 14.0, bottom: 20.0, top: 20.0),
  //                         focusedBorder: OutlineInputBorder(
  //                           borderSide: BorderSide(color: Colors.grey.shade300),
  //                           borderRadius: BorderRadius.circular(5),
  //                         ),
  //                         enabledBorder: UnderlineInputBorder(
  //                           borderSide: BorderSide(
  //                               color: Colors.grey.shade300, width: 5),
  //                           borderRadius: BorderRadius.circular(5),
  //                         ),
  //                       ),
  //                       //           validator: (value) =>
  //                       // value!.isEmpty ? 'Email cannot be blank' : null,
  //                       keyboardType: TextInputType.emailAddress,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: media.width * 1,
  //                     child: TextFormField(
  //                       autofocus: false,
  //                       onFieldSubmitted: (value) {
  //                         //Validator
  //                       },
  //                       onChanged: (value) {
  //                         _formKey.currentState!.reset();
  //                       },
  //                       validator: (value) {
  //                         if (value == null || value.isEmpty) {
  //                           return 'Enter a valid Email';
  //                         }
  //                         return null;
  //                       },
  //                       controller: emailController,
  //                       decoration: InputDecoration(
  //                         filled: true,
  //                         fillColor: Colors.white,
  //                         //labelText: 'Username',
  //                         //labelStyle: TextStyle(
  //                         //color: Colors.black54,),
  //                         // errorText: _validate ? 'Value Can\'t Be Empty' : null,

  //                         errorStyle: const TextStyle(
  //                           color: Colors.red,
  //                         ),
  //                         hintText: 'Email',
  //                         hintStyle: const TextStyle(
  //                           color: Colors.black54,
  //                         ),
  //                         prefixIcon: const Icon(
  //                           Icons.mail_outline,
  //                           color: Colors.black54,
  //                         ),
  //                         contentPadding: const EdgeInsets.only(
  //                             left: 14.0, bottom: 20.0, top: 20.0),
  //                         focusedBorder: OutlineInputBorder(
  //                           borderSide: BorderSide(color: Colors.grey.shade300),
  //                           borderRadius: BorderRadius.circular(5),
  //                         ),
  //                         enabledBorder: UnderlineInputBorder(
  //                           borderSide: BorderSide(
  //                               color: Colors.grey.shade300, width: 5),
  //                           borderRadius: BorderRadius.circular(5),
  //                         ),
  //                       ),
  //                       //           validator: (value) =>
  //                       // value!.isEmpty ? 'Email cannot be blank' : null,
  //                       keyboardType: TextInputType.emailAddress,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: media.width * 1,
  //                     child: Padding(
  //                       padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
  //                       child: TextFormField(
  //                         autofocus: false,
  //                         //           validator: (value) =>
  //                         // value!.isEmpty ? 'Password cannot be blank' : null,
  //                         onFieldSubmitted: (value) {
  //                           //Validator
  //                         },
  //                         onChanged: (value) {
  //                           _formKey.currentState!.reset();
  //                         },
  //                         validator: (value) {
  //                           if (value == null || value.isEmpty) {
  //                             return 'Enter Your Mobile Nummber';
  //                           }
  //                           return null;
  //                         },
  //                         controller: mobileController,
  //                         decoration: InputDecoration(
  //                           filled: true,
  //                           fillColor: Colors.white,
  //                           hintText: 'Mobile Number',
  //                           hintStyle: const TextStyle(
  //                             color: Colors.black54,
  //                           ),
  //                           prefixIcon: const Icon(
  //                             Icons.phone_android,
  //                             color: Colors.black54,
  //                           ),
  //                           contentPadding: const EdgeInsets.only(
  //                               left: 14.0, bottom: 20.0, top: 20.0),
  //                           focusedBorder: OutlineInputBorder(
  //                             borderSide:
  //                                 BorderSide(color: Colors.grey.shade300),
  //                             borderRadius: BorderRadius.circular(5),
  //                           ),
  //                           enabledBorder: UnderlineInputBorder(
  //                             borderSide: BorderSide(
  //                                 color: Colors.grey.shade300, width: 5),
  //                             borderRadius: BorderRadius.circular(5),
  //                           ),
  //                         ),
  //                         minLines: 1,
  //                         keyboardType: TextInputType.number,
  //                       ),
  //                     ),
  //                   ),
  //                   ElevatedButton(
  //                       onPressed: () {}, child: const Text('Update')),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }
//}
