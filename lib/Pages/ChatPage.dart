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
  // final List<ChatModel> chatmodels;
  // final ChatModel sourchat;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final  auth = FirebaseAuth.instance.currentUser!;
  //late User? sender = auth;
  // final Stream<QuerySnapshot> _mychatStream = FirebaseFirestore.instance
  //     .collection('chats')
  //     .where("sender", isEqualTo: sender!.phoneNumber)
  //     .orderBy("time");

//       final citiesRef = db.collection("cities");
// citiesRef.where("population", isGreaterThan: 100000).orderBy("population");
  @override
  Widget build(BuildContext context) {
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
              .collection('posts')
              .where('sender.uid', isEqualTo: auth.phoneNumber)
              .orderBy('postDate', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: const Text('No chats'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            return ListView(
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return CustomCard(
                      recentMessage: data['message'],
                      time: data['time'],
                      recieverNumber: data['sender'],
                      recieverName: data['senderName'],
                      senderNumber: data['reciever'],
                    );
                  })
                  .toList()
                  .cast(),
            );
          },
        ));
  }
}


// Widget build(BuildContext context) {
//     return 
//   }