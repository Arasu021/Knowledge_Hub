import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skein_community/Models/Feeds/getFeedCommentRes.dart';
import 'package:skein_community/Models/Feeds/postFeedCommentReq.dart';
import 'package:skein_community/Utilities/strings.dart';
import 'package:skein_community/Widgets/FeedsWidget.dart';
import 'package:skein_community/functions/functions.dart';
import 'package:skein_community/network/ApiService.dart';

class FeedsCommentsScreen extends StatefulWidget {
  List<GetFeedComData>? feedsCommentData;
  FeedsCommentsScreen(this.feedsCommentData);

  @override
  State<StatefulWidget> createState() {
    return _FeedsCommentsScreenState(this.feedsCommentData);
  }
}

class _FeedsCommentsScreenState extends State<FeedsCommentsScreen> {
  List<GetFeedComData>? feedsCommentData;

  BuildContext? ctx;

  final TextEditingController commentController = TextEditingController();
  bool _isLoading = false;

  getFeedComment(Fid) {
    _isLoading = true;
    // functions.showprogress();
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.getFeedComment(Fid).then((response) {
      // print("response ${response.status}");
      if (response.status == true) {
        setState(() {
          _isLoading = false;
          feedsCommentData = response.data!;
        });
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  _FeedsCommentsScreenState(this.feedsCommentData);
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            //AppUtils.showToast("Payment Cancelled");
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Comments',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        bottom: PreferredSize(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.white, width: 0.5))),
            ),
            preferredSize: Size(0.0, 0.0)),
      ),
      body: Stack(
        children: [
          Container(
            height: media.height * 1,
            color: Colors.grey.shade200,
            child: ListView.builder(
              physics: ScrollPhysics(),
              itemCount: feedsCommentData?.length,
              itemBuilder: (BuildContext context, int index) => Container(
                color: Colors.white,
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    ListTile(
                        leading: CircleAvatar(
                          child: ClipOval(
                            child: Center(
                              child: (feedsCommentData![index].profilePicture ==
                                          "" ||
                                      feedsCommentData![index].profilePicture ==
                                          null ||
                                      feedsCommentData![index].profilePicture ==
                                          "undefined")
                                  ? Icon(
                                      Icons.person,
                                      color: Colors.grey.shade600,
                                      size: 30,
                                    )
                                  : Image.network(
                                      "https://demo.emeetify.com:3422/" +
                                          (feedsCommentData![index]
                                              .profilePicture!),
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                            ),
                          ),
                          radius: 20,
                          backgroundColor: Colors.grey.shade300,
                        ),
                        title: Text(feedsCommentData![index].fullName!),
                        subtitle:
                            Text(feedsCommentData![index].comment.toString()),
                        trailing: Text(TimeAgo.calculateTimeDifferenceBetween(
                            feedsCommentData![index].createdAt!))),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                    //   child: Align(
                    //       alignment: Alignment.bottomLeft,
                    //       child: Text(
                    //           feedsCommentData![index].comment.toString())),
                    // )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      child: ClipOval(
                        child: Center(
                          child: (Strings.myprofile![0].profilePicture == "" ||
                                  Strings.myprofile![0].profilePicture ==
                                      null ||
                                  Strings.myprofile![0].profilePicture ==
                                      "undefined")
                              ? Icon(
                                  Icons.person,
                                  color: Colors.grey.shade600,
                                  size: 70,
                                )
                              : Image.network(
                                  "https://demo.emeetify.com:3422/${Strings.myprofile![0].profilePicture}",
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                ),
                        ),
                      ),
                      radius: 17,
                      backgroundColor: Colors.grey.shade300,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: commentController,
                        maxLines: null,
                        decoration: InputDecoration(
                            fillColor: Colors.black,
                            hintText: "Add a comment...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: (() {
                        _addFeedComment(
                            feedsCommentData![0].userId,
                            feedsCommentData![0].feedId,
                            Strings.user_id,
                            commentController.text);
                      }),
                      child: Text(
                        "Post   ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addFeedComment(FUid, Fid, uid, comment) async {
    _isLoading = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    PostFeedCommentReq feedComments = PostFeedCommentReq();
    feedComments.userId = FUid;
    feedComments.feedId = Fid;
    feedComments.clickUserId = Strings.myprofile![0].userId;
    feedComments.comment = comment;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.postFeedComment(feedComments).then((response) {
      if (response.status == true) {
        setState(() {
          _isLoading = false;
          commentController.clear();
          getFeedComment(Fid);
        });
      } else {
        functions.createSnackBar(context, response.message.toString());
        print("error");
      }
    });
  }
}
class QuesCommentsScreen extends StatefulWidget {
  List<GetFeedComData>? feedsCommentData;
  QuesCommentsScreen(this.feedsCommentData);

  @override
  State<StatefulWidget> createState() {
    return _QuesCommentsScreenState(this.feedsCommentData);
  }
}

class _QuesCommentsScreenState extends State<QuesCommentsScreen> {
  List<GetFeedComData>? feedsCommentData;

  BuildContext? ctx;

  final TextEditingController commentController = TextEditingController();
  bool _isLoading = false;

  getFeedComment(Fid) {
    _isLoading = true;
    // functions.showprogress();
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.getFeedComment(Fid).then((response) {
      // print("response ${response.status}");
      if (response.status == true) {
        setState(() {
          _isLoading = false;
          feedsCommentData = response.data!;
        });
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  _QuesCommentsScreenState(this.feedsCommentData);
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            //AppUtils.showToast("Payment Cancelled");
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Comments',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        bottom: PreferredSize(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.white, width: 0.5))),
            ),
            preferredSize: Size(0.0, 0.0)),
      ),
      body: Stack(
        children: [
          Container(
            height: media.height * 1,
            color: Colors.grey.shade200,
            child: ListView.builder(
              physics: ScrollPhysics(),
              itemCount: feedsCommentData?.length,
              itemBuilder: (BuildContext context, int index) => Container(
                color: Colors.white,
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    ListTile(
                        leading: CircleAvatar(
                          child: ClipOval(
                            child: Center(
                              child: (feedsCommentData![index].profilePicture ==
                                          "" ||
                                      feedsCommentData![index].profilePicture ==
                                          null ||
                                      feedsCommentData![index].profilePicture ==
                                          "undefined")
                                  ? Icon(
                                      Icons.person,
                                      color: Colors.grey.shade600,
                                      size: 30,
                                    )
                                  : Image.network(
                                      "https://demo.emeetify.com:3422/" +
                                          (feedsCommentData![index]
                                              .profilePicture!),
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                            ),
                          ),
                          radius: 20,
                          backgroundColor: Colors.grey.shade300,
                        ),
                        title: Text(feedsCommentData![index].fullName!),
                        subtitle:
                            Text(feedsCommentData![index].comment.toString()),
                        trailing: Text(TimeAgo.calculateTimeDifferenceBetween(
                            feedsCommentData![index].createdAt!))),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                    //   child: Align(
                    //       alignment: Alignment.bottomLeft,
                    //       child: Text(
                    //           feedsCommentData![index].comment.toString())),
                    // )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      child: ClipOval(
                        child: Center(
                          child: (Strings.myprofile![0].profilePicture == "" ||
                                  Strings.myprofile![0].profilePicture ==
                                      null ||
                                  Strings.myprofile![0].profilePicture ==
                                      "undefined")
                              ? Icon(
                                  Icons.person,
                                  color: Colors.grey.shade600,
                                  size: 70,
                                )
                              : Image.network(
                                  "https://demo.emeetify.com:3422/${Strings.myprofile![0].profilePicture}",
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                ),
                        ),
                      ),
                      radius: 17,
                      backgroundColor: Colors.grey.shade300,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: commentController,
                        maxLines: null,
                        decoration: InputDecoration(
                            fillColor: Colors.black,
                            hintText: "Add a comment...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: (() {
                        _addFeedComment(
                            feedsCommentData![0].userId,
                            feedsCommentData![0].feedId,
                            Strings.user_id,
                            commentController.text);
                      }),
                      child: Text(
                        "Post   ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addFeedComment(FUid, Fid, uid, comment) async {
    _isLoading = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    PostFeedCommentReq feedComments = PostFeedCommentReq();
    feedComments.userId = FUid;
    feedComments.feedId = Fid;
    feedComments.clickUserId = Strings.myprofile![0].userId;
    feedComments.comment = comment;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.postFeedComment(feedComments).then((response) {
      if (response.status == true) {
        setState(() {
          _isLoading = false;
          commentController.clear();
          getFeedComment(Fid);
        });
      } else {
        functions.createSnackBar(context, response.message.toString());
        print("error");
      }
    });
  }
}