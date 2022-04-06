// import 'package:flutter/material.dart';
// import 'package:skein_community/Models/Feeds/getFeedCommentRes.dart';

// class FeedsCommentsScreen extends StatefulWidget {
//   List<GetFeedComData>? feedsCommentData;
//   FeedsCommentsScreen(this.feedsCommentData);

//   @override
//   State<StatefulWidget> createState() {
//     return _FeedsCommentsScreenState(this.feedsCommentData);
//   }
// }

// class _FeedsCommentsScreenState extends State<FeedsCommentsScreen> {
//     List<GetFeedComData>? feedsCommentData;

//   _FeedsCommentsScreenState(List<GetFeedComData>? feedsCommentData);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             //AppUtils.showToast("Payment Cancelled");
//             Navigator.pop(context);
//           },
//         ),
//         backgroundColor: Colors.white,
//         title: Text(
//           'Comments',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         bottom: PreferredSize(
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 10.0),
//               decoration: BoxDecoration(
//                   border: Border(
//                       bottom: BorderSide(color: Colors.white, width: 0.5))),
//             ),
//             preferredSize: Size(0.0, 0.0)),
//       ),
//       body: Column(
//         children: [
//           ListView.builder(
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: feedsCommentData?.length,
//             itemBuilder: (BuildContext context, int index) => InkWell(
//                 onTap: () {
//                   //print(data![index].id);
//                   setState(() {
//                     selectedUser = feedsCommentData![index];
//                   });
//                   //_showForm(dataList![index].id,context);
//                   _displayDialog(context);
//                   //Navigator.pop(context);
//                 },
//                 child: Card(
//                   color: Colors.white70,
//                   margin: const EdgeInsets.all(15),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       child: ClipOval(
//                         child: Center(
//                           child: (dataList![index].user_img) == ""
//                               ? Icon(
//                                   Icons.person,
//                                   color: Colors.grey.shade600,
//                                   size: 30,
//                                 )
//                               : Image.network(
//                                   "https://paytm.justlogix.com/" +
//                                       (dataList![index].user_img),
//                                   fit: BoxFit.cover,
//                                   width: MediaQuery.of(context).size.width,
//                                 ),
//                         ),
//                       ),
//                       radius: 25,
//                       backgroundColor: Colors.grey.shade300,
//                     ),
//                     title: Text(dataList![index].name),
//                     subtitle: Text(dataList![index].email),
//                     // trailing: SizedBox(
//                     //   width: 100,
//                     // )
//                   ),
//                 )),
//           ),
//           Expanded(
//             child: Align(
//               alignment: FractionalOffset.bottomCenter,
//               child: Container(
//                 padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
//                 height: 60,
//                 width: double.infinity,
//                 color: Colors.white,
//                 child: Row(
//                   children: <Widget>[
//                     CircleAvatar(
//                       child: ClipOval(
//                         child: Center(
//                           child:
//                               // (FeedsData![index]
//                               //             .feedImage) ==
//                               //         ""
//                               //     ? Icon(
//                               //         Icons.person,
//                               //         color: Colors.grey.shade600,
//                               //         size: 30,
//                               //       )
//                               //     :
//                               Image.network(
//                             "https://picsum.photos/seed/picsum/200/300",
//                             fit: BoxFit.cover,
//                             width: MediaQuery.of(context).size.width,
//                           ),
//                         ),
//                       ),
//                       radius: 17,
//                       backgroundColor: Colors.grey.shade300,
//                     ),
//                     SizedBox(
//                       width: 15,
//                     ),
//                     Expanded(
//                       child: TextField(
//                         decoration: InputDecoration(
//                             fillColor: Colors.black,
//                             hintText: "Add a comment...",
//                             hintStyle: TextStyle(color: Colors.black54),
//                             border: InputBorder.none),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 15,
//                     ),
//                     GestureDetector(
//                       onTap: (() {}),
//                       child: Text(
//                         "Post   ",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.blue),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class QuesCommentsScreen extends StatefulWidget {
//   const QuesCommentsScreen(List<GetFeedComData>? feedsCommentData, {Key? key})
//       : super(key: key);

//   @override
//   State<QuesCommentsScreen> createState() => _QuesCommentsScreenState();
// }

// class _QuesCommentsScreenState extends State<QuesCommentsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             //AppUtils.showToast("Payment Cancelled");
//             Navigator.pop(context);
//           },
//         ),
//         backgroundColor: Colors.white,
//         title: Text(
//           'Comments',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         bottom: PreferredSize(
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 10.0),
//               decoration: BoxDecoration(
//                   border: Border(
//                       bottom: BorderSide(color: Colors.white, width: 0.5))),
//             ),
//             preferredSize: Size(0.0, 0.0)),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Align(
//               alignment: FractionalOffset.bottomCenter,
//               child: Container(
//                 padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
//                 height: 60,
//                 width: double.infinity,
//                 color: Colors.white,
//                 child: Row(
//                   children: <Widget>[
//                     CircleAvatar(
//                       child: ClipOval(
//                         child: Center(
//                           child:
//                               // (FeedsData![index]
//                               //             .feedImage) ==
//                               //         ""
//                               //     ? Icon(
//                               //         Icons.person,
//                               //         color: Colors.grey.shade600,
//                               //         size: 30,
//                               //       )
//                               //     :
//                               Image.network(
//                             "https://picsum.photos/seed/picsum/200/300",
//                             fit: BoxFit.cover,
//                             width: MediaQuery.of(context).size.width,
//                           ),
//                         ),
//                       ),
//                       radius: 17,
//                       backgroundColor: Colors.grey.shade300,
//                     ),
//                     SizedBox(
//                       width: 15,
//                     ),
//                     Expanded(
//                       child: TextField(
//                         decoration: InputDecoration(
//                             fillColor: Colors.black,
//                             hintText: "Add a comment...",
//                             hintStyle: TextStyle(color: Colors.black54),
//                             border: InputBorder.none),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 15,
//                     ),
//                     GestureDetector(
//                       onTap: (() {}),
//                       child: Text(
//                         "Post   ",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.blue),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
