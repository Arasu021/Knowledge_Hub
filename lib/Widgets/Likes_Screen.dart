import 'package:flutter/material.dart';
import 'package:skein_community/Models/Feeds/GetLikeUsersRes.dart';
import 'package:skein_community/Models/Questions/GetQuesLikedRes.dart';

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
  List<GetQuesLikeData>? QuesLikesData;
  QuesLikeScreen(this.QuesLikesData);

  @override
  State<QuesLikeScreen> createState() =>
      _QuesLikeScreenState(this.QuesLikesData);
}

class _QuesLikeScreenState extends State<QuesLikeScreen> {
  List<GetQuesLikeData>? QuesLikesData;

  GetQuesLikeData? selectedUser;

  _QuesLikeScreenState(this.QuesLikesData);
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
      body: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: QuesLikesData?.length,
        itemBuilder: (BuildContext context, int index) => InkWell(
            // onTap: () {
            //   //print(data![index].id);
            //   setState(() {
            //     selectedUser = QuesLikesData![index];
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
                  child: (QuesLikesData![index].profilePicture == "" ||
                          QuesLikesData![index].profilePicture == null ||
                          QuesLikesData![index].profilePicture == "undefined")
                      ? Icon(
                          Icons.person,
                          color: Colors.grey.shade600,
                          size: 30,
                        )
                      : Image.network(
                          "https://demo.emeetify.com:3422/" +
                              (QuesLikesData![index].profilePicture.toString()),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                ),
              ),
              radius: 25,
              backgroundColor: Colors.grey.shade300,
            ),
            title: Text(QuesLikesData![index].fullName.toString()),
            subtitle: Text(QuesLikesData![index].designation.toString()),
            // trailing: SizedBox(
            //   width: 100,
            // )
          ),
        )),
      ),
    );
  }
}
