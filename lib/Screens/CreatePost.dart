import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:provider/provider.dart';
import 'package:skein_community/Models/Feeds/PostFeedReq2.dart';
import 'package:skein_community/Utilities/strings.dart';
import 'package:skein_community/Widgets/PostFeedWidget.dart';
import 'package:skein_community/Widgets/PostQuesWidget.dart';
import 'package:skein_community/network/ApiService.dart';
import 'package:skein_community/functions/functions.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  //final _chipKey = GlobalKey<ChipsInputState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'New Post',
              textScaleFactor: 1.12,
              style: TextStyle(
                color: Colors.black.withOpacity(.7),
                fontWeight: FontWeight.w700,
              ),
            ),
            // actions: [
            //   FlatButton(
            //     onPressed: () {
            //       final FormState? form = _formKey.currentState;
            //       if (form!.validate()) {
            //         isLoading = true;
            //         Postfeed();
            //       }
            //     },
            //     child: Text(
            //       "Post",
            //       style: TextStyle(fontSize: 18, color: Colors.blue),
            //     ),
            //   ),
            // ],
            bottom: TabBar(
              indicatorColor: Colors.black.withOpacity(.8),
              unselectedLabelStyle:
                  TextStyle(color: Colors.black.withOpacity(.5)),
              unselectedLabelColor: Colors.black.withOpacity(.4),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.black.withOpacity(.8),
              tabs: [
                const Tab(
                  child: const Text(
                    'Create Feeds',
                  ),
                ),
                Tab(
                  child: Text(
                    'Create Questions',
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              PostFeed(),
              PostQues(),
            ],
          )),
    );
  }
}
