import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:provider/provider.dart';
import 'package:skein_community/Models/Feeds/PostFeedReq2.dart';
import 'package:skein_community/Utilities/strings.dart';
import 'package:skein_community/network/ApiService.dart';

class PostQues extends StatefulWidget {
  const PostQues({Key? key}) : super(key: key);

  @override
  State<PostQues> createState() => _PostQuesState();
}

class _PostQuesState extends State<PostQues> {
  final TextEditingController feedController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  BuildContext? ctx;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool? isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return QuesPostPage(newContext);
          }),
        ));
  }

  QuesPostPage(BuildContext context) {
    const mockResults = <AppProfile>[
      AppProfile('Flutter'),
      AppProfile('Node Js'),
      AppProfile('Angular'),
      AppProfile('React JS'),
      AppProfile('IOS'),
      AppProfile('Vue JS'),
      AppProfile('MySQL'),
      AppProfile('Mongo DB'),
      AppProfile('GraphQL'),
      AppProfile('Ionic'),
      AppProfile('Android'),
      AppProfile('PostgreSQL'),
      AppProfile('Dynamodb'),
      AppProfile('PHP'),
      AppProfile('Django'),
      AppProfile('Express JS'),
      AppProfile('Ember JS'),
      AppProfile('Nginx'),
      AppProfile('Feather JS'),
      AppProfile('Apache'),
    ];
    ctx = context;
    var media = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: media.height * 0.02,
        ),
        Align(
          alignment: Alignment.topLeft,
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
              radius: 30,
              backgroundColor: Colors.grey.shade300,
            ),
            title: Text("Arasuewaran R"),
            subtitle: Text("flutter developer"),
            // trailing: SizedBox(
            //   width: 100,
            // )
          ),
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 50, 20, 4),
                child: TextFormField(
                  autofocus: false,
                  onFieldSubmitted: (value) {
                    //Validator
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid Email';
                    }
                    return null;
                  },
                  controller: feedController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    //labelText: 'Username',
                    //labelStyle: TextStyle(
                    //color: Colors.black54,),
                    // errorText: _validate ? 'Value Can\'t Be Empty' : null,

                    errorStyle: const TextStyle(
                      color: Colors.red,
                    ),
                    hintText: 'Write Something....',
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                    ),
                    prefixIcon: const Icon(
                      Icons.textsms_outlined,
                      color: Colors.black54,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 1,
                        width: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.yellow.shade700,
                                Colors.orange.shade600
                              ]),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 20.0, top: 20.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  //           validator: (value) =>
                  // value!.isEmpty ? 'Email cannot be blank' : null,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(
                width: media.width * 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 4),
                  child: ChipsInput(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      errorStyle: const TextStyle(
                        color: Colors.red,
                      ),
                      hintText: 'Add tags',
                      hintStyle: const TextStyle(
                        color: Colors.black54,
                      ),
                      prefixIcon: const Icon(
                        Icons.bookmark_add_outlined,
                        color: Colors.black54,
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 20.0, top: 20.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    //  key: _chipKey,
                    findSuggestions: (String query) {
                      // print("Query: '$query'");
                      if (query.isNotEmpty) {
                        var lowercaseQuery = query.toLowerCase();
                        return mockResults.where((profile) {
                          return profile.name
                              .toLowerCase()
                              .contains(query.toLowerCase());
                        }).toList(growable: false)
                          ..sort((a, b) => a.name
                              .toLowerCase()
                              .indexOf(lowercaseQuery)
                              .compareTo(b.name
                                  .toLowerCase()
                                  .indexOf(lowercaseQuery)));
                      }
                      // return <AppProfile>[];
                      return mockResults;
                    },
                    onChanged: (data) {
                      print(data);
                    },
                    chipBuilder: (context, state, dynamic profile) {
                      return InputChip(
                        key: ObjectKey(profile),
                        label: Text(profile.name),
                        onDeleted: () => state.deleteChip(profile),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      );
                    },
                    suggestionBuilder: (context, state, dynamic profile) {
                      return ListTile(
                        key: ObjectKey(profile),
                        // leading: CircleAvatar(
                        //   backgroundImage: NetworkImage(profile.imageUrl),
                        // ),
                        title: Text(profile.name),
                        // subtitle: Text(profile.email),
                        onTap: () => state.selectSuggestion(profile),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          heightFactor: media.width * 0.006,
          widthFactor: media.width * 0.006,
          child: SizedBox(
            height: media.height * 0.07,
            width: media.width * 0.4,
            child: InkWell(
              onTap: () {
                setState(
                  () {
                    // _isLoading = true;
                    // final FormState? form = _formKey.currentState;
                    // if (form!.validate()) {
                    // signUpwithEmail();
                    //   print('Form is valid');
                    // } else {
                    //   print('Form is invalid');
                    // }
                    // print("next");
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.yellow.shade700, Colors.orange.shade600]),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      ('POST'),
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Postfeed() {
    // functions.showprogress();
    PostFeedReq2 feedReq2 = PostFeedReq2();
    feedReq2.userId = Strings.user_id;
    feedReq2.feedSummary = feedController.text;
    feedReq2.interests = tagController.text;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    //(feedReq2.interests ==null)?
    api.postFeed2(feedReq2).then((response) {
      print('response ${response.status}');
      print("result:$response");

      if (response.status == true) {
        isLoading = false;

        print("result:$response");
      } else {
        print("error");
      }
    });
  }
}

class AppProfile {
  final String name;

  const AppProfile(
    this.name,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppProfile &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name;
  }
}
