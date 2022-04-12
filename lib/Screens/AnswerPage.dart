import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skein_community/Models/Feeds/postAnswerReq.dart';
import 'package:skein_community/Models/Questions/GetQuesAnswerRes.dart';
import 'package:skein_community/Models/Questions/GetQuesRes.dart';
import 'package:skein_community/Utilities/strings.dart';
import 'package:skein_community/Widgets/Likes_Screen.dart';
import 'package:skein_community/Widgets/QuestionsWdgets.dart';
import 'package:skein_community/Widgets/Views_Screen.dart';
import 'package:skein_community/functions/functions.dart';
import 'package:skein_community/network/ApiService.dart';

class AnswerPage extends StatefulWidget {
  List<GetQuesData>? getQuestId;
  List<QuesAnsData>? quesAnswerData;

  AnswerPage(this.getQuestId, this.quesAnswerData);

  @override
  State<AnswerPage> createState() {
    return _AnswerPageState(this.getQuestId!, this.quesAnswerData);
  }
}

class _AnswerPageState extends State<AnswerPage> {
  bool _isLoading = false;

  BuildContext? ctx;

  bool isPressed2 = false;

  List<GetQuesData>? Quesdata;
  List<QuesAnsData>? quesAnswerData;

  bool isHighlighted = false;

  final TextEditingController AnswerController = TextEditingController();

  List<QuesAnsData>? QuesAnswerData;

  // QuesAnsData? selectedUser;

  _AnswerPageState(this.Quesdata, this.quesAnswerData);
  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return ansPage1(newContext);
          }),
        ));
  }

  ansPage1(BuildContext context) {
    ctx = context;
    var media = MediaQuery.of(context).size;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
        : Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: media.height * 1,
                child: Column(
                  children: [
                    SizedBox(
                      height: media.height * 0.04,
                    ),
                    Align(
                      alignment: FractionalOffset.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 1, color: Colors.white)),
                        width: media.width * 0.6,
                        child: ListTile(
                          leading: CircleAvatar(
                            child: ClipOval(
                              child: Center(
                                child: Image.network(
                                  "https://picsum.photos/seed/picsum/200/300",
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
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
                    Container(
                      height: media.height * 0.2,
                      width: media.width * 0.9,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 252, 114, 125),
                              Color.fromARGB(255, 240, 188, 17)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.15),
                            offset: Offset(0, 5),
                            blurRadius: 40,
                          ),
                        ],
                      ),
                      child: Column(children: [
                        SizedBox(
                          height: media.height * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                          child: Text(
                            Quesdata![0].questionSummary!,
                            maxLines: 2,
                            style: TextStyle(fontSize: 22, color: Colors.white),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
                            Text(Quesdata![0].questionLikes.toString(),
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                            IconButton(
                                onPressed: () {
                                  Get.to(() => QuesLikeScreen());
                                },
                                icon: Icon(
                                  Icons.question_answer_outlined,
                                  color: Colors.grey.shade300,
                                  size: 20,
                                )),
                            Text(Quesdata![0].questionComments.toString(),
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                            IconButton(
                                onPressed: () {
                                  Get.to(() => QuesViewScreen());
                                },
                                icon: Icon(
                                  Icons.visibility,
                                  color: Colors.grey.shade300,
                                  size: 20,
                                )),
                            Text(Quesdata![0].questionViews.toString(),
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ],
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 25, 35, 10),
                      child: Text(
                        // "How to write snapshot test for React Big calender How to write snapshot test for React Big calender How to write snapshot test for React Big calender How to write snapshot test for React Big calender",
                        Quesdata![0].questionSummary!,
                        style: TextStyle(
                            fontSize: 16, color: Colors.black.withOpacity(.8)),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Center(
                      child: (Quesdata![0].questionImage == "" ||
                              Quesdata![0].questionImage == null)
                          ? null
                          : Image.network(
                              "https://demo.emeetify.com:3422/" +
                                  (Quesdata![0].questionImage!),
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width,
                            ),
                    ),
                    Expanded(
                      child: (quesAnswerData != null)
                          ? ListView.builder(
                              itemCount: quesAnswerData?.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  InkWell(
                                      onTap: () {
                                        //print(data![index].id);
                                        setState(() {
                                          print(quesAnswerData![index].comment);
                                          //selectedUser = quesAnswerData![index];
                                        });
                                        //_showForm(dataList![index].id,context);
                                        // _displayDialog(context);
                                        //Navigator.pop(context);
                                      },
                                      child: ListTile(
                                          leading: CircleAvatar(
                                            child: ClipOval(
                                              child: Center(
                                                child: (quesAnswerData![index]
                                                                .profilePicture ==
                                                            "" ||
                                                        quesAnswerData![index]
                                                                .profilePicture ==
                                                            null ||
                                                        quesAnswerData![index]
                                                                .profilePicture ==
                                                            "undefined")
                                                    ? Icon(
                                                        Icons.person,
                                                        color: Colors
                                                            .grey.shade600,
                                                        size: 30,
                                                      )
                                                    : Image.network(
                                                        "https://demo.emeetify.com:3422/image/" +
                                                            (quesAnswerData![
                                                                    index]
                                                                .profilePicture!),
                                                        fit: BoxFit.cover,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                      ),
                                              ),
                                            ),
                                            radius: 20,
                                            backgroundColor:
                                                Colors.grey.shade300,
                                          ),
                                          title: Text(
                                              quesAnswerData![index].fullName!),
                                          subtitle: Text(
                                              quesAnswerData![index].comment!,
                                              style: TextStyle(fontSize: 16)),
                                          trailing: Text(
                                            TimeAgo
                                                .calculateTimeDifferenceBetween(
                                                    quesAnswerData![index]
                                                        .createdAt!),
                                            style: TextStyle(fontSize: 12),
                                          ))),
                            )
                          : Container(
                              height: 200,
                              child:
                                  Center(child: Text("No Answers Posted.."))),
                    ),
                    Align(
                      alignment: FractionalOffset.bottomLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                        width: double.infinity,
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              child: ClipOval(
                                child: Center(
                                  child: (Strings.myprofile![0]
                                                  .profilePicture ==
                                              "" ||
                                          Strings.myprofile![0]
                                                  .profilePicture ==
                                              null ||
                                          Strings.myprofile![0]
                                                  .profilePicture ==
                                              "undefined")
                                      ? Icon(
                                          Icons.person,
                                          color: Colors.grey.shade600,
                                          size: 30,
                                        )
                                      : Image.network(
                                          "https://demo.emeetify.com:3422/image/${Strings.myprofile![0].profilePicture}",
                                          fit: BoxFit.cover,
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                controller: AnswerController,
                                maxLines: null,
                                decoration: InputDecoration(
                                    fillColor: Colors.black,
                                    hintText: "Post your Answers...",
                                    hintStyle: TextStyle(color: Colors.black54),
                                    border: InputBorder.none),
                              ),
                            ),
                            //     child: LayoutBuilder(builder: (context, size) {
                            //   TextSpan text = new TextSpan(
                            //     text: AnswerController.text,
                            //     style: TextStyle(color: Colors.black54),
                            //   );

                            //   TextPainter tp = new TextPainter(
                            //     text: text,
                            //     textDirection: TextDirection.ltr,
                            //     textAlign: TextAlign.left,
                            //   );
                            //   tp.layout(maxWidth: size.maxWidth);

                            //   int lines =
                            //       (tp.size.height / tp.preferredLineHeight)
                            //           .ceil();
                            //   int maxLines = 10;

                            //   return TextField(
                            //     controller: AnswerController,
                            //     maxLines: lines < maxLines ? null : maxLines,
                            //     style: TextStyle(color: Colors.black54),
                            //  );
                            //  })),
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: (() {
                                _postAnswers(
                                    Quesdata![0].userId,
                                    Quesdata![0].questionId,
                                    Strings.user_id,
                                    AnswerController.text);
                              }),
                              child: Text(
                                "Post   ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  void _postAnswers(qUid, qid, uid, answer) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    postAnswerReq QuesAnswer = postAnswerReq();
    QuesAnswer.userId = Strings.user_id;
    QuesAnswer.questionsId = qid;
    QuesAnswer.clickUserId = qUid;
    QuesAnswer.comment = answer;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.postQuesAnswer(QuesAnswer).then((response) {
      if (response.status == true) {
        setState(() {
          Getanswer(qid);
          AnswerController.clear();
        });
      } else {
        functions.createSnackBar(context, response.message.toString());
        print("error");
      }
    });
  }

  Getanswer(qid) {
    // functions.showprogress();
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.getQuesAnswer(qid).then((response) {
      print("response ${response.status}");
      setState(() {
        QuesAnswerData = response.data!;
      });
    }).catchError((onError) {
      print(onError.toString());
    });
  }
}
