import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skein_community/Models/Auth/GetUserRes.dart';
import 'package:skein_community/Models/Auth/UpdateUserReq1.dart';
import 'package:skein_community/Models/Auth/UpdateUserReq2.dart';
import 'package:skein_community/Screens/ProfilePage.dart';
import 'package:skein_community/Screens/login.dart';
import 'package:skein_community/Utilities/strings.dart';
import 'package:skein_community/functions/functions.dart';
import 'package:skein_community/network/ApiService.dart';

class ProfileEdit extends StatefulWidget {
  List<ProfileData>? myprofile;
  ProfileEdit(this.myprofile);

  @override
  State<StatefulWidget> createState() {
    return _ProfileEditState(this.myprofile);
  }
}

class _ProfileEditState extends State<ProfileEdit> {
  List<ProfileData>? myprofile;

  late File imageFile;
  XFile? image;
  final ImagePicker _picker = ImagePicker();
  String img64 = "";
  _ProfileEditState(this.myprofile);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  var errorMsg;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController interestController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  BuildContext? ctx;

  bool? showButton = false;

  ProfileData? datalist;

  String? userImg;

  ProfileData? user;

  //  final FirebaseMessaging Messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    //setvalues();
    super.initState();
    if (Strings.editprofile == true) {
      getLocalUserData();
    }
  }

  Future<Null> getLocalUserData() async {
    // String rawJson = sharedPreferences.getString("list") ?? '';
    // print("------rawJson" + rawJson.toString());
    String raw1 = jsonEncode(myprofile![0]);
    Map<String, dynamic> jsondatais = jsonDecode(raw1);

    print("------jsondetails" + jsondatais.toString());
    var user = ProfileData.fromJson(jsondatais);
    print("user:" + user.fullName.toString());
    if (jsondatais.isNotEmpty) {
      nameController.text = user.fullName.toString();
      designationController.text = user.designation.toString();
      experienceController.text = user.workExperience.toString();
      emailController.text = user.email.toString();
      interestController.text = user.interests.toString();
      mobileController.text = user.mobileNo.toString();
      datalist = user;
      userImg = datalist!.profilePicture.toString();
      setState(() {});
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        _getFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _getFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _getFromGallery() async {
    image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (image != null) {
        final bytes = File(image!.path).readAsBytesSync();
        img64 = base64Encode(bytes);
        print("img64" + img64);
        setState(() {});
        print('image selected.');
      } else {
        setState(() {});
        print('No image selected.');
      }
    });
  }

  /// Get from Camera
  _getFromCamera() async {
    image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      if (image != null) {
        final bytes = File(image!.path).readAsBytesSync();
        img64 = base64Encode(bytes);
        setState(() {});
        print('image selected.');
      } else {
        setState(() {});
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return Editprofile(newContext);
          }),
        ));
  }

  Editprofile(BuildContext context) {
    ctx = context;
    var media = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async {
          print('Back');
          // Navigator.pop(context, true);
          Get.back();
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            height: media.height * 1,
            width: media.width * 1,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/login_bg design.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: media.height * 0.06,
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
                                  builder: (context) => MyProfilePage()),
                              (Route<dynamic> route) => false);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Strings.textColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: media.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        media.width * 0.075, media.height * 0.0, 0, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Edit Account',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: media.height * 0.04,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Theme(
                          data: ThemeData(
                              accentColor: Colors.orange,
                              primarySwatch: Colors.orange,
                              colorScheme:
                                  ColorScheme.light(primary: Colors.orange)),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        140, 0, 0, 20),
                                    child: Stack(
                                      children: <Widget>[
                                        CircleAvatar(
                                          child: ClipOval(
                                            child: Center(
                                              child: (myprofile![0]
                                                              .profilePicture) ==
                                                          "" ||
                                                      (myprofile![0]
                                                              .profilePicture) ==
                                                          null
                                                  ? Icon(
                                                      Icons.person,
                                                      color:
                                                          Colors.grey.shade600,
                                                      size: 70,
                                                    )
                                                  : image != null
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(80),
                                                          child: Image.file(
                                                            File(image!.path),
                                                            // width: 100,
                                                            // height: 100,
                                                            //  fit: BoxFit.fitHeight,
                                                          ),
                                                        )
                                                      : Image.network(
                                                          "https://picsum.photos/seed/picsum/200/300",
                                                          fit: BoxFit.cover,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                        ),
                                            ),
                                          ),
                                          radius: 50,
                                          backgroundColor: Colors.grey.shade300,
                                        ),

                                        // CircleAvatar(
                                        //   child: ClipOval(
                                        //     child: Center(
                                        //       // child: ("snapshot.data![0].user_img") == ""
                                        //       //     ? Icon(
                                        //       //         Icons.person,
                                        //       //         color: Colors.grey.shade600,
                                        //       //         size: 70,
                                        //       //       )
                                        //       //     :
                                        //       child: Image.network(
                                        //         "https://picsum.photos/seed/picsum/200/300",
                                        //         fit: BoxFit.cover,
                                        //         width: MediaQuery.of(context).size.width,
                                        //       ),
                                        //     ),
                                        //   ),
                                        //   radius: 40,
                                        //   backgroundColor: Colors.grey.shade300,
                                        // ),
                                        Positioned(
                                            bottom: 1,
                                            right: 1,
                                            child: GestureDetector(
                                              onTap: () {
                                                _showPicker(context);
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                child: Icon(
                                                  Icons.photo_camera,
                                                  size: 17,
                                                  color: Colors.black54,
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: media.height * 0.02,
                              ),
                              SizedBox(
                                width: media.width * 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 4),
                                  child: TextFormField(
                                    autofocus: false,
                                    onFieldSubmitted: (value) {
                                      //Validator
                                    },
                                    onChanged: (value) {
                                      _formKey.currentState!.reset();
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter your name';
                                      }
                                      return null;
                                    },
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      //labelText: 'Username',
                                      //labelStyle: TextStyle(
                                      //color: Colors.black54,),
                                      // errorText: _validate ? 'Value Can\'t Be Empty' : null,

                                      errorStyle: const TextStyle(
                                        color: Colors.red,
                                      ),
                                      hintText: 'Full Name',
                                      hintStyle: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.person_outline_rounded,
                                        color: Colors.black54,
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 20.0, top: 20.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 5),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    //           validator: (value) =>
                                    // value!.isEmpty ? 'Email cannot be blank' : null,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: media.width * 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 4),
                                  child: TextFormField(
                                    autofocus: false,
                                    onFieldSubmitted: (value) {
                                      //Validator
                                    },
                                    onChanged: (value) {
                                      _formKey.currentState!.reset();
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter your designation';
                                      }
                                      return null;
                                    },
                                    controller: designationController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      //labelText: 'Username',
                                      //labelStyle: TextStyle(
                                      //color: Colors.black54,),
                                      // errorText: _validate ? 'Value Can\'t Be Empty' : null,

                                      errorStyle: const TextStyle(
                                        color: Colors.red,
                                      ),
                                      hintText: 'Designation',
                                      hintStyle: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.work_outline_outlined,
                                        color: Colors.black54,
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 20.0, top: 20.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 5),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    //           validator: (value) =>
                                    // value!.isEmpty ? 'Email cannot be blank' : null,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: media.width * 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 4),
                                  child: TextFormField(
                                    autofocus: false,
                                    onFieldSubmitted: (value) {
                                      //Validator
                                    },
                                    onChanged: (value) {
                                      _formKey.currentState!.reset();
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter your Work experience';
                                      }
                                      return null;
                                    },
                                    controller: experienceController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      //labelText: 'Username',
                                      //labelStyle: TextStyle(
                                      //color: Colors.black54,),
                                      // errorText: _validate ? 'Value Can\'t Be Empty' : null,

                                      errorStyle: const TextStyle(
                                        color: Colors.red,
                                      ),
                                      hintText: 'Work Experience',
                                      hintStyle: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.assessment_outlined,
                                        color: Colors.black54,
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 20.0, top: 20.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 5),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    //           validator: (value) =>
                                    // value!.isEmpty ? 'Email cannot be blank' : null,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: media.width * 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 4),
                                  child: TextFormField(
                                    autofocus: false,
                                    onFieldSubmitted: (value) {
                                      //Validator
                                    },
                                    onChanged: (value) {
                                      _formKey.currentState!.reset();
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter your interests';
                                      }
                                      return null;
                                    },
                                    controller: interestController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      //labelText: 'Username',
                                      //labelStyle: TextStyle(
                                      //color: Colors.black54,),
                                      // errorText: _validate ? 'Value Can\'t Be Empty' : null,

                                      errorStyle: const TextStyle(
                                        color: Colors.red,
                                      ),
                                      hintText: 'Interests',
                                      hintStyle: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.bookmark_outline,
                                        color: Colors.black54,
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 20.0, top: 20.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 5),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    //           validator: (value) =>
                                    // value!.isEmpty ? 'Email cannot be blank' : null,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: media.width * 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 4),
                                  child: TextFormField(
                                    autofocus: false,
                                    //           validator: (value) =>
                                    // value!.isEmpty ? 'Password cannot be blank' : null,
                                    onFieldSubmitted: (value) {
                                      //Validator
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter Your Mobile Nummber';
                                      }
                                      return null;
                                    },
                                    controller: mobileController,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Mobile Number',
                                      hintStyle: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.phone_android,
                                        color: Colors.black54,
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 20.0, top: 20.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 5),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    minLines: 1,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          heightFactor: media.width * 0.006,
                          widthFactor: media.width * 0.006,
                          child: SizedBox(
                            height: media.height * 0.07,
                            width: media.width * 0.4,
                            child: InkWell(
                              onTap: () {
                                setState(
                                  () {
                                    _isLoading = true;
                                    final FormState? form =
                                        _formKey.currentState;
                                    if (form!.validate()) {
                                      print("email:${emailController.text}");
                                      // DioClient controller =
                                      //     Get.put(DioClient());
                                      // controller.signInwithEmail2(
                                      //   emailController.text,
                                      // );
                                      UpdateUser();

                                      print("auth" + Strings.authToken);
                                      print('Form is valid');
                                    } else {
                                      print('Form is invalid');
                                    }
                                    print("next");
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Colors.yellow.shade700,
                                        Colors.orange.shade600
                                      ]),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Text(
                                      ('Update'),
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_sharp,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        errorMsg == null
                            ? Container()
                            : Text(
                                "${errorMsg}",
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                  SizedBox(
                    height: media.height * 0.02,
                  )
                ],
              ),
            ),
          ),
        ));
    // ),
    // );
  }

  void UpdateUser() async {
    UpdateUserReq updateUserreq = UpdateUserReq();
    updateUserreq.mobileNo = mobileController.text;
    updateUserreq.designation = designationController.text;
    updateUserreq.email = emailController.text;
    updateUserreq.fullName = nameController.text;
    updateUserreq.interests = interestController.text;
    updateUserreq.workExperience = experienceController.text;

    UpdateUserReq2 updateUserreq2 = UpdateUserReq2();
    updateUserreq2.mobileNo = mobileController.text;
    updateUserreq2.designation = designationController.text;
    updateUserreq2.email = emailController.text;
    updateUserreq2.fullName = nameController.text;
    updateUserreq2.interests = interestController.text;
    updateUserreq2.workExperience = experienceController.text;
    updateUserreq2.profilePicture = img64;
    int? uid = Strings.user_id;

    final api = Provider.of<ApiService>(ctx!, listen: false);
    (img64 == null)
        ? api.updateUser(uid!, updateUserreq).then((response) {
            print('response1 ${response.status}');
            print("result:$response");
            if (response.status == true) {
              print("result:$response");
              functions.createSnackBar(context, "User Details Updated!..");
              Get.to(() => MyProfilePage());
            } else {
              print("error");
            }
          })
        : api.updateUser2(uid!, updateUserreq2).then((response) {
            print('response2 ${response.status}');
            print("result:$response");

            if (response.status == true) {
              print("result:$response");
              Strings.user_id = response.data!.userId!;
              functions.createSnackBar(context, "User Details Updated!..");
              Get.to(() => MyProfilePage());
            } else {
              print("error");
            }
          });
  }
}
