import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skein_community/Models/Feeds/FeedLikeReq.dart';
import 'package:skein_community/Models/Feeds/GetFeedRes.dart';
import 'package:skein_community/Models/Feeds/GetLikeUsersRes.dart';
import 'package:skein_community/Models/Feeds/getFeedCommentRes.dart';
import 'package:skein_community/Models/Feeds/postFeedCommentReq.dart';
import 'package:skein_community/Utilities/strings.dart';
import 'package:skein_community/Widgets/Comments_screen.dart';
import 'package:skein_community/Widgets/Likes_Screen.dart';
import 'package:skein_community/Widgets/Views_Screen.dart';
import 'package:skein_community/network/ApiService.dart';
import 'package:skein_community/functions/functions.dart';

class FeedsPage extends StatefulWidget {
  const FeedsPage({Key? key}) : super(key: key);

  @override
  State<FeedsPage> createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  BuildContext? ctx;
  bool isPressed2 = true;
  bool isHighlighted = true;
  int _page = 0;
  List<FeedsDatum>? FeedsData;
  var scrollcontroller = ScrollController();
  double _counter = 0;
  bool tap = true;
  bool show = true;
  bool _isLoading = false;

  List<GetFeedComData>? FeedsCommentData;

  final TextEditingController commentController = TextEditingController();

  late List<GetFeedLikeData> FeedsLikesData;

  getFeeds() async {
    // functions.showprogress();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Strings.authToken = sharedPreferences.getString("token")!;
    Strings.user_id = sharedPreferences.getInt("user_id")!;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.getFeed("Skenians").then((response) {
      print("response ${response.status}");
      setState(() {
        // functions.dismissDialog();
        _isLoading = false;
        FeedsData = response.data!;
        print("Data" + FeedsData.toString());
      });
    }).catchError((onError) {
      print("error" + onError.toString());
    });
  }

  getFeedComment(Fid) {
    // functions.showprogress();
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.getFeedComment(Fid).then((response) {
      // print("response ${response.status}");
      setState(() {
        _isLoading = false;
        FeedsCommentData = response.data!;
        // openBottomSheet();
        //  Get.to(() => FeedsCommentsScreen(FeedsCommentData));
        print("Data" + FeedsCommentData.toString());
      });
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  getFeedLike(Fid) {
    // functions.showprogress();
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.getFeedLike(Fid).then((response) {
      // print("response ${response.status}");
      setState(() {
        _isLoading = false;
        FeedsLikesData = response.data!;
        // openBottomSheet();
        Get.to(() => FeedsLikeScreen(FeedsLikesData));
        print("Data" + FeedsLikesData.toString());
      });
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    print("token:" + Strings.authToken);
    // WidgetsBinding.instance!.addPostFrameCallback((_) => getFeeds());
    getFeeds();
    scrollcontroller.addListener(pagination);
  }

  void pagination() {
    if ((scrollcontroller.position.pixels ==
        scrollcontroller.position.maxScrollExtent)) {
      setState(() {
        //  isLoading = true;
        _page += 1;
        //add api for load the more data according to new page
        print('page:' + _page.toString());
      });
    }
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
    var media = MediaQuery.of(context).size;
    print("pressed:" + isPressed2.toString());
    print("highlighted:" + isHighlighted.toString());
    return
        // (FeedsData != null)
        //     ?
        _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
            : ListView.builder(
                physics: const ScrollPhysics(),
                itemCount: FeedsData?.length,
                itemBuilder: (BuildContext context, int index) => Card(
                      elevation: 30,
                      shadowColor: Colors.white,
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: FractionalOffset.topLeft,
                            child: ListTile(
                                leading: CircleAvatar(
                                  child: ClipOval(
                                    child: Center(
                                      child: (FeedsData![index].feedImage) == ""
                                          ? Icon(
                                              Icons.person,
                                              color: Colors.grey.shade600,
                                              size: 30,
                                            )
                                          : Image.network(
                                              "https://picsum.photos/seed/picsum/200/300",
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                    ),
                                  ),
                                  radius: 20,
                                  backgroundColor: Colors.grey.shade300,
                                ),
                                title: const Text("Arasuewaran R"),
                                subtitle: Text(
                                  TimeAgo.calculateTimeDifferenceBetween(
                                      FeedsData![index].createdAt),
                                  style: TextStyle(fontSize: 12),
                                ),
                                trailing:
                                    // (FeedsData![index].userId ==
                                    //         Strings.user_id)
                                    // ?
                                    PopupMenuButton<String>(
                                  child: Icon(
                                    Icons.more_vert,
                                    size: 20,
                                    color: Strings.textColor,
                                  ),
                                  //child:Text('Sort By'),
                                  onSelected: handleClick,

                                  itemBuilder: (BuildContext context) {
                                    return {'Edit Feed', 'Delete Feed'}
                                        .map((String choice) {
                                      return PopupMenuItem<String>(
                                        value: choice,
                                        child: Text(choice),
                                      );
                                    }).toList();
                                  },
                                )),
                          ),
                          // const SizedBox(
                          //   height: 10,
                          // ), //SizedBox
                          // Text(
                          //   FeedsData![index].feedSummary.toString(),
                          //   style: TextStyle(
                          //     fontSize: 30,
                          //     color: Colors.green[900],
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 2, 12, 5),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      FeedsData![index].feedSummary.toString(),
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                Image.network(
                                  "https://picsum.photos/seed/picsum/300/200",
                                  // "https://paytm.justlogix.com/$userImg",
                                  fit: BoxFit.fill,
                                  width: MediaQuery.of(context).size.width,
                                ),
                                Align(
                                  alignment: FractionalOffset.bottomCenter,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onHighlightChanged: (value) {
                                          setState(() {
                                            isHighlighted = !isHighlighted;
                                          });
                                        },
                                        onTap: () {
                                          setState(() {
                                            isPressed2 = !isPressed2;
                                            _addFeedLike(
                                                FeedsData![index].feedId,
                                                FeedsData![index].userId);
                                          });
                                        },
                                        child: AnimatedContainer(
                                          margin: EdgeInsets.all(
                                              isHighlighted ? 0 : 2.5),
                                          height: isHighlighted ? 30 : 25,
                                          width: isHighlighted ? 30 : 25,
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          duration: Duration(milliseconds: 300),
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                blurRadius: 20,
                                                offset: Offset(5, 10),
                                              ),
                                            ],
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: isPressed2
                                              ? Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                  size: 20,
                                                )
                                              : Icon(
                                                  Icons.favorite,
                                                  color: Colors.pink
                                                      .withOpacity(1.0),
                                                  size: 20,
                                                ),
                                        ),
                                      ),
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     _addFeedLike(FeedsData![index].feedId,
                                      //         FeedsData![index].userId);
                                      //   },
                                      //   child: AnimatedContainer(
                                      //     curve: Curves.fastLinearToSlowEaseIn,
                                      //     duration:
                                      //         const Duration(milliseconds: 1500),
                                      //     height: tap ? 30 : 15,
                                      //     width: tap ? 30 : 15,
                                      //     decoration: BoxDecoration(
                                      //         color: const Color(0xFFFF5757),
                                      //         shape: BoxShape.circle,
                                      //         boxShadow: [
                                      //           BoxShadow(
                                      //               color: const Color(0xFFFF5757)
                                      //                   .withOpacity(0.5),
                                      //               offset: const Offset(0, 5),
                                      //               blurRadius: 30)
                                      //         ]),
                                      //     child: Icon(
                                      //       Icons.favorite,
                                      //       color: Colors.white,
                                      //       size: show ? 15 : _counter,
                                      //     ),
                                      //   ),
                                      // ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: (() {
                                          _isLoading = true;
                                          getFeedLike(FeedsData![index].feedId);
                                        }),
                                        child: Text(
                                            FeedsData![index]
                                                .feedLikes
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Strings.textColor)),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            _isLoading = true;
                                            getFeedComment(
                                                FeedsData![index].feedId);
                                          },
                                          icon: Icon(
                                            Icons.comment_outlined,
                                            color: Strings.textColor,
                                            size: 20,
                                          )),
                                      Text(
                                          FeedsData![index]
                                              .feedComments
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Strings.textColor)),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Get.to(() => FeedsViewScreen());
                                          },
                                          icon: Icon(
                                            Icons.visibility,
                                            color: Strings.textColor,
                                            size: 20,
                                          )),
                                      Text("25",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Strings.textColor)),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 10, bottom: 0, top: 0),
                                  height: 40,
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: TextField(
                                          controller: commentController,
                                          decoration: InputDecoration(
                                              fillColor: Colors.black,
                                              hintText: "Add a comment...",
                                              hintStyle: TextStyle(
                                                  color: Colors.black54),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      GestureDetector(
                                        onTap: (() {
                                          _addFeedComment(
                                              FeedsData![index].userId,
                                              FeedsData![index].feedId,
                                              Strings.user_id,
                                              commentController.text);
                                        }),
                                        child: Text(
                                          "Post   ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ));
    // : Center(
    //     child: Text("Data Not Available!.."),
    //   );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Edit Feed':
        setState(() {});
        break;
      case 'Delete Feed':
        setState(() {});
        break;
    }
  }

  void _addFeedLike(Fid, FUid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    FeedLikeReq feedLike = FeedLikeReq();
    feedLike.userId = Strings.user_id;
    feedLike.feedId = Fid;
    feedLike.clickUserId = FUid;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.AddFeedLike(feedLike).then((response) {
      if (response.status == true) {
        getFeeds();
      } else {
        functions.createSnackBar(context, response.message.toString());
        print("error");
      }
    });

    // void openBottomSheet() async {
    //   print(FeedsCommentData!.length);
    //   print(FeedsCommentData![0].comment!.toString());
    //   showModalBottomSheet(
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
    //       ),
    //       context: context,
    //       builder: (context) {
    //         return Container(
    //             height: 350.0,
    //             color: const Color(
    //                 0xFF737373), //could change this to Color(0xFF737373) or transparent,
    //             //so you don't have to change MaterialApp canvasColor
    //             child: Container(
    //               decoration: const BoxDecoration(
    //                   color: Colors.white70,
    //                   borderRadius: BorderRadius.only(
    //                       topLeft: Radius.circular(20.0),
    //                       topRight: Radius.circular(20.0))),
    //               child: Container(
    //                 decoration: const BoxDecoration(
    //                   color: Colors.white,
    //                 ),
    //                 child: Column(
    //                   children: [
    //                     ListView.builder(
    //                       itemCount: FeedsCommentData!.length,
    //                       shrinkWrap: true,
    //                       padding: const EdgeInsets.only(top: 16),
    //                       physics: const NeverScrollableScrollPhysics(),
    //                       itemBuilder: (context, index) {
    //                         return Card(
    //                           elevation: 30,
    //                           shadowColor: Colors.white,
    //                           color: const Color.fromRGBO(255, 255, 255, 1),
    //                           child: Column(
    //                             children: [
    //                               ListTile(
    //                                   leading: CircleAvatar(
    //                                     child: ClipOval(
    //                                       child: Center(
    //                                         child: (FeedsData![index]
    //                                                     .feedImage) ==
    //                                                 ""
    //                                             ? Icon(
    //                                                 Icons.person,
    //                                                 color: Colors.grey.shade600,
    //                                                 size: 30,
    //                                               )
    //                                             : Image.network(
    //                                                 "https://picsum.photos/seed/picsum/200/300",
    //                                                 fit: BoxFit.cover,
    //                                                 width: MediaQuery.of(context)
    //                                                     .size
    //                                                     .width,
    //                                               ),
    //                                       ),
    //                                     ),
    //                                     radius: 20,
    //                                     backgroundColor: Colors.grey.shade300,
    //                                   ),
    //                                   title: const Text("Arasuewaran R"),
    //                                   subtitle: Text(FeedsCommentData![index]
    //                                       .comment!
    //                                       .toString()),
    //                                   trailing:
    //                                       // (FeedsData![index].userId ==
    //                                       //         Strings.user_id)
    //                                       // ?
    //                                       PopupMenuButton<String>(
    //                                     child: Icon(
    //                                       Icons.more_vert,
    //                                       size: 20,
    //                                       color: Strings.textColor,
    //                                     ),
    //                                     //child:Text('Sort By'),
    //                                     onSelected: handleClick,

    //                                     itemBuilder: (BuildContext context) {
    //                                       return {'Edit Feed', 'Delete Feed'}
    //                                           .map((String choice) {
    //                                         return PopupMenuItem<String>(
    //                                           value: choice,
    //                                           child: Text(choice),
    //                                         );
    //                                       }).toList();
    //                                     },
    //                                   )),
    //                             ],
    //                           ),
    //                         );
    //                       },
    //                     ),
    //                     Align(
    //                       alignment: Alignment.bottomLeft,
    //                       child: Container(
    //                         padding:
    //                             EdgeInsets.only(left: 10, bottom: 10, top: 10),
    //                         height: 60,
    //                         width: double.infinity,
    //                         color: Colors.white,
    //                         child: Row(
    //                           children: <Widget>[
    //                             // GestureDetector(
    //                             //   onTap: () {},
    //                             //   child: Container(
    //                             //     height: 30,
    //                             //     width: 30,
    //                             //     decoration: BoxDecoration(
    //                             //       color: Colors.lightBlue,
    //                             //       borderRadius: BorderRadius.circular(30),
    //                             //     ),
    //                             //     child: Icon(
    //                             //       Icons.add,
    //                             //       color: Colors.white,
    //                             //       size: 20,
    //                             //     ),
    //                             //   ),
    //                             // ),
    //                             // SizedBox(
    //                             //   width: 15,
    //                             // ),
    //                             Expanded(
    //                               child: TextField(
    //                                 decoration: InputDecoration(
    //                                     fillColor: Colors.black,
    //                                     hintText: "Write message...",
    //                                     hintStyle:
    //                                         TextStyle(color: Colors.black54),
    //                                     border: InputBorder.none),
    //                               ),
    //                             ),
    //                             SizedBox(
    //                               width: 15,
    //                             ),
    //                             FloatingActionButton(
    //                               onPressed: () {},
    //                               child: Icon(
    //                                 Icons.send,
    //                                 color: Colors.white,
    //                                 size: 18,
    //                               ),
    //                               backgroundColor: Colors.blue,
    //                               elevation: 0,
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ));
    //       });
    // }
  }

  void _addFeedComment(FUid, Fid, uid, comment) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    PostFeedCommentReq feedComments = PostFeedCommentReq();
    feedComments.userId = Strings.user_id;
    feedComments.feedId = Fid;
    feedComments.clickUserId = FUid;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.postFeedComment(feedComments).then((response) {
      if (response.status == true) {
        getFeeds();
        commentController.clear();
      } else {
        functions.createSnackBar(context, response.message.toString());
        print("error");
      }
    });
  }
}
