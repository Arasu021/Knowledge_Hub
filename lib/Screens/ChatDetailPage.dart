import 'package:flutter/material.dart';

class SOSDiscussPage extends StatefulWidget {
  final int sosId;
  SOSDiscussPage({Key? key, required this.sosId}) : super(key: key);

  @override
  _SOSDiscussPageState createState() => _SOSDiscussPageState();
}

class _SOSDiscussPageState extends State<SOSDiscussPage> {
  final ScrollController _scsvController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discussion ${widget.sosId}'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: _scsvController,
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 30.00, horizontal: 15.00),
        child: Column(
          children: <Widget>[
            _Message(
              text:
                  "You referenced this issue at May 27, 2020 with the following users",
              isMe: false,
              time: '18:00',
            ),
            _Message(
              text: "Hello world!",
              isMe: true,
              time: '18:00',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 10.00),
          color: Colors.grey,
          child: Text('It should has a notch on it :/ --->'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.send),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class _Message extends StatelessWidget {
  final String text;
  final String time;
  final bool isMe;

  const _Message({
    Key? key,
    required this.text,
    required this.isMe,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return this.isMe ? _buildMyMessage(context) : _buildTheirMessage();
  }

  Widget _buildMyMessage(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5.00),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.00, horizontal: 15.00),
            constraints: BoxConstraints(maxWidth: 300.00),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.00),
                bottomLeft: Radius.circular(15.00),
                bottomRight: Radius.circular(15.00),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 5.00),
                  child: Text(
                    this.text.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.00,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 5.00),
                      child: Text(
                        this.time.toString(),
                        style: TextStyle(
                          fontSize: 10.00,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.done_all,
                      size: 13.00,
                      color: Colors.white,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTheirMessage() {
    return Container(
      margin: const EdgeInsets.only(bottom: 5.00),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.00, horizontal: 15.00),
            constraints: BoxConstraints(maxWidth: 300.00),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.00),
                bottomLeft: Radius.circular(15.00),
                bottomRight: Radius.circular(15.00),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 5.00),
                  child: Text(
                    this.text.toString(),
                    style: TextStyle(
                      fontSize: 14.00,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      this.time.toString(),
                      style: TextStyle(
                        fontSize: 10.00,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
