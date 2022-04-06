import 'package:flutter/material.dart';

class FeedsViewScreen extends StatefulWidget {
  // const FeedsViewScreen(List<GetFeedComData>? feedsCommentData, {Key? key})
  //    : super(key: key);

  @override
  State<FeedsViewScreen> createState() => _FeedsViewScreenState();
}

class _FeedsViewScreenState extends State<FeedsViewScreen> {
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
          'Views',
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

class QuesViewScreen extends StatefulWidget {
  // const QuesViewScreen(List<GetFeedComData>? feedsCommentData, {Key? key})
  //   : super(key: key);

  @override
  State<QuesViewScreen> createState() => _QuesViewScreenState();
}

class _QuesViewScreenState extends State<QuesViewScreen> {
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
          'Views',
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
