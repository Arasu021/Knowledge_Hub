import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skein_community/Models/Feeds/FeedLikeReq.dart';
import 'package:skein_community/Models/Feeds/getFeedCommentRes.dart';
import 'package:skein_community/Models/Questions/GetQuesAnswerRes.dart';
import 'package:skein_community/Models/Questions/GetQuesLikedRes.dart';
import 'package:skein_community/Models/Questions/GetQuesRes.dart';
import 'package:skein_community/Models/Questions/PostQuesLikeReq.dart';
import 'package:skein_community/Screens/AnswerPage.dart';
import 'package:skein_community/Utilities/strings.dart';
import 'package:skein_community/Widgets/Comments_screen.dart';
import 'package:skein_community/Widgets/Likes_Screen.dart';
import 'package:skein_community/Widgets/Views_Screen.dart';
import 'package:skein_community/functions/functions.dart';
import 'package:skein_community/network/ApiService.dart';

class QuesPage extends StatefulWidget {
  const QuesPage({Key? key}) : super(key: key);

  @override
  State<QuesPage> createState() => _QuesPageState();
}

class _QuesPageState extends State<QuesPage> {
  BuildContext? ctx;
  bool isPressed2 = true;
  bool isHighlighted = true;
  bool tap = true;
  bool show = true;
  bool _isLoading = false;

  List<GetQuesData>? QuesData;

  List<QuesAnsData>? QuesAnswerData;

  late List<GetQuesData> getQuestId;

  List<GetQuesLikeData>? QuesLikesData;

  // List<GetFeedComData>? FeedsCommentData;

  getQuestions() async {
    // functions.showprogress();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Strings.authToken = sharedPreferences.getString("token")!;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.getQuest("Skenians").then((response) {
      // print("response ${response.status}");
      setState(() {
        _isLoading = false;
        QuesData = response.data!;
      });
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  getQuesComent(Qid, getQuestId) {
    // functions.showprogress();
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.getQuesAnswer(Qid).then((response) {
      print("response ${response.status}");
      setState(() {
        if (response.status == true) {
          QuesAnswerData = response.data!;
          // openBottomSheet();
          //  Get.to(() => QuesCommentsScreen(QuesAnswerData));
          //Get.to(() => AnswerPage(getQuestId, QuesAnswerData));

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AnswerPage(getQuestId, QuesAnswerData)));
        }
      });
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  getQuesId(Qid) {
    // functions.showprogress();
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.getQuestId(Qid).then((response) {
      // print("response ${response.status}");
      setState(() {
        getQuestId = response.data!;
        if (getQuestId[0].questionComments != 0) {
          getQuesComent(Qid, getQuestId);
        } else {
          // QuesAnswerData = 0 as List<QuesAnsData>;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AnswerPage(getQuestId, QuesAnswerData)));
        }
      });
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  _unLike(Qid, QUid) {
    // _isLoading = true;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.RemoveQuestLike(Qid, QUid).then((response) {
      // print("response ${response.status}");
      setState(() {
        //  _isLoading = false;
        if (response.status == true) {
          getQuestions();
        } else {
          functions.createSnackBar(context, response.message.toString());
          print("error");
        }
      });
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  getQuesLike(Qid) {
    // functions.showprogress();
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.getQuesLike(Qid).then((response) {
      // print("response ${response.status}");
      setState(() {
        _isLoading = false;
        QuesLikesData = response.data!;
        // openBottomSheet();
        Get.to(() => QuesLikeScreen(QuesLikesData));
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
    //WidgetsBinding.instance!.addPostFrameCallback((_) => getQuestions());
    getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return QuesPage(newContext);
          }),
        ));
  }

  QuesPage(BuildContext context) {
    ctx = context;
    // print("length${QuesData![0].interests!.length}");
    // print("object${QuesData![0].interests!}");
    var media = MediaQuery.of(context).size;
    CardController controller;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
        // : ListView.builder(
        //     physics: NeverScrollableScrollPhysics(),
        //     itemCount: 2,
        //     itemBuilder: (BuildContext context, int index) =>
        : TinderSwapCard(
            swipeUp: true,
            swipeDown: true,
            orientation: AmassOrientation.bottom,
            totalNum: QuesData!.length,
            stackNum: 3,
            swipeEdge: 3,
            maxWidth: media.width * .9,
            maxHeight: media.height * .6,
            minWidth: media.width * .8,
            minHeight: media.height * .59,
            cardBuilder: (context, index) {
              return InkWell(
                onTap: (() {
                  getQuesId(QuesData![index].questionId);
                }),
                onDoubleTap: (() {
                  print("hii");
                }),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 252, 114, 125),
                      Color.fromARGB(255, 240, 188, 17)
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.15),
                        offset: Offset(0, 5),
                        blurRadius: 40,
                      ),
                    ],
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                  if (QuesData![index].likedUser ==
                                      Strings.myprofile![0].userId) {
                                    _unLike(QuesData![index].questionId,
                                        QuesData![index].likedUser);
                                  } else {
                                    _addQuesLike(QuesData![index].questionId,
                                        QuesData![index].userId);
                                  }
                                });
                              },
                              child: AnimatedContainer(
                                margin: EdgeInsets.all(isHighlighted ? 0 : 2.5),
                                height: isHighlighted ? 30 : 25,
                                width: isHighlighted ? 30 : 25,
                                curve: Curves.fastLinearToSlowEaseIn,
                                duration: Duration(milliseconds: 300),
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
                                child: (QuesData![index].likedUser !=
                                        Strings.myprofile![0].userId)
                                    ? Icon(
                                        Icons.thumb_up_alt_outlined,
                                        color: Colors.grey.shade300,
                                        size: 20,
                                      )
                                    : Icon(
                                        Icons.thumb_up_alt,
                                        color: Colors.red.withOpacity(1.0),
                                        size: 20,
                                      ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (() {
                                _isLoading = true;
                                if (QuesData![index].questionLikes != 0) {
                                  getQuesLike(QuesData![index].questionId);
                                }
                              }),
                              child: Text(
                                  QuesData![index].questionLikes.toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white)),
                            ),
                            IconButton(
                                onPressed: () {
                                  // Get.to(() => QuesLikeScreen());
                                },
                                icon: Icon(
                                  Icons.question_answer_outlined,
                                  color: Colors.grey.shade300,
                                  size: 20,
                                )),
                            Text(QuesData![index].questionComments.toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                            IconButton(
                                onPressed: () {
                                  Get.to(() => QuesViewScreen());
                                },
                                icon: Icon(
                                  Icons.visibility,
                                  color: Colors.grey.shade300,
                                  size: 20,
                                )),
                            Text(QuesData![index].questionViews.toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                          ],
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: Text(
                              // "How to write snapshot test for React Big calender",
                              QuesData![index].questionSummary.toString(),
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Wrap(
                                spacing: 6.0,
                                //runSpacing: 6.0,
                                direction: Axis.horizontal,
                                children: List<Widget>.generate(
                                    QuesData![index].interests![index].length,
                                    (int index) {
                                  return Chip(
                                    label: Text(QuesData![index].interests!,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade300)),
                                    backgroundColor: Colors.orange.shade400,
                                    // onDeleted: () {
                                    //   setState(() {
                                    //     QuesData.removeAt(index);
                                    //   });
                                    // },
                                  );
                                }),
                              ),
                              SizedBox(
                                height: media.height * 0.02,
                              ),
                              Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 1, color: Colors.white)),
                                  width: media.width * 0.6,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: ClipOval(
                                        child: Center(
                                          child: (QuesData![index]
                                                          .profilePicture ==
                                                      "" ||
                                                  QuesData![index]
                                                          .profilePicture ==
                                                      null ||
                                                  QuesData![index]
                                                          .profilePicture ==
                                                      "undefined")
                                              ? Icon(
                                                  Icons.person,
                                                  color: Colors.grey.shade600,
                                                  size: 30,
                                                )
                                              : Image.network(
                                                  "https://demo.emeetify.com:3422/" +
                                                      QuesData![index]
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
                                    title: Text(QuesData![index].fullName!),
                                    subtitle:
                                        Text(QuesData![index].designation!),
                                    // trailing: SizedBox(
                                    //   width: 100,
                                    // )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Swipe Up",
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ]),
                ),
              );
            }
            //),
            );
  }

  void _addQuesLike(Qid, QUid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    PostQuesLikeReq QuesLike = PostQuesLikeReq();
    QuesLike.userId = QUid;
    QuesLike.questionsId = Qid;
    QuesLike.clickUserId = Strings.myprofile![0].userId!;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.AddQuestLike(QuesLike).then((response) {
      if (response.status == true) {
        getQuestions();
      } else {
        functions.createSnackBar(context, response.message.toString());
        print("error");
      }
    });
  }
}
