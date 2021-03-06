import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skein_community/Models/Chat/chatUsersModel.dart';
import 'package:skein_community/Widgets/conversationList.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
      name: "Jane Russel",
      messageText: "Awesome Setup",
      imageURL: "https://picsum.photos/seed/picsum/200/300",
      time: "Now",
    ),
    ChatUsers(
      name: "Glady's Murphy",
      messageText: "That's Great",
      imageURL: "https://picsum.photos/seed/picsum/200/300",
      time: "Yesterday",
    ),
    ChatUsers(
      name: "Jorge Henry",
      messageText: "Hey where are you?",
      imageURL: "https://picsum.photos/seed/picsum/200/300",
      time: "31 Mar",
    ),
    ChatUsers(
      name: "Philip Fox",
      messageText: "Busy! Call me in 20 mins",
      imageURL: "https://picsum.photos/seed/picsum/200/300",
      time: "28 Mar",
    ),
    ChatUsers(
      name: "Debra Hawkins",
      messageText: "Thankyou, It's awesome",
      imageURL: "https://picsum.photos/seed/picsum/200/300",
      time: "23 Mar",
    ),
    ChatUsers(
      name: "Jorge Henry",
      messageText: "Hey where are you?",
      imageURL: "https://picsum.photos/seed/picsum/200/300",
      time: "31 Mar",
    ),
    ChatUsers(
      name: "Philip Fox",
      messageText: "Busy! Call me in 20 mins",
      imageURL: "https://picsum.photos/seed/picsum/200/300",
      time: "28 Mar",
    ),
    ChatUsers(
      name: "Debra Hawkins",
      messageText: "Thankyou, It's awesome",
      imageURL: "https://picsum.photos/seed/picsum/200/300",
      time: "23 Mar",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Conversations",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    // Container(
                    //   padding:
                    //       EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                    //   height: 30,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(30),
                    //     color: Colors.pink[50],
                    //   ),
                    //   child: Row(
                    //     children: <Widget>[
                    //       Icon(
                    //         Icons.add,
                    //         color: Colors.pink,
                    //         size: 20,
                    //       ),
                    //       SizedBox(
                    //         width: 2,
                    //       ),
                    //       Text(
                    //         "Add New",
                    //         style: TextStyle(
                    //             fontSize: 14, fontWeight: FontWeight.bold),
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  contentPadding: EdgeInsets.all(8),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ConversationList(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].messageText,
                  imageURL: chatUsers[index].imageURL,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
