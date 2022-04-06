import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skein_community/Models/Feeds/getFeedCommentRes.dart';
import 'package:skein_community/Models/Questions/GetQuesRes.dart';
import 'package:skein_community/Utilities/strings.dart';
import 'package:skein_community/Widgets/Comments_screen.dart';
import 'package:skein_community/Widgets/Likes_Screen.dart';
import 'package:skein_community/Widgets/Views_Screen.dart';
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

  late List<GetQuesData> QuesData;

  late List<GetFeedComData> QuesAnswerData;

  late AnimationController scaleController;

  // List<GetFeedComData>? FeedsCommentData;

  getQuestions() async {
    // functions.showprogress();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Strings.authToken = sharedPreferences.getString("token")!;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.getQuest("skeinians").then((response) {
      // print("response ${response.status}");
      setState(() {
        _isLoading = false;
        QuesData = response.data!;
        print("Data" + QuesData[0].questionSummary.toString());
      });
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  getQuesComent() {
    // functions.showprogress();
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.getQuesAnswer("12").then((response) {
      // print("response ${response.status}");
      setState(() {
        QuesAnswerData = response.data!;
        // openBottomSheet();
      //  Get.to(() => QuesCommentsScreen(QuesAnswerData));
        print("Data" + QuesAnswerData.toString());
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
        : InkWell(
            child: TinderSwapCard(
                swipeUp: true,
                swipeDown: true,
                orientation: AmassOrientation.bottom,
                totalNum: QuesData.length,
                stackNum: 3,
                swipeEdge: 3,
                maxWidth: media.width * .9,
                maxHeight: media.height * .6,
                minWidth: media.width * .8,
                minHeight: media.height * .59,
                cardBuilder: (context, index) {
                  return Container(
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
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPressed2 = !isPressed2;
                                  });
                                },
                                icon: isPressed2
                                    ? Icon(
                                        Icons.thumb_up_alt_outlined,
                                        color: Colors.grey.shade300,
                                        size: 20,
                                      )
                                    : Icon(
                                        Icons.thumb_up,
                                        color: Colors.pink.withOpacity(1.0),
                                        size: 20,
                                      ),
                              ),
                              // InkWell(
                              //   highlightColor: Colors.transparent,
                              //   splashColor: Colors.transparent,
                              //   onHighlightChanged: (value) {
                              //     setState(() {
                              //       isHighlighted = !isHighlighted;
                              //     });
                              //   },
                              //   onTap: () {
                              //     setState(() {
                              //       isPressed2 = !isPressed2;
                              //     });
                              //   },
                              //   child: isPressed2
                              //       ? Icon(
                              //           Icons.thumb_up_alt_outlined,
                              //           color: Colors.black.withOpacity(0.6),
                              //           size: 20,
                              //         )
                              //       : Icon(
                              //           Icons.thumb_up,
                              //           color: Colors.pink.withOpacity(1.0),
                              //           size: 20,
                              //         ),
                              // ),
                              Text(QuesData[index].questionLikes.toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white)),
                              IconButton(
                                  onPressed: () {
                                    Get.to(() => QuesLikeScreen());
                                  },
                                  icon: Icon(
                                    Icons.question_answer_outlined,
                                    color: Colors.grey.shade300,
                                    size: 20,
                                  )),
                              Text(QuesData[index].questionComments.toString(),
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
                              Text(QuesData[index].questionViews.toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white)),
                            ],
                          ),
                          Flexible(
                            child: Text(
                              //"How to write snapshot test for React Big calender",
                              QuesData[index].questionSummary.toString(),
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                              textAlign: TextAlign.center,
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
                                      QuesData[index].interests![index].length,
                                      (int index) {
                                    return Chip(
                                      label: Text(
                                          QuesData[index].interests![index],
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            width: 1, color: Colors.white)),
                                    width: media.width * 0.6,
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        child: ClipOval(
                                          child: Center(
                                            child: Image.network(
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
                                      title: Text("Arasuewaran R"),
                                      subtitle: Text("flutter developer"),
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
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ]),
                  );
                }
                //),
                ),
            onTap: () {
              scaleController.forward();
            },
          );
  }
}
