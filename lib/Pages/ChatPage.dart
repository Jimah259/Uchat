import 'dart:developer';

import 'package:chatapp/CustomUI/CustomCard.dart';
import 'package:chatapp/Model/ChatModel.dart';
import 'package:chatapp/Screens/SelectContact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart' show StreamGroup;

class ChatPage extends StatefulWidget {
  ChatPage({
    Key? key,
    required this.number,
  }) : super(key: key);
  final String number;
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String? number;
  Stream<QuerySnapshot<Object?>>? result;
  @override
  void initState() {
    number = widget.number;

    result = StreamGroup.merge([
      FirebaseFirestore.instance
          .collection('chats')
          .where('sender', isEqualTo: widget.number)
          .orderBy('time', descending: true)
          .snapshots(),
      FirebaseFirestore.instance
          .collection('chats')
          .where('reciever', isEqualTo: widget.number)
          .orderBy('time', descending: true)
          .snapshots(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(number!);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => SelectContact()));
          },
          child: Icon(
            Icons.chat,
            color: Colors.white,
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: result!,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: const Text('No chats'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    log(data['message']);
                    // return ListTile(
                    //   title: Text('sadsdas',
                    //       style: TextStyle(color: Colors.black)),
                    // );

                    return CustomCard(
                      recentMessage: data['message'],
                      time: data['time'],
                      reciever: data['reciever'],
                      tag: data['sender'] == number!
                          ? data['recieverName']
                          : data['senderName'],
                      sender: data['sender'],
                    );
                  })
                  .toList()
                  .cast(),
            );
          },
        ));
  }
}
