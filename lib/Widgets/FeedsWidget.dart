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
import 'package:skein_community/Widgets/EditFeed.dart';
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

  List<FeedsDatum>? FeedsDataId;
  bool end = false;

  late int FeedData;

  getFeeds(page) async {
    // functions.showprogress();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Strings.authToken = sharedPreferences.getString("token")!;
    Strings.user_id = sharedPreferences.getInt("user_id")!;
    //print("hii" + Strings.myprofile![0].interests!);
    // List<String> slist = Strings.myprofile![0].interests! as List<String>;
    // String mystr = slist.join();
    // print("iiii" + mystr);
    final api = Provider.of<ApiService>(ctx!, listen: false);
    //Strings.myprofile![0].interests!
    api.getFeed("Skenians", page).then((response) {
      print("response ${response.status}");
      if (response.status == true) {
        setState(() {
          // functions.dismissDialog();
          _isLoading = false;
          FeedsData = response.data!;
          FeedData = FeedsData!.length;
        });
        if (FeedData == null || FeedData == 0) {
          setState(() => end = true);
          return;
        }
      } else {
        functions.createSnackBar(context, response.message.toString());
        _isLoading = false;
      }
    }).catchError((onError) {
      print("error2" + onError.toString());
    });
  }

  getFeedComment(Fid) {
    _isLoading = true;
    // functions.showprogress();
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.getFeedComment(Fid).then((response) {
      // print("response ${response.status}");
      if (response.status == true) {
        setState(() {
          _isLoading = false;
          FeedsCommentData = response.data!;
          // openBottomSheet();
          print("object" + FeedsCommentData!.toList().toString());
          _isLoading = false;
          Get.to(() => FeedsCommentsScreen(FeedsCommentData));
        });
      }
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

  unLike(Fid, FUid) {
    // _isLoading = true;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.RemoveFeedLike(Fid, FUid).then((response) {
      // print("response ${response.status}");
      setState(() {
        //  _isLoading = false;
        if (response.status == true) {
          getFeeds(_page);
        } else {
          functions.createSnackBar(context, response.message.toString());
          print("error");
        }
      });
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  // GetFeedById(Fid) async {
  //   print("Fid:$Fid");
  //   _isLoading = true;
  //   final api = Provider.of<ApiService>(ctx!, listen: false);
  //   //Strings.myprofile![0].interests!
  //   api.getFeedById(Fid).then((response) {
  //     print("response ${response.status}");
  //     if (response.status == true) {
  //       setState(() {
  //         // functions.dismissDialog();
  //         FeedsDataId = response.data!;
  //         _isLoading = false;
  //       //  Get.to(() => EditFeed(FeedsDataId));
  //       });
  //     } else {
  //       functions.createSnackBar(context, response.message.toString());
  //       _isLoading = false;
  //     }
  //   }).catchError((onError) {
  //     print("error" + onError.toString());
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    print("token:" + Strings.authToken);
    getFeeds(_page);
    // WidgetsBinding.instance!
    //     .addPostFrameCallback((_) => functions.getProfile(ctx));
    // scrollcontroller.addListener(pagination);
  }

  // void pagination() {
  //   if ((scrollcontroller.position.pixels ==
  //       scrollcontroller.position.maxScrollExtent)) {
  //     setState(() {
  //       //  isLoading = true;
  //       _page += 1;
  //       getFeeds(_page);
  //       //add api for load the more data according to new page
  //       print('page:' + _page.toString());
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //print(Strings.myprofile![0].interests!);
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
    return
        // (FeedsData != null)
        //     ?
        _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
            : NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (end == false) {
                    if (!_isLoading &&
                        scrollInfo.metrics.extentBefore ==
                            scrollInfo.metrics.maxScrollExtent) {
                      // start loading data
                      setState(() {
                        _isLoading = true;
                        _page += 1;
                      });
                      getFeeds(_page);
                    }
                  }
                  return true;
                },
                child: ListView.builder(
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
                                        child: (FeedsData![index]
                                                        .profilePicture ==
                                                    "" ||
                                                FeedsData![index]
                                                        .profilePicture ==
                                                    null ||
                                                FeedsData![index]
                                                        .profilePicture ==
                                                    "undefined")
                                            ? Icon(
                                                Icons.person,
                                                color: Colors.grey.shade600,
                                                size: 30,
                                              )
                                            : Image.network(
                                                "https://demo.emeetify.com:3422/" +
                                                    FeedsData![index]
                                                        .profilePicture
                                                        .toString(),
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
                                  title: Text(FeedsData![index].fullName!),
                                  subtitle: Text(
                                    TimeAgo.calculateTimeDifferenceBetween(
                                        FeedsData![index].createdAt),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  trailing: (FeedsData![index].userId ==
                                          Strings.myprofile![0].userId)
                                      ? PopupMenuButton<String>(
                                          child: Icon(
                                            Icons.more_horiz,
                                            size: 20,
                                            color: Strings.textColor,
                                          ),
                                          //child:Text('Sort By'),
                                          onSelected: (Data) {
                                            handleClick(Data,
                                                FeedsData![index].feedId!);
                                          },
                                          itemBuilder: (BuildContext context) {
                                            return {'Edit Feed', 'Delete Feed'}
                                                .map((String choice) {
                                              return PopupMenuItem<String>(
                                                value: choice,
                                                child: Text(choice),
                                              );
                                            }).toList();
                                          },
                                        )
                                      : null,
                                ),
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
                                padding:
                                    const EdgeInsets.fromLTRB(12, 2, 12, 5),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          FeedsData![index]
                                              .feedSummary
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 15,
                                            color:
                                                Colors.black.withOpacity(0.6),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                    // Image.network(
                                    //   "https://picsum.photos/seed/picsum/300/200",
                                    //   // "https://paytm.justlogix.com/$userImg",
                                    //   fit: BoxFit.fill,
                                    //   width: MediaQuery.of(context).size.width,
                                    // ),
                                    Center(
                                      child: (FeedsData![index].feedImage ==
                                                  "" ||
                                              FeedsData![index].feedImage ==
                                                  null)
                                          ? null
                                          // Icon(
                                          //     Icons.person,
                                          //     color: Colors.grey.shade600,
                                          //     size: 30,
                                          //   )
                                          : Image.network(
                                              "https://demo.emeetify.com:3422/" +
                                                  FeedsData![index].feedImage!,
                                              fit: BoxFit.fill,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
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
                                                if (FeedsData![index]
                                                        .likedUser ==
                                                    Strings
                                                        .myprofile![0].userId) {
                                                  unLike(
                                                      FeedsData![index].feedId,
                                                      FeedsData![index].likedUser);
                                                } else {
                                                  _addFeedLike(
                                                      FeedsData![index].feedId,
                                                      FeedsData![index].userId);
                                                }
                                              });
                                            },
                                            child: AnimatedContainer(
                                              margin: EdgeInsets.all(
                                                  isHighlighted ? 0 : 2.5),
                                              height: isHighlighted ? 30 : 25,
                                              width: isHighlighted ? 30 : 25,
                                              curve:
                                                  Curves.fastLinearToSlowEaseIn,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              // decoration: BoxDecoration(
                                              //   boxShadow: [
                                              //     BoxShadow(
                                              //       color: Colors.black
                                              //           .withOpacity(0.2),
                                              //       blurRadius: 20,
                                              //       offset: Offset(5, 10),
                                              //     ),
                                              //   ],
                                              //   color: Colors.white,
                                              //   shape: BoxShape.circle,
                                              // ),
                                              child: (FeedsData![index]
                                                          .likedUser !=
                                                      Strings
                                                          .myprofile![0].userId)
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
                                              if (FeedsData![index].feedLikes !=
                                                  0) {
                                                getFeedLike(
                                                    FeedsData![index].feedId);
                                              }
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
                                                if (FeedsData![index]
                                                        .feedComments !=
                                                    0) {
                                                  getFeedComment(
                                                      FeedsData![index].feedId);
                                                }
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
                        )));
    // : Center(
    //     child: Text("Data Not Available!.."),
    //   );
  }

  handleClick(String value, int Fid) {
    switch (value) {
      case 'Edit Feed':
        setState(() {
          print("Clicked");
          // GetFeedById(Fid);
        });
        break;
      case 'Delete Feed':
        setState(() {});
        break;
    }
  }

  void _addFeedLike(Fid, FUid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    FeedLikeReq feedLike = FeedLikeReq();
    feedLike.userId = FUid;
    feedLike.feedId = Fid;
    feedLike.clickUserId = Strings.user_id;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.AddFeedLike(feedLike).then((response) {
      if (response.status == true) {
        getFeeds(_page);
      } else {
        functions.createSnackBar(context, response.message.toString());
        print("error");
      }
    });
  }
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

  void _addFeedComment(FUid, Fid, uid, comment) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    PostFeedCommentReq feedComments = PostFeedCommentReq();
    feedComments.userId = FUid;
    feedComments.feedId = Fid;
    feedComments.clickUserId = Strings.myprofile![0].userId;
    feedComments.comment = comment;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.postFeedComment(feedComments).then((response) {
      if (response.status == true) {
        getFeeds(_page);
        commentController.clear();
      } else {
        functions.createSnackBar(context, response.message.toString());
        print("error");
      }
    });
  }
}
