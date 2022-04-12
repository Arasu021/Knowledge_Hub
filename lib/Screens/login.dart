import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skein_community/Models/Auth/LoginReq.dart';
import 'package:skein_community/Screens/LandingScreen.dart';
import 'package:skein_community/Screens/dashboard.dart';
import 'package:skein_community/Screens/dashboard2.dart';
import 'package:skein_community/Screens/signUp.dart';
import 'package:skein_community/Screens/stepperPage.dart';
import 'package:skein_community/Utilities/strings.dart';
import 'package:skein_community/functions/functions.dart';
import 'package:skein_community/network/ApiService.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  BuildContext? ctx;

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var isLoading = false;

  late String smsOTP;
  // late String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  var errorMsg;
  String? phoneNo;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool? showButton = true;

  late String verId;

  //  final FirebaseMessaging Messaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)))
              : Builder(builder: (BuildContext newContext) {
                  return login(newContext);
                }),
        ));
  }

  login(BuildContext context) {
    ctx = context;
    var media = MediaQuery.of(context).size;
    return Container(
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
              height: media.height * 0.2,
            ),
            Align(
              widthFactor: media.width * 0.012,
              alignment: Alignment.topLeft,
              child: const Text(
                'Login',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  media.width * 0.075, media.height * 0.01, 0, 0),
              child: const Align(
                  alignment: Alignment.topLeft,
                  child: Text(("Please sign in to continue."))),
            ),
            Column(
              children: [
                Theme(
                  data: ThemeData(
                      accentColor: Colors.orange,
                      primarySwatch: Colors.orange,
                      colorScheme: ColorScheme.light(primary: Colors.orange)),
                  child: Stepper(
                    controlsBuilder: (context, details) {
                      return Row(
                        children: <Widget>[
                          SizedBox(height: media.height * 0.1),
                          Visibility(
                            visible: showButton!,
                            child: ElevatedButton(
                              onPressed: () {
                                // verifyPhone();

                                _isLoading = true;
                                String? phone = emailController.text;
                                if (phone == null ||
                                    phone.isEmpty ||
                                    phone.length != 10) {
                                  functions.createSnackBar(
                                      context, "Enter a valid mobile number");
                                } else {
                                  //continued();

                                  signInwithEmail();
                                  setState(() {
                                    print("--------");
                                    if (_currentStep >= 1) {
                                      print("1111111111");
                                      print("mob$phone");
                                    }
                                  });
                                }
                              },
                              child: Text(_currentStep >= 1 ? 'Login' : 'Next'),
                            ),
                          ),
                          Container(
                            child: null,
                          ),
                        ],
                      );
                    },
                    type: stepperType,
                    physics: ScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step) => tapped(step),
                    steps: [
                      Step(
                        title: Text("Mobile Number"),
                        content: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                            child: TextFormField(
                              autofocus: false,
                              onFieldSubmitted: (value) {
                                //Validator
                              },
                              controller: emailController,
                              onChanged: (value) {
                                (value) {
                                  print("value$value");
                                  if (value == null ||
                                      value!.isEmpty ||
                                      value!.length != 10) {
                                    return 'Enter a valid Mobile Number';
                                  }
                                  phoneNo = value;
                                };
                              },
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
                                hintText: 'Mobile Number',
                                prefix: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text('+91'),
                                ),
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
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300, width: 5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              maxLength: 10,
                              //           validator: (value) =>
                              // value!.isEmpty ? 'Email cannot be blank' : null,
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: Text("Authenticate OTP"),
                        content: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                              child: TextFormField(
                                maxLength: 6,
                                autofocus: false,
                                onFieldSubmitted: (value) {},
                                // validator: (value) {
                                //   if (value == null || value.isEmpty || value.length != 6) {
                                //     return 'Enter a valid OTP';
                                //   }
                                //   return null;
                                // },
                                controller: passwordController,

                                onChanged: (value) {
                                  this.smsOTP = value;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  // labelText: 'Password',
                                  // labelStyle: TextStyle(
                                  //   color: Colors.black54,),
                                  //when error has occured
                                  // errorText: _validate1 ? 'Value Can\'t Be Empty' : null,
                                  // errorStyle: TextStyle(
                                  //   color: Colors.red,
                                  //   ),
                                  hintText: 'OTP',
                                  hintStyle: const TextStyle(
                                    color: Colors.black54,
                                  ),

                                  prefixIcon: const Icon(
                                    Icons.sms_outlined,
                                    color: Colors.black54,
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 20.0, top: 20.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300, width: 5),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),

                                minLines: 1,
                                keyboardType: TextInputType.number,
                                //autofocus: false,
                              ),
                            ),
                          ),
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 1
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                    ],
                  ),
                ),
              ],
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
                        String? otp = passwordController.text;
                        if (otp == null || otp.isEmpty || otp.length != 6) {
                          functions.createSnackBar(
                              context, "Enter a valid OTP");
                        } else {
                          signIn();
                        }
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
                          ('LOG IN'),
                          style: TextStyle(fontSize: 18, color: Colors.white),
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
            SizedBox(
              height: media.height * 0.05,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: <Widget>[
                  const Text(
                    "Don't have an account ?",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                  InkWell(
                    child: const Text(
                      ('  Sign Up'),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.orange,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    onTap: () {
                      Get.off(() => StepperDemo());
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ],
        ),
      ),
    );
    // ));
    // ),
    // );
  }

  void signInwithEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print("object$phoneNo");
    LoginReq loginreq = LoginReq();
    loginreq.mobileNo = emailController.text;
    print('email ${loginreq.mobileNo}');
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.login(loginreq).then((response) {
      print('response ${response.status}');
      print("result:$response");
      if (response.status == true) {
        print("result:$response");

        sharedPreferences.setInt("user_id", response.data!.userId!);
        sharedPreferences.setString("token", response.token!);
        sharedPreferences.setString("interestes", response.data!.interestes!);
        Strings.user_id = response.data!.userId!;
        Strings.authToken = response.token!;
        Strings.data_interests = response.data!.interestes;
        verifyPhone();
        // continued();
      } else {
        functions.createSnackBar(context, response.message.toString());
        print("error");
      }
    });
  }

  tapped(int step) {
    print("2222222");
    setState(() => _currentStep = step);
    showButton = true;
  }

  continued() {
    print("3333333");
    showButton = false;
    _currentStep < 1 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  Future<void> verifyPhone() async {
    // final PhoneCodeSent smsOTPSent = (String verId, [int? forceCodeResend]) {
    //   this.verificationId = verId;
    //   _isLoading = false;
    //   continued();
    // };
    // try {
    //   await _auth.verifyPhoneNumber(
    //       phoneNumber: '+91${emailController.text}', // PHONE NUMBER TO SEND OTP
    //       codeAutoRetrievalTimeout: (String verId) {
    //         //Starts the phone number verification process for the given phone number.
    //         //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
    //         this.verificationId = verId;
    //       },
    //       codeSent:
    //           smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
    //       timeout: const Duration(seconds: 20),
    //       verificationCompleted: (AuthCredential phoneAuthCredential) {
    //         print(phoneAuthCredential);
    //       },
    //       verificationFailed: (FirebaseAuthException exceptio) {
    //         print('${exceptio.message}');
    //       });
    // } catch (e) {
    //   // handleError(e);
    //   print("Error:$e");
    //   functions.createSnackBar(context, e.toString());
    // }

    // For firebase auth
    final auth = FirebaseAuth.instance;
//
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      final res = await auth.signInWithCredential(phoneAuthCredential);
      // Todo After Verification Complete
      // );
    };
//
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('Auth Exception is ${authException.message}');
      functions.createSnackBar(context, authException.message.toString());
      Get.off(() => SecondScreen());
    };
//
    final PhoneCodeSent smsOTPSent =
        (String verificationId, [int? forceResendingToken]) async {
      print('verification id is $verificationId');
      verId = verificationId;
      _isLoading = false;
      continued();
    };
//
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      verId = verificationId;
    };
//
    await auth.verifyPhoneNumber(
        // mobile no. with country code
        phoneNumber: '+91${emailController.text}',
        timeout: const Duration(seconds: 30),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: smsOTPSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verId,
        smsCode: smsOTP,
      );
      final user = await _auth.signInWithCredential(credential);
      final currentUser = await _auth.currentUser!;
      user == currentUser.uid;
      // Navigator.of(context).pop();
      //Navigator.of(context).pushReplacementNamed('/homepage');
      _isLoading = false;
      Get.off(() => const DashPage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        functions.createSnackBar(context, e.code.toString());
        // handle the error here
        print("account-exists-with-different-credential");
      } else if (e.code == 'invalid-credential') {
        functions.createSnackBar(context, e.code.toString());
        // handle the error here
        print("invalid-credential");
      }
    } catch (e) {
      //  handleError(e);
      print("Error:$e");
      functions.createSnackBar(context, e.toString());
    }
  }
}
