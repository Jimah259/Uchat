import 'dart:developer';

import 'package:chatapp/CustomUI/CustomCard.dart';
import 'package:chatapp/Model/ChatModel.dart';
import 'package:chatapp/Screens/SelectContact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  ChatPage({
    Key? key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final auth = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    log(auth.phoneNumber!);
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
          stream: FirebaseFirestore.instance
              .collection('chats')
              .where('sender', isEqualTo: auth.phoneNumber)
              .orderBy('time', descending: true)
              .snapshots(),
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
                      reciever: data['sender'],
                      recieverName: data['senderName'],
                      sender: data['reciever'],
                    );
                  })
                  .toList()
                  .cast(),
            );
          },
        ));
  }
}
