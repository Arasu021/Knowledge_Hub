// import 'dart:convert';
// import 'dart:io';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_chips_input/flutter_chips_input.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:skein_community/Models/Feeds/GetFeedRes.dart';
// import 'package:skein_community/Models/Feeds/PostFeedReq.dart';
// import 'package:skein_community/Models/Feeds/PostFeedReq2.dart';
// import 'package:skein_community/Screens/dashboard2.dart';
// import 'package:skein_community/Utilities/strings.dart';
// import 'package:skein_community/network/ApiService.dart';

// class EditFeed extends StatefulWidget {
//   List<FeedsDatum>? feedsDataId;
//   EditFeed(this.feedsDataId);

//   @override
//   State<EditFeed> createState() => _EditFeedState(this.feedsDataId);
// }

// class _EditFeedState extends State<EditFeed> {
//   final TextEditingController feedController = TextEditingController();
//   final TextEditingController tagController = TextEditingController();
//   BuildContext? ctx;

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool? _isLoading = false;

//   dynamic value1;

//   late File imageFile;
//   XFile? image;
//   final ImagePicker _picker = ImagePicker();
//   String img64 = "";
//   List<FeedsDatum>? feedsDataId;
//   _EditFeedState(this.feedsDataId);

//   @override
//   void initState() {
//     // TODO: implement initState

//     getLocalData();
//   }

//   getLocalData() async {
//     String raw1 = jsonEncode(feedsDataId![0]);
//     Map<String, dynamic> jsondatais = jsonDecode(raw1);
//     print("------jsondetails" + jsondatais.toString());
//     var user = FeedsDatum.fromJson(jsondatais);
//     if (jsondatais.isNotEmpty) {
//       feedController.text = user.feedSummary.toString();
//       value1 = user.interests.toString();
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Provider<ApiService>(
//         create: (context) => ApiService.create(),
//         child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           body: Builder(builder: (BuildContext newContext) {
//             return feedpostPage(newContext);
//           }),
//         ));
//   }

//   feedpostPage(BuildContext context) {
//     const mockResults = <AppProfile>[
//       AppProfile('Skenians'),
//       AppProfile('Flutter'),
//       AppProfile('Node Js'),
//       AppProfile('Angular'),
//       AppProfile('React JS'),
//       AppProfile('IOS'),
//       AppProfile('Vue JS'),
//       AppProfile('MySQL'),
//       AppProfile('Mongo DB'),
//       AppProfile('GraphQL'),
//       AppProfile('Ionic'),
//       AppProfile('Android'),
//       AppProfile('PostgreSQL'),
//       AppProfile('Dynamodb'),
//       AppProfile('PHP'),
//       AppProfile('Django'),
//       AppProfile('Express JS'),
//       AppProfile('Ember JS'),
//       AppProfile('Nginx'),
//       AppProfile('Feather JS'),
//       AppProfile('Apache'),
//     ];
//     ctx = context;
//     var media = MediaQuery.of(context).size;
//     return SingleChildScrollView(
//       child: SafeArea(
//         child: Column(children: [
//           const Align(
//             alignment: Alignment.topLeft,
//             child: Text(
//               "  Edit Post",
//               style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Align(
//             alignment: Alignment.topLeft,
//             child: ListTile(
//               leading: CircleAvatar(
//                 child: ClipOval(
//                   child: Center(
//                     child: (Strings.myprofile![0].profilePicture == "" ||
//                             Strings.myprofile![0].profilePicture == null ||
//                             Strings.myprofile![0].profilePicture == "undefined")
//                         ? Icon(
//                             Icons.person,
//                             color: Colors.grey.shade700,
//                             size: 25,
//                           )
//                         : Image.network(
//                             //"https://picsum.photos/seed/picsum/200/300",
//                             "https://demo.emeetify.com:3422/${Strings.myprofile![0].profilePicture}",
//                             fit: BoxFit.cover,
//                             width: MediaQuery.of(context).size.width,
//                           ),
//                   ),
//                 ),
//                 radius: 30,
//                 backgroundColor: Colors.grey.shade300,
//               ),
//               title: Text(Strings.myprofile![0].fullName.toString()),
//               subtitle: Text(Strings.myprofile![0].designation.toString()),
//               // trailing: SizedBox(
//               //   width: 100,
//               // )
//             ),
//           ),
//           Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 (image != null)
//                     ? Stack(children: [
//                         Image.file(
//                           File(image!.path),
//                           width: 250,
//                           height: 190,
//                           fit: BoxFit.fitHeight,
//                         ),
//                         Positioned(
//                           top: 1,
//                           right: 1,
//                           child: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 image = null;
//                               });
//                             },
//                             child: Container(
//                               height: 30,
//                               width: 30,
//                               decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                       begin: Alignment.centerLeft,
//                                       end: Alignment.centerRight,
//                                       colors: [
//                                         Colors.yellow.shade700,
//                                         Colors.orange.shade600
//                                       ]),
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(20))),
//                               child: const Icon(
//                                 Icons.clear,
//                                 size: 17,
//                                 color: Colors.black54,
//                               ),
//                             ),
//                           ),
//                         )
//                       ])
//                     : Container(),
//                 Padding(
//                   padding:
//                       EdgeInsets.fromLTRB(20, (image != null) ? 10 : 50, 20, 4),
//                   child: TextFormField(
//                     autofocus: false,
//                     onFieldSubmitted: (value) {
//                       //Validator
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Enter a valid Email';
//                       }
//                       return null;
//                     },
//                     controller: feedController,
//                     maxLines: null,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white,
//                       //labelText: 'Username',
//                       //labelStyle: TextStyle(
//                       //color: Colors.black54,),
//                       // errorText: _validate ? 'Value Can\'t Be Empty' : null,

//                       errorStyle: const TextStyle(
//                         color: Colors.red,
//                       ),
//                       hintText: 'Write Something....',
//                       hintStyle: const TextStyle(
//                         color: Colors.black54,
//                       ),
//                       prefixIcon: const Icon(
//                         Icons.textsms_outlined,
//                         color: Colors.black54,
//                       ),
//                       suffixIcon: GestureDetector(
//                         onTap: () {
//                           _showPicker(context);
//                         },
//                         child: Container(
//                           height: 0.5,
//                           width: 0.5,
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                                 begin: Alignment.centerLeft,
//                                 end: Alignment.centerRight,
//                                 colors: [
//                                   Colors.yellow.shade700,
//                                   Colors.orange.shade600
//                                 ]),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: const Icon(
//                             Icons.add_photo_alternate,
//                             color: Colors.white,
//                             size: 20,
//                           ),
//                         ),
//                       ),
//                       contentPadding: const EdgeInsets.only(
//                           left: 14.0, bottom: 20.0, top: 20.0),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.grey.shade300),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide:
//                             BorderSide(color: Colors.grey.shade300, width: 5),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                     ),
//                     //           validator: (value) =>
//                     // value!.isEmpty ? 'Email cannot be blank' : null,
//                     keyboardType: TextInputType.emailAddress,
//                   ),
//                 ),
//                 SizedBox(
//                   width: media.width * 1,
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(20, 50, 20, 4),
//                     child: ChipsInput(
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         errorStyle: const TextStyle(
//                           color: Colors.red,
//                         ),
//                         hintText: 'Add tags',
//                         hintStyle: const TextStyle(
//                           color: Colors.black54,
//                         ),
//                         prefixIcon: const Icon(
//                           Icons.bookmark_add_outlined,
//                           color: Colors.black54,
//                         ),
//                         contentPadding: const EdgeInsets.only(
//                             left: 14.0, bottom: 20.0, top: 20.0),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey.shade300),
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         enabledBorder: UnderlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Colors.grey.shade300, width: 5),
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                       //  key: _chipKey,
//                       findSuggestions: (String query) {
//                         // print("Query: '$query'");
//                         if (query.isNotEmpty) {
//                           var lowercaseQuery = query.toLowerCase();
//                           return mockResults.where((profile) {
//                             return profile.name
//                                 .toLowerCase()
//                                 .contains(query.toLowerCase());
//                           }).toList(growable: false)
//                             ..sort((a, b) => a.name
//                                 .toLowerCase()
//                                 .indexOf(lowercaseQuery)
//                                 .compareTo(b.name
//                                     .toLowerCase()
//                                     .indexOf(lowercaseQuery)));
//                         }
//                         // return <AppProfile>[];
//                         return mockResults;
//                       },
//                       onChanged: (data) {
//                         value1 = data;
//                         print(data);
//                       },
//                       chipBuilder: (context, state, dynamic profile) {
//                         return InputChip(
//                           key: ObjectKey(profile),
//                           label: Text(profile.name),
//                           onDeleted: () => state.deleteChip(profile),
//                           materialTapTargetSize:
//                               MaterialTapTargetSize.shrinkWrap,
//                         );
//                       },
//                       suggestionBuilder: (context, state, dynamic profile) {
//                         return ListTile(
//                           key: ObjectKey(profile),
//                           // leading: CircleAvatar(
//                           //   backgroundImage: NetworkImage(profile.imageUrl),
//                           // ),
//                           title: Text(profile.name),
//                           // subtitle: Text(profile.email),
//                           onTap: () => state.selectSuggestion(profile),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Align(
//             alignment: Alignment.centerRight,
//             heightFactor: media.width * 0.006,
//             widthFactor: media.width * 0.006,
//             child: SizedBox(
//               height: media.height * 0.07,
//               width: media.width * 0.4,
//               child: InkWell(
//                 onTap: () {
//                   setState(
//                     () {
//                       final FormState? form = _formKey.currentState;
//                       if (form!.validate()) {
//                         _isLoading = true;
//                         Postfeed();
//                         print('Form is valid');
//                       } else {
//                         print('Form is invalid');
//                       }
//                     },
//                   );
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                         colors: [
//                           Colors.yellow.shade700,
//                           Colors.orange.shade600
//                         ]),
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const <Widget>[
//                       Text(
//                         ('POST'),
//                         style: TextStyle(fontSize: 18, color: Colors.white),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(width: 5),
//                       Icon(
//                         Icons.send,
//                         color: Colors.white,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }

//   void _showPicker(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Container(
//               child: new Wrap(
//                 children: <Widget>[
//                   new ListTile(
//                       leading: new Icon(Icons.photo_library),
//                       title: new Text('Gallery'),
//                       onTap: () {
//                         _getFromGallery();
//                         Navigator.of(context).pop();
//                       }),
//                   new ListTile(
//                     leading: new Icon(Icons.photo_camera),
//                     title: new Text('Camera'),
//                     onTap: () {
//                       _getFromCamera();
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   _getFromGallery() async {
//     image =
//         await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
//     setState(() {
//       if (image != null) {
//         final bytes = File(image!.path).readAsBytesSync();
//         img64 = base64Encode(bytes);
//         print("img64" + img64);
//         setState(() {});
//         print('image selected.');
//       } else {
//         setState(() {});
//         print('No image selected.');
//       }
//     });
//   }

//   /// Get from Camera
//   _getFromCamera() async {
//     image =
//         await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
//     setState(() {
//       if (image != null) {
//         final bytes = File(image!.path).readAsBytesSync();
//         img64 = base64Encode(bytes);
//         setState(() {});
//         print('image selected.');
//       } else {
//         setState(() {});
//         print('No image selected.');
//       }
//     });
//   }

//   Postfeed() {
//     print("uid" + Strings.user_id.toString());
//     // functions.showprogress();
//     PostFeedReq2 feedReq2 = PostFeedReq2();
//     feedReq2.userId = Strings.user_id;
//     feedReq2.feedSummary = feedController.text;
//     feedReq2.interests = value1.toString();

//     PostFeedReq feedReq = PostFeedReq();
//     feedReq.userId = Strings.user_id;
//     feedReq.feedSummary = feedController.text;
//     feedReq.interests = value1.toString();
//     feedReq.feedImage = "data:image/jpeg;base64,$img64";

//     final api = Provider.of<ApiService>(ctx!, listen: false);
//     (img64 == null || img64 == "")
//         ? api.postFeed2(feedReq2).then((response) {
//             print('response ${response.status}');
//             print("result1:$response");

//             if (response.status == true) {
//               _isLoading = false;
//               //  Get.off(() => DashPage());
//               Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => const DashPage()));
//               print("result2:$response");
//             } else {
//               print("error");
//             }
//           })
//         : api.postFeed(feedReq).then((response) {
//             print('response ${response.status}');
//             print("result3:$response");

//             if (response.status == true) {
//               _isLoading = false;
//               // Get.off(() => DashPage());
//               Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => const DashPage()));
//               print("result4:$response");
//             } else {
//               print("error");
//             }
//           });
//   }
// }

// class AppProfile {
//   final String name;

//   const AppProfile(
//     this.name,
//   );

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is AppProfile &&
//           runtimeType == other.runtimeType &&
//           name == other.name;

//   @override
//   int get hashCode => name.hashCode;

//   @override
//   String toString() {
//     return name;
//   }
// }
