// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:skein_community/Screens/ChatScreen.dart';

// class DiscussionScreen extends StatefulWidget {
//   const DiscussionScreen({Key? key}) : super(key: key);

//   @override
//   _DiscussionScreenState createState() => _DiscussionScreenState();
// }

// class _DiscussionScreenState extends State<DiscussionScreen> {
//   String dropdownValue = 'Customer';
//   final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

//   //User? user;

//   @override
//   Widget build(BuildContext context) {
//     var media = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Container(
//         height: media.height * 1,
//         width: media.width * 1,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(height: media.height * 0.05),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: SizedBox(
//                     height: 50,
//                     width: 50,
//                     child: GestureDetector(
//                       onTap: () {
//                         print("drawer");
//                         _key.currentState?.openDrawer();
//                       },
//                       child: Icon(
//                         Icons.menu,
//                         size: 30,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: SizedBox(
//                     height: 50,
//                     width: 50,
//                     child: GestureDetector(
//                       onTap: () {},
//                       child: Icon(
//                         Icons.search,
//                         size: 30,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Questions",
//                   style: TextStyle(
//                       fontSize: 20,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w700),
//                 ),
//                 Text(
//                   "Feeds",
//                   style: TextStyle(
//                       fontSize: 20,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w700),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: media.height * 0.02,
//             ),
//             SizedBox(
//               height: media.height * 0.6,
//               width: media.width * 0.9,
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(25),
//                   boxShadow: <BoxShadow>[
//                     BoxShadow(
//                         color: Colors.deepOrange.shade200,
//                         spreadRadius: 2,
//                         blurRadius: 4.0,
//                         offset: Offset(0, 15))
//                   ],
//                   color: Colors.deepOrange.shade300,
//                 ),
//                 child: Column(children: [
//                   SizedBox(
//                     height: media.height * 0.04,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.thumb_up,
//                             color: Colors.grey.shade300,
//                             size: 20,
//                           )),
//                       Text("14",
//                           style: TextStyle(fontSize: 12, color: Colors.white)),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.comment_outlined,
//                             color: Colors.grey.shade300,
//                             size: 20,
//                           )),
//                       Text("0",
//                           style: TextStyle(fontSize: 12, color: Colors.white)),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.visibility,
//                             color: Colors.grey.shade300,
//                             size: 20,
//                           )),
//                       Text("25",
//                           style: TextStyle(fontSize: 12, color: Colors.white)),
//                     ],
//                   ),
//                   SizedBox(
//                     height: media.height * 0.02,
//                   ),
//                   Flexible(
//                     child: Text(
//                       "How to write snapshot test for React Big calender",
//                       style: TextStyle(fontSize: 30, color: Colors.white),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   SizedBox(
//                     height: media.height * 0.15,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100),
//                         border: Border.all(width: 1, color: Colors.white)),
//                     width: media.width * 0.6,
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         child: ClipOval(
//                           child: Center(
//                             child: Image.network(
//                               "https://picsum.photos/seed/picsum/200/300",
//                               fit: BoxFit.cover,
//                               width: MediaQuery.of(context).size.width,
//                             ),
//                           ),
//                         ),
//                         radius: 20,
//                         backgroundColor: Colors.grey.shade300,
//                       ),
//                       title: Text("Arasuewaran R"),
//                       subtitle: Text("flutter developer"),
//                       // trailing: SizedBox(
//                       //   width: 100,
//                       // )
//                     ),
//                   ),
//                 ]),
//               ),
//             ),

//             //floating action button position to center
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: 'post',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat),
//             label: 'Chats',
//           ),
//         ],
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {},
//       //   tooltip: 'Increment Counter',
//       //   child: Icon(Icons.add),
//       // ),
//       // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       // bottomNavigationBar: BottomAppBar(
//       //   //bottom navigation bar on scaffold
//       //   color: Colors.redAccent,
//       //   shape: CircularNotchedRectangle(), //shape of notch
//       //   notchMargin:
//       //       5, //notche margin between floating button and bottom appbar
//       //   child: Row(
//       //     //children inside bottom appbar
//       //     mainAxisSize: MainAxisSize.max,
//       //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       //     children: <Widget>[
//       //       IconButton(
//       //         icon: Icon(
//       //           Icons.home_outlined,
//       //           color: Colors.white,
//       //         ),
//       //         onPressed: () {},
//       //       ),
//       //       IconButton(
//       //         icon: Icon(
//       //           Icons.search,
//       //           color: Colors.white,
//       //         ),
//       //         onPressed: () {},
//       //       ),
//       //       IconButton(
//       //         icon: Icon(
//       //           Icons.favorite_outline,
//       //           color: Colors.white,
//       //         ),
//       //         onPressed: () {},
//       //       ),
//       //       IconButton(
//       //         icon: Icon(
//       //           Icons.people,
//       //           color: Colors.white,
//       //         ),
//       //         onPressed: () {
//       //           var kk = "123";
//       //           var nn = 123;
//       //           Get.off(() => SOSDiscussPage(
//       //                 sosId: nn,
//       //               ));
//       //         },
//       //       ),
//       //     ],
//       //   ),
//       // ),
//     );
//   }
// }
