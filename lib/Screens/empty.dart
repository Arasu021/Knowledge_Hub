// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_chips_input/flutter_chips_input.dart';

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final _chipKey = GlobalKey<ChipsInputState>();
//   @override
//   Widget build(BuildContext context) {
//     const mockResults = <AppProfile>[
//       AppProfile('John Doe', 'jdoe@flutter.io',
//           'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
//       AppProfile('Paul', 'paul@google.com',
//           'https://mbtskoudsalg.com/images/person-stock-image-png.png'),
//       AppProfile('Fred', 'fred@google.com',
//           'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//       AppProfile('Brian', 'brian@flutter.io',
//           'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//       AppProfile('John', 'john@flutter.io',
//           'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//       AppProfile('Thomas', 'thomas@flutter.io',
//           'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//       AppProfile('Nelly', 'nelly@flutter.io',
//           'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//       AppProfile('Marie', 'marie@flutter.io',
//           'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//       AppProfile('Charlie', 'charlie@flutter.io',
//           'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//       AppProfile('Diana', 'diana@flutter.io',
//           'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//       AppProfile('Ernie', 'ernie@flutter.io',
//           'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//       AppProfile('Gina', 'fred@flutter.io',
//           'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Chips Input Example'),
//       ),
//       resizeToAvoidBottomInset: false,
//       body: Padding(
//         padding: EdgeInsets.all(20),
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               ChipsInput(
//                 key: _chipKey,
//                 /*initialValue: [
//                   AppProfile('John Doe', 'jdoe@flutter.io',
//                       'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
//                 ],*/
//                 // autofocus: true,
//                 // allowChipEditing: true,
//                 keyboardAppearance: Brightness.dark,
//                 textCapitalization: TextCapitalization.words,
//                 // enabled: false,
//                 // maxChips: 5,
//                 textStyle: const TextStyle(
//                     height: 1.5, fontFamily: 'Roboto', fontSize: 16),
//                 decoration: const InputDecoration(
//                   // prefixIcon: Icon(Icons.search),
//                   // hintText: formControl.hint,
//                   labelText: 'Select People',
//                   // enabled: false,
//                   // errorText: field.errorText,
//                 ),
//                 findSuggestions: (String query) {
//                   // print("Query: '$query'");
//                   if (query.isNotEmpty) {
//                     var lowercaseQuery = query.toLowerCase();
//                     return mockResults.where((profile) {
//                       return profile.name
//                               .toLowerCase()
//                               .contains(query.toLowerCase()) ||
//                           profile.email
//                               .toLowerCase()
//                               .contains(query.toLowerCase());
//                     }).toList(growable: false)
//                       ..sort((a, b) => a.name
//                           .toLowerCase()
//                           .indexOf(lowercaseQuery)
//                           .compareTo(
//                               b.name.toLowerCase().indexOf(lowercaseQuery)));
//                   }
//                   // return <AppProfile>[];
//                   return mockResults;
//                 },
//                 onChanged: (data) {
//                   // print(data);
//                 },
//                 chipBuilder: (context, state, dynamic profile) {
//                   return InputChip(
//                     key: ObjectKey(profile),
//                     label: Text(profile.name),
//                     avatar: CircleAvatar(
//                       backgroundImage: NetworkImage(profile.imageUrl),
//                     ),
//                     onDeleted: () => state.deleteChip(profile),
//                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                   );
//                 },
//                 suggestionBuilder: (context, state, dynamic profile) {
//                   return ListTile(
//                     key: ObjectKey(profile),
//                     leading: CircleAvatar(
//                       backgroundImage: NetworkImage(profile.imageUrl),
//                     ),
//                     title: Text(profile.name),
//                     subtitle: Text(profile.email),
//                     onTap: () => state.selectSuggestion(profile),
//                   );
//                 },
//               ),
//               TextField(),
//               /*ChipsInput(
//                 initialValue: [
//                   AppProfile('John Doe', 'jdoe@flutter.io',
//                       'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
//                 ],
//                 enabled: true,
//                 maxChips: 10,
//                 textStyle: TextStyle(height: 1.5, fontFamily: "Roboto", fontSize: 16),
//                 decoration: InputDecoration(
//                   // prefixIcon: Icon(Icons.search),
//                   // hintText: formControl.hint,
//                   labelText: "Select People",
//                   // enabled: false,
//                   // errorText: field.errorText,
//                 ),
//                 findSuggestions: (String query) {
//                   if (query.length != 0) {
//                     var lowercaseQuery = query.toLowerCase();
//                     return mockResults.where((profile) {
//                       return profile.name
//                           .toLowerCase()
//                           .contains(query.toLowerCase()) ||
//                           profile.email
//                               .toLowerCase()
//                               .contains(query.toLowerCase());
//                     }).toList(growable: false)
//                       ..sort((a, b) => a.name
//                           .toLowerCase()
//                           .indexOf(lowercaseQuery)
//                           .compareTo(
//                           b.name.toLowerCase().indexOf(lowercaseQuery)));
//                   } else {
//                     return mockResults;
//                   }
//                 },
//                 onChanged: (data) {
//                   print(data);
//                 },
//                 chipBuilder: (context, state, profile) {
//                   return InputChip(
//                     key: ObjectKey(profile),
//                     label: Text(profile.name),
//                     avatar: CircleAvatar(
//                       backgroundImage: NetworkImage(profile.imageUrl),
//                     ),
//                     onDeleted: () => state.deleteChip(profile),
//                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                   );
//                 },
//                 suggestionBuilder: (context, state, profile) {
//                   return ListTile(
//                     key: ObjectKey(profile),
//                     leading: CircleAvatar(
//                       backgroundImage: NetworkImage(profile.imageUrl),
//                     ),
//                     title: Text(profile.name),
//                     subtitle: Text(profile.email),
//                     onTap: () => state.selectSuggestion(profile),
//                   );
//                 },
//               ),*/
//               ElevatedButton(
//                 onPressed: () {
//                   _chipKey.currentState!.selectSuggestion(AppProfile(
//                       'Gina',
//                       'fred@flutter.io',
//                       'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'));
//                 },
//                 child: Text('Add Chip'),
//               ),
//             ],
//           ),
//         ),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

// class AppProfile {
//   final String name;
//   final String email;
//   final String imageUrl;

//   const AppProfile(this.name, this.email, this.imageUrl);

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


// // import 'dart:ui';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:fluttertoast/fluttertoast.dart';

// // class MyCustomUI extends StatefulWidget {
// //   @override
// //   _MyCustomUIState createState() => _MyCustomUIState();
// // }

// // class _MyCustomUIState extends State<MyCustomUI> with TickerProviderStateMixin {
// //   AnimationController _animationController;
// //   Animation<double> _animation1;
// //   Animation<double> _animation2;
// //   Animation<double> _animation3;

// //   bool _bool = true;

// //   @override
// //   void initState() {
// //     super.initState();

// //     _animationController =
// //         AnimationController(vsync: this, duration: Duration(milliseconds: 600));

// //     _animation1 = Tween<double>(begin: 0, end: 20).animate(CurvedAnimation(
// //       parent: _animationController,
// //       curve: Curves.easeOut,
// //       reverseCurve: Curves.easeIn,
// //     ))
// //       ..addListener(() {
// //         setState(() {});
// //       })
// //       ..addStatusListener((status) {
// //         if (status == AnimationStatus.dismissed) {
// //           _bool = true;
// //         }
// //       });
// //     _animation2 = Tween<double>(begin: 0, end: .3).animate(_animationController)
// //       ..addListener(() {
// //         setState(() {});
// //       });
// //     _animation3 = Tween<double>(begin: .9, end: 1).animate(CurvedAnimation(
// //         parent: _animationController,
// //         curve: Curves.fastLinearToSlowEaseIn,
// //         reverseCurve: Curves.ease))
// //       ..addListener(() {
// //         setState(() {});
// //       });
// //   }

// //   @override
// //   void dispose() {
// //     _animationController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     double _width = MediaQuery.of(context).size.width;
// //     double _height = MediaQuery.of(context).size.height;
// //     return Scaffold(
// //       extendBodyBehindAppBar: true,
// //       appBar: AppBar(
// //         brightness: Brightness.dark,
// //         elevation: 0,
// //         backgroundColor: Colors.transparent,
// //         leading: IconButton(
// //           icon: Icon(Icons.menu_rounded),
// //           splashColor: Colors.transparent,
// //           onPressed: () {
// //             if (_bool == true) {
// //               _animationController.forward();
// //             } else {
// //               _animationController.reverse();
// //             }
// //             _bool = false;
// //           },
// //         ),
// //       ),
// //       body: Stack(
// //         children: [
// //           // ALWAYS PLACE IT ON THE TOP OF EVERY WIDGET...
// //           BackgroundImage(),

// //           // EVERYTHING SHOULD BE HERE...
// //           SizedBox(
// //             height: _height,
// //             width: _width,
// //             child: null,
// //           ),

// //           // ALWAYS PLACE IT ON THE BOTTOM OF EVERY WIDGET...
// //           CustomNavigationDrawer(),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget CustomNavigationDrawer() {
// //     double _height = MediaQuery.of(context).size.height;
// //     double _width = MediaQuery.of(context).size.width;
// //     return BackdropFilter(
// //       filter: ImageFilter.blur(
// //           sigmaY: _animation1.value, sigmaX: _animation1.value),
// //       child: Container(
// //         height: _bool ? 0 : _height,
// //         width: _bool ? 0 : _width,
// //         color: Colors.transparent,
// //         child: Center(
// //           child: Transform.scale(
// //             scale: _animation3.value,
// //             child: Container(
// //               width: _width * .9,
// //               height: _width * 1.3,
// //               decoration: BoxDecoration(
// //                 color: Colors.white.withOpacity(_animation2.value),
// //                 borderRadius: BorderRadius.circular(30),
// //               ),
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                 children: [
// //                   CircleAvatar(
// //                     backgroundColor: Colors.black12,
// //                     radius: 35,
// //                     child: Icon(
// //                       Icons.person_outline_rounded,
// //                       size: 30,
// //                       color: Colors.white,
// //                     ),
// //                   ),
// //                   Column(
// //                     children: [
// //                       MyTile(Icons.settings_outlined, 'Settings', () {
// //                         HapticFeedback.lightImpact();
// //                         Fluttertoast.showToast(
// //                           msg: 'Button pressed',
// //                         );
// //                       }),
// //                       MyTile(Icons.info_outline_rounded, 'About', () {
// //                         HapticFeedback.lightImpact();
// //                         Fluttertoast.showToast(
// //                           msg: 'Button pressed',
// //                         );
// //                       }),
// //                       MyTile(Icons.feedback_outlined, 'Feedback', () {
// //                         HapticFeedback.lightImpact();
// //                         Fluttertoast.showToast(
// //                           msg: 'Button pressed',
// //                         );
// //                       }),
// //                       MyTile(Icons.find_in_page_outlined, 'Privacy Policy', () {
// //                         HapticFeedback.lightImpact();
// //                         Fluttertoast.showToast(
// //                           msg: 'Button pressed',
// //                         );
// //                       }),
// //                     ],
// //                   ),
// //                   SizedBox(),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget BackgroundImage() {
// //     return SizedBox(
// //       height: MediaQuery.of(context).size.height,
// //       child: Image.asset(
// //         'assets/images/background_image.png',
// //         fit: BoxFit.fitHeight,
// //       ),
// //     );
// //   }

// //   Widget MyTile(
// //     IconData icon,
// //     String title,
// //     VoidCallback voidCallback,
// //   ) {
// //     return Column(
// //       children: [
// //         ListTile(
// //           tileColor: Colors.black.withOpacity(.08),
// //           leading: CircleAvatar(
// //             backgroundColor: Colors.black12,
// //             child: Icon(
// //               icon,
// //               color: Colors.white,
// //             ),
// //           ),
// //           onTap: voidCallback,
// //           title: Text(
// //             title,
// //             style: TextStyle(
// //                 color: Colors.white,
// //                 fontWeight: FontWeight.bold,
// //                 letterSpacing: 1),
// //           ),
// //           trailing: Icon(
// //             Icons.arrow_right,
// //             color: Colors.white,
// //           ),
// //         ),
// //         divider()
// //       ],
// //     );
// //   }

// //   Widget divider() {
// //     return Container(
// //       height: 5,
// //       width: MediaQuery.of(context).size.width,
// //     );
// //   }
// // }
  // certificatecheck() {
  //   (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
  //       (HttpClient client) {
  //     client.badCertificateCallback =
  //         (X509Certificate cert, String host, int port) => true;
  //     return client;
  //   };
  // }

  
  //   certificatecheck();

  import 'package:flutter/material.dart';

typedef Future<List<T>> RequestFn<T>(int nextIndex);
typedef Widget ItemBuilder<T>(BuildContext context, T item, int index);

class InifiniteList<T> extends StatefulWidget {
  final RequestFn<T> onRequest;
  final ItemBuilder<T> itemBuilder;

  const InifiniteList(
      {Key? key, required this.onRequest, required this.itemBuilder})
      : super(key: key);

  @override
  _InifiniteListState<T> createState() => _InifiniteListState<T>();
}

class _InifiniteListState<T> extends State<InifiniteList<T>> {
  List<T> items = [];
  bool end = false;

  _getMoreItems() async {
    final moreItems = await widget.onRequest(items.length);
    if (!mounted) return;

    if (moreItems.isEmpty) {
      setState(() => end = true);
      return;
    }
    setState(() => items = [...items, ...moreItems]);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index < items.length) {
          return widget.itemBuilder(context, items[index], index);
        } else if (index == items.length && end) {
          return const Center(child: Text('End of list'));
        } else {
          _getMoreItems();
          return const SizedBox(
            height: 80,
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
      itemCount: items.length + 1,
    );
  }
}