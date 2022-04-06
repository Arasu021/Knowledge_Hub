import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skein_community/Models/Auth/GetUserRes.dart';
import 'package:skein_community/Models/Auth/LoginReq.dart';
import 'package:skein_community/Models/Auth/SignupReq.dart';
import 'package:skein_community/Screens/dashboard2.dart';
import 'package:skein_community/Screens/login.dart';
import 'package:skein_community/Utilities/strings.dart';
import 'package:skein_community/functions/functions.dart';
import 'package:skein_community/network/ApiService.dart';

import 'package:flutter_chips_input/flutter_chips_input.dart';

class StepperDemo extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  //   bool _validate = false;
  // bool _validate1 = false;

  bool _isLoading = false;
  var errorMsg;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  // final TextEditingController interestController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  BuildContext? ctx;

  String? smsOTP;
  late String verificationId;
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool? showButton = false;
  List<ProfileData>? _myprofile;

  ProfileData? datalist;

  String? userImg;

  ProfileData? user;

  dynamic value1;

  //  final FirebaseMessaging Messaging = FirebaseMessaging.instance;

  // @override
  // void initState() {
  //   //setvalues();
  //   super.initState();
  //   print("EditProfile:" + Strings.editprofile.toString());
  //   if (Strings.editprofile == true) {
  //     getSharedPrefs();
  //   }
  // }

  // Future<Null> getSharedPrefs() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   // String rawJson = sharedPreferences.getString("list") ?? '';
  //   // print("------rawJson" + rawJson.toString());
  //   Map<String, dynamic> jsondatais =
  //       jsonDecode(sharedPreferences.getString('list')!);

  //   print("------jsondetails" + jsondatais.toString());
  //   var user = ProfileData.fromJson(jsondatais);
  //   // print("user:$user");
  //   if (jsondatais.isNotEmpty) {
  //     nameController.text = user.fullName.toString();
  //     designationController.text = user.designation.toString();
  //     experienceController.text = user.workExperience.toString();
  //     emailController.text = user.email.toString();
  //     interestController.text = user.interests.toString();
  //     mobileController.text = user.mobileNo.toString();
  //     datalist = user;
  //     userImg = datalist!.profilePicture.toString();
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return signup(newContext);
          }),
        ));
  }

  signup(BuildContext context) {
    const mockResults = <AppProfile>[
      AppProfile('Flutter'),
      AppProfile('Node Js'),
      AppProfile('Angular'),
      AppProfile('React JS'),
      AppProfile('IOS'),
      AppProfile('Vue JS'),
      AppProfile('MySQL'),
      AppProfile('Mongo DB'),
      AppProfile('GraphQL'),
      AppProfile('Ionic'),
      AppProfile('Android'),
      AppProfile('PostgreSQL'),
      AppProfile('Dynamodb'),
      AppProfile('PHP'),
      AppProfile('Django'),
      AppProfile('Express JS'),
      AppProfile('Ember JS'),
      AppProfile('Nginx'),
      AppProfile('Feather JS'),
      AppProfile('Apache'),
    ];
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
                  height: media.height * 0.15,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      media.width * 0.075, media.height * 0.0, 0, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.black),
                    ),
                  ),
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
                        child: Stepper(
                          controlsBuilder: (context, details) {
                            return Row(
                              children: <Widget>[
                                SizedBox(height: media.height * 0.1),
                                ElevatedButton(
                                  onPressed: () {
                                    print("currStep:$_currentStep");
                                    setState(() {
                                      _saveDetails();
                                    });
                                  },
                                  child: Text(
                                      _currentStep >= 2 ? 'Verify' : 'Next'),
                                ),
                                Visibility(
                                  visible: showButton!,
                                  child: Icon(
                                    Icons.check_circle_outlined,
                                    color: Colors.green,
                                    size: 35,
                                  ),
                                ),
                                Container(
                                  child: null,
                                ),
                              ],
                            );
                          },
//                             controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
//     return Row(
//         children: <Widget>[
//             Container(
//                 child: null,
//             ),
//             Container(
//                 child: null,
//             ),
//         ],
//     );
// },
                          type: stepperType,
                          physics: ScrollPhysics(),
                          currentStep: _currentStep,
                          onStepTapped: (step) => tapped(step),
                          // onStepContinue: continued,
                          // onStepCancel: cancel,
                          steps: <Step>[
                            Step(
                              title: new Text('Personal Details'),
                              content: Form(
                                key: formKeys[0],
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: media.width * 1,
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
                                              left: 14.0,
                                              bottom: 20.0,
                                              top: 20.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300,
                                                width: 5),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        //           validator: (value) =>
                                        // value!.isEmpty ? 'Email cannot be blank' : null,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ),
                                    SizedBox(
                                      width: media.width * 1,
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
                                              left: 14.0,
                                              bottom: 20.0,
                                              top: 20.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300,
                                                width: 5),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        //           validator: (value) =>
                                        // value!.isEmpty ? 'Email cannot be blank' : null,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ),
                                    SizedBox(
                                      width: media.width * 1,
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
                                              left: 14.0,
                                              bottom: 20.0,
                                              top: 20.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300,
                                                width: 5),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        //           validator: (value) =>
                                        // value!.isEmpty ? 'Email cannot be blank' : null,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ),
                                    SizedBox(
                                      width: media.width * 1,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 4),
                                        child: ChipsInput(
                                          // enabled: true,
                                          // inputAction: TextInputAction.done,
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
                                              Icons.bookmark_add_outlined,
                                              color: Colors.black54,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 14.0,
                                                    bottom: 20.0,
                                                    top: 20.0),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade300),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade300,
                                                  width: 5),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          //  key: _chipKey,
                                          findSuggestions: (String query) {
                                            // print("Query: '$query'");
                                            if (query.isNotEmpty) {
                                              var lowercaseQuery =
                                                  query.toLowerCase();
                                              return mockResults
                                                  .where((profile) {
                                                return profile.name
                                                    .toLowerCase()
                                                    .contains(
                                                        query.toLowerCase());
                                              }).toList(growable: false)
                                                ..sort((a, b) => a.name
                                                    .toLowerCase()
                                                    .indexOf(lowercaseQuery)
                                                    .compareTo(b.name
                                                        .toLowerCase()
                                                        .indexOf(
                                                            lowercaseQuery)));
                                            }
                                            // return <AppProfile>[];
                                            return mockResults;
                                          },
                                          onChanged: (data) {
                                            value1 = data;
                                            print(data);
                                          },
                                          chipBuilder: (context, state,
                                              dynamic profile) {
                                            return InputChip(
                                              key: ObjectKey(profile),
                                              label: Text(profile.name),
                                              onDeleted: () =>
                                                  state.deleteChip(profile),
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            );
                                          },
                                          suggestionBuilder: (context, state,
                                              dynamic profile) {
                                            return ListTile(
                                              key: ObjectKey(profile),
                                              // leading: CircleAvatar(
                                              //   backgroundImage: NetworkImage(profile.imageUrl),
                                              // ),
                                              title: Text(profile.name),
                                              // subtitle: Text(profile.email),
                                              onTap: () => state
                                                  .selectSuggestion(profile),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 0
                                  ? StepState.complete
                                  : StepState.disabled,
                            ),
                            Step(
                              title: new Text('Contact Details'),
                              content: Form(
                                key: formKeys[1],
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: media.width * 1,
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
                                            return 'Enter a valid Email';
                                          }
                                          return null;
                                        },
                                        controller: emailController,
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
                                          hintText: 'Email',
                                          hintStyle: const TextStyle(
                                            color: Colors.black54,
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.mail_outline,
                                            color: Colors.black54,
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0,
                                              bottom: 20.0,
                                              top: 20.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300,
                                                width: 5),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        //           validator: (value) =>
                                        // value!.isEmpty ? 'Email cannot be blank' : null,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ),
                                    SizedBox(
                                      width: media.width * 1,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 4),
                                        child: TextFormField(
                                          autofocus: false,
                                          //           validator: (value) =>
                                          // value!.isEmpty ? 'Password cannot be blank' : null,
                                          onFieldSubmitted: (value) {
                                            //Validator
                                          },
                                          onChanged: (value) {
                                            _formKey.currentState!.reset();
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Enter Your Mobile Nummber';
                                            }
                                            return null;
                                          },
                                          controller: mobileController,
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
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 14.0,
                                                    bottom: 20.0,
                                                    top: 20.0),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade300),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade300,
                                                  width: 5),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          maxLength: 10,
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 1
                                  ? StepState.complete
                                  : StepState.disabled,
                            ),
                            Step(
                              title: new Text('Authenticate OTP'),
                              content: Form(
                                key: formKeys[2],
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: media.width * 1,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 4),
                                        child: TextFormField(
                                          autofocus: false,
                                          //           validator: (value) =>
                                          // value!.isEmpty ? 'Password cannot be blank' : null,
                                          onFieldSubmitted: (value) {
                                            //Validator
                                          },
                                          onChanged: (value) {
                                            _formKey.currentState!.reset();
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Enter valid OTP';
                                            }
                                            return null;
                                          },
                                          controller: otpController,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: 'Enter OTP from SMS',
                                            hintStyle: const TextStyle(
                                              color: Colors.black54,
                                            ),
                                            prefixIcon: const Icon(
                                              Icons.phone_android,
                                              color: Colors.black54,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 14.0,
                                                    bottom: 20.0,
                                                    top: 20.0),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade300),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade300,
                                                  width: 5),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          maxLength: 6,
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 2
                                  ? StepState.complete
                                  : StepState.disabled,
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
                                  final FormState? form = _formKey.currentState;
                                  if (form!.validate()) {
                                    // DioClient controller =
                                    //     Get.put(DioClient());
                                    // controller.signInwithEmail2(
                                    //   emailController.text,
                                    // );
                                    signUpwithEmail();
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
                                    ('SIGN UP'),
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: <Widget>[
                      const Text(
                        "Already have an account ?",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                      InkWell(
                        child: const Text(
                          ('  Sign In'),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.orange,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        onTap: () {
                          Get.off(() => LoginPage());
                        },
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
                SizedBox(
                  height: media.height * 0.04,
                )
              ],
            )),
          ),
        ));
    // ),
    // );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    // _currentStep < 1 ? setState(() => _currentStep += 1) : null;

    setState(() {
      if (formKeys[_currentStep].currentState!.validate()) {
        if (_currentStep < 2) {
          _currentStep = _currentStep + 1;
        } else {
          _currentStep = 0;
        }
      }
      // else {
      // Scaffold
      //     .of(context)
      //     .showSnackBar( SnackBar(content:  Text('$currStep')));

      // if (currStep == 1) {
      //   print('First Step');
      //   print('object' + FocusScope.of(context).toStringDeep());
      // }

      // }
    });
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  void signUpwithEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    SignupReq signupreq = SignupReq();
    signupreq.mobileNo = Strings.data_mobile;
    signupreq.designation = Strings.data_designation;
    signupreq.email = Strings.data_email;
    signupreq.fullName = Strings.data_name;
    signupreq.interests = Strings.data_interests;
    signupreq.workExperience = Strings.data_experience;

    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.userRegister(signupreq).then((response) {
      print('response ${response.status}');
      print("result:$response");

      if (response.status == true) {
        print("result:$response");

        sharedPreferences.setInt("user_id", response.data!.userId!);
        sharedPreferences.setString("token", response.token!);
        sharedPreferences.setString(
            "interestes", Strings.data_interests.toString());
        Strings.user_id = response.data!.userId!;
        Strings.authToken = response.token!;
        Get.off(() => DashPage());
      } else {
        print("error");
      }
    });
  }

  void _saveDetails() async {
    if (_currentStep == 0) {
      Strings.data_name = nameController.text;
      Strings.data_designation = designationController.text;
      Strings.data_interests = value1.toString();
      Strings.data_experience = experienceController.text;
      print("data1" + Strings.data_interests.toString());
      // (value1) {
      //   print("data" + Strings.data_interests.toString());
      //   if (value1 == null || value1.isEmpty) {
      //     return "Enter your interests";
      //   } else {
      //     //return null;
      //   }
      // };
      // print("leave");
      continued();
    } else if (_currentStep == 1) {
      Strings.data_email = emailController.text;
      Strings.data_mobile = mobileController.text;

      print("data2");
      // continued();
      CheckMobile();
      // verifyPhone();
    } else if (_currentStep == 2) {
      String? otp = otpController.text;
      if (otp == null || otp.isEmpty || otp.length != 6) {
        functions.createSnackBar(context, "Enter a valid OTP");
      } else {
        signIn();
        print("data3");
      }
      //continued();
    }
  }

  void CheckMobile() {
    LoginReq loginreq = LoginReq();
    loginreq.mobileNo = mobileController.text;
    print('mobile ${loginreq.mobileNo}');
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.login(loginreq).then((response) {
      print('response ${response.status}');
      print("result:$response");
      if (response.status == false &&
          response.message == 'Login Failed Please Try Again!') {
        verifyPhone();
      } else {
        functions.createSnackBar(context, "Mobile Number already Exist!");
      }
    });
  }

  Future<void> verifyPhone() async {
    final PhoneCodeSent smsOTPSent = (String verId, [int? forceCodeResend]) {
      this.verificationId = verId;
      continued();
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber:
              '+91${mobileController.text}', // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent:
              smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 60),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException exceptio) {
            print('${exceptio.message}');
          });
    } catch (e) {
      // handleError(e);
      print("Error:$e");
    }
  }

  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.text,
      );
      final user = await _auth.signInWithCredential(credential);
      final currentUser = await _auth.currentUser!;
      user.user == currentUser.uid;
      // Navigator.of(context).pop();
      showButton = true;
    } catch (e) {
      //  handleError(e);
      print("Error:$e");
    }
  }
}

class AppProfile {
  final String name;

  const AppProfile(
    this.name,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppProfile &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name;
  }
}
