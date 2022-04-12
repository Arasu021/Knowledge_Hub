import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skein_community/Screens/ChatDetailPage.dart';
import 'package:skein_community/Screens/ChatsMainPage.dart';
import 'package:skein_community/Screens/CreatePost.dart';
import 'package:skein_community/Screens/InfiniteList.dart';
import 'package:skein_community/Screens/ProfilePage.dart';
import 'package:skein_community/Screens/dashboard2.dart';
import 'package:skein_community/Screens/empty.dart';
import 'package:skein_community/Screens/stepperPage.dart';
import 'package:skein_community/Utilities/strings.dart';
import 'package:skein_community/Widgets/FeedsWidget.dart';
import 'package:skein_community/Widgets/QuestionsWdgets.dart';
import 'package:skein_community/functions/functions.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:skein_community/network/ApiService.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  BuildContext? ctx;

  bool? showDrawer = false;

  getProfile() async {
    showDrawer = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Strings.authToken = sharedPreferences.getString("token")!;
    int? user_id = sharedPreferences.getInt("user_id");
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.getUser(user_id!).then((response) {
      print("response ${response.status}");
      if (response.status == true) {
        setState(() {
          Strings.myprofile = response.data;
        });
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return FeedPage1(newContext);
          }),
        ));
  }

  FeedPage1(BuildContext context) {
    ctx = context;
    print("profile" + Strings.myprofile.toString());
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            brightness: Brightness.light,
            elevation: 10,
            //  shadowColor: Color(0xffF0F0F0).withOpacity(.4),
            backgroundColor: Colors.white,
            // title: Text(
            //   '   Your App\'s Name',
            //   textScaleFactor: 1.12,
            //   style: TextStyle(
            //     color: Colors.black.withOpacity(.7),
            //     fontWeight: FontWeight.w700,
            //   ),
            // ),
            leading: IconButton(
              color: Colors.black.withOpacity(.7),
              onPressed: () {
                print("open");
                _key.currentState?.openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
            actions: [
              IconButton(
                color: Colors.black.withOpacity(.7),
                tooltip: 'Search',
                enableFeedback: true,
                icon: Icon(
                  CupertinoIcons.search,
                  color: Colors.black.withOpacity(.7),
                ),
                onPressed: () {
                  // HapticFeedback.lightImpact();
                  // var nn = 123;
                  // Get.off(() => SOSDiscussPage(
                  //       sosId: nn,
                  //     ));

                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => MyHomePage()));
                },
              ),
            ],
            bottom: TabBar(
              indicatorColor: Colors.black.withOpacity(.8),
              unselectedLabelStyle:
                  TextStyle(color: Colors.black.withOpacity(.5)),
              unselectedLabelColor: Colors.black.withOpacity(.4),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.black.withOpacity(.8),
              tabs: [
                const Tab(
                  child: const Text(
                    'Feeds',
                  ),
                ),
                Tab(
                  child: Text(
                    'Questions',
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              //FeedsPage(),
              FeedsPage(),
              QuesPage(),
              //QuestionsWidget(context),
              // FeedsWidget(context),
            ],
          ),
          key: _key,
          drawer: Drawer(
            child: ListView(
                //padding: EdgeInsets.zero,

                children: <Widget>[
                  (showDrawer = true)
                      ? (Strings.myprofile?[0] != null)
                          ? UserAccountsDrawerHeader(
                              decoration: BoxDecoration(color: Colors.white),
                              accountName: Text(
                                (Strings.myprofile![0].fullName.toString()),
                                // "hii",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              accountEmail: Text(
                                (Strings.myprofile![0].email.toString()),
                                // "hii",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              currentAccountPicture: CircleAvatar(
                                child: ClipOval(
                                  child: Center(
                                    child:
                                        (Strings.myprofile![0].profilePicture ==
                                                    "" ||
                                                Strings.myprofile![0]
                                                        .profilePicture ==
                                                    null ||
                                                Strings.myprofile![0]
                                                        .profilePicture ==
                                                    "undefined")
                                            ? Icon(
                                                Icons.person,
                                                color: Colors.grey.shade700,
                                                size: 60,
                                              )
                                            : Image.network(
                                                //"https://picsum.photos/seed/picsum/200/300",
                                                "https://demo.emeetify.com:3422/${Strings.myprofile![0].profilePicture}",
                                                fit: BoxFit.cover,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              ),
                                  ),
                                ),
                                radius: 70,
                                backgroundColor: Colors.grey.shade300,
                              ),
                            )
                          : DrawerHeader(
                              child: Center(
                                child: RaisedButton(
                                  onPressed: () {
                                    setState(() {});
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => LoginPage()));
                                  },
                                  child: Text(('LOGIN'),
                                      style: TextStyle(color: Colors.white)),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                            )
                      : Center(
                          child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.grey))),
                  // IconButton(
                  //   padding: const EdgeInsets.only(
                  //       top: 0, left: 10, right: 0, bottom: 0.0),
                  //   alignment: Alignment.centerLeft,
                  //   iconSize: 25,
                  //   icon: const Icon(Icons.close),
                  //   onPressed: () {
                  //     Navigator.pop(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const DashPage()));
                  //   },
                  // ),
                  ListTile(
                    leading: const Icon(Icons.person_outline_rounded),
                    title: const Text('My Profile'),
                    onTap: () => {
                      //Navigator.of(context).pop()
                      Get.to(() => const MyProfilePage()),
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () => {
                      // Navigator.of(context).pop(),
                      // //signout(),
                      // Get.off(() => StepperDemo()),
                      functions.logout(),
                    },
                  ),
                ]),
          ),
        ));
  }
}
