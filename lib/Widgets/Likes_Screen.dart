import 'package:flutter/material.dart';
import 'package:skein_community/Models/Feeds/GetLikeUsersRes.dart';

class FeedsLikeScreen extends StatefulWidget {
  List<GetFeedLikeData>? feedsLikesData;
  FeedsLikeScreen(this.feedsLikesData);

  @override
  State<FeedsLikeScreen> createState() =>
      _FeedsLikeScreenState(this.feedsLikesData);
}

class _FeedsLikeScreenState extends State<FeedsLikeScreen> {
  List<GetFeedLikeData>? feedsLikesData;

  GetFeedLikeData? selectedUser;

  _FeedsLikeScreenState(this.feedsLikesData);
  @override
  Widget build(BuildContext context) {
    print("object" + feedsLikesData!.length.toString());
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
          'Likes',
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
      body: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: feedsLikesData?.length,
        itemBuilder: (BuildContext context, int index) => InkWell(
            // onTap: () {
            //   //print(data![index].id);
            //   setState(() {
            //     selectedUser = feedsLikesData![index];
            //   });
            //   //_showForm(dataList![index].id,context);
            //   // _displayDialog(context);
            //   //Navigator.pop(context);
            // },
            child: Card(
          color: Colors.white70,
          margin: const EdgeInsets.all(15),
          child: ListTile(
            leading: CircleAvatar(
              child: ClipOval(
                child: Center(
                  child: (feedsLikesData![index].profilePicture == "" ||
                          feedsLikesData![index].profilePicture == null ||
                          feedsLikesData![index].profilePicture == "undefined")
                      ? Icon(
                          Icons.person,
                          color: Colors.grey.shade600,
                          size: 30,
                        )
                      : Image.network(
                          "https://demo.emeetify.com:3422/" +
                              (feedsLikesData![index]
                                  .profilePicture
                                  .toString()),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                ),
              ),
              radius: 25,
              backgroundColor: Colors.grey.shade300,
            ),
            title: Text(feedsLikesData![index].fullName.toString()),
            subtitle: Text(feedsLikesData![index].designation.toString()),
            // trailing: SizedBox(
            //   width: 100,
            // )
          ),
        )),
      ),
    );
  }
}

class QuesLikeScreen extends StatefulWidget {
  // const QuesLikeScreen(List<GetFeedComData>? feedsCommentData, {Key? key})
  //   : super(key: key);

  @override
  State<QuesLikeScreen> createState() => _QuesLikeScreenState();
}

class _QuesLikeScreenState extends State<QuesLikeScreen> {
  @override
  Widget build(BuildContext context) {
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
          'Likes',
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
      body: Column(
        children: [
          // Expanded(
          //   child: Align(
          //     alignment: FractionalOffset.bottomCenter,
          //     child: Container(
          //       padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
          //       height: 60,
          //       width: double.infinity,
          //       color: Colors.white,
          //       child: Row(
          //         children: <Widget>[
          //           CircleAvatar(
          //             child: ClipOval(
          //               child: Center(
          //                 child:
          //                     // (FeedsData![index]
          //                     //             .feedImage) ==
          //                     //         ""
          //                     //     ? Icon(
          //                     //         Icons.person,
          //                     //         color: Colors.grey.shade600,
          //                     //         size: 30,
          //                     //       )
          //                     //     :
          //                     Image.network(
          //                   "https://picsum.photos/seed/picsum/200/300",
          //                   fit: BoxFit.cover,
          //                   width: MediaQuery.of(context).size.width,
          //                 ),
          //               ),
          //             ),
          //             radius: 17,
          //             backgroundColor: Colors.grey.shade300,
          //           ),
          //           SizedBox(
          //             width: 15,
          //           ),
          //           Expanded(
          //             child: TextField(
          //               decoration: InputDecoration(
          //                   fillColor: Colors.black,
          //                   hintText: "Add a comment...",
          //                   hintStyle: TextStyle(color: Colors.black54),
          //                   border: InputBorder.none),
          //             ),
          //           ),
          //           SizedBox(
          //             width: 15,
          //           ),
          //           GestureDetector(
          //             onTap: (() {}),
          //             child: Text(
          //               "Post   ",
          //               style: TextStyle(
          //                   fontWeight: FontWeight.bold, color: Colors.blue),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
