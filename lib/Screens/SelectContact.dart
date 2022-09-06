import 'dart:developer';

import 'package:chatapp/CustomUI/ButtonCard.dart';
import 'package:chatapp/CustomUI/ContactCard.dart';
import 'package:chatapp/Model/ChatModel.dart';
import 'package:chatapp/Screens/CreateGroup.dart';
import 'package:chatapp/Screens/IndividualPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SelectContact extends StatefulWidget {
  SelectContact({Key? key, required this.number}) : super(key: key);
  final String number;
  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  // void addContact(String name, String status, String number) {
  //   final _contact = <String, String>{
  //     "name": name,
  //     "number": 'contact',
  //     "status": ''
  //   };
  // }

  //final auth = FirebaseAuth.instance;
  // String? number;

  @override
  Widget build(BuildContext context) {
    // List<ChatModel> contacts = [
    //   ChatModel(name: "Kipo", status: "A cyber security expert"),
    //   ChatModel(name: "Nimako", status: "Flutter Developer..........."),
    //   ChatModel(name: "Amo Mensah", status: "Web developer..."),
    //   ChatModel(name: "Frank Adu", status: "App developer...."),
    //   ChatModel(name: "Collins", status: "Raect developer.."),
    //   ChatModel(name: "Kwadwo", status: "Full Stack Web"),
    //   ChatModel(name: "Ike", status: "Rich gang"),
    //   ChatModel(name: "Simi", status: "Sharing is caring"),
    //   ChatModel(name: "Tempest", status: "....."),
    //   ChatModel(name: "Banaya", status: "Love you Mom Dad"),
    //   ChatModel(name: "Dev Arafat", status: "I've found the bugs"),
    // ];
    Stream<QuerySnapshot<Object?>>? contacts = FirebaseFirestore.instance
        .collection('users')
        .where('number', isNotEqualTo: widget.number)
        .orderBy('number', descending: true)
        .snapshots();
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Contact",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "256 contacts",
                style: TextStyle(
                  fontSize: 13,
                ),
              )
            ],
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  size: 26,
                ),
                onPressed: () {}),
            PopupMenuButton<String>(
              padding: EdgeInsets.all(0),
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext contesxt) {
                return [
                  PopupMenuItem(
                    child: Text("Contacts"),
                    value: "Contacts",
                  ),
                  PopupMenuItem(
                    child: Text("Help"),
                    value: "Help",
                  ),
                ];
              },
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: contacts,
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
                    //log(data['message']);
                    // return ListTile(
                    //   title: Text('sadsdas',
                    //       style: TextStyle(color: Colors.black)),
                    // );

                    //  if ( index== 0) {
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => CreateGroup()));
                      },
                      child: ButtonCard(
                        icon: Icons.group,
                        name: "New group",
                      ),
                    );
                    //}
                    // else if (index == 1) {
                    //   return ButtonCard(
                    //     icon: Icons.person_add,
                    //     name: "New contact",
                    //   );
                    // }
                    return ContactCard(
                      onTap: () {
                        // setState(() {
                        //   number = auth.currentUser!.phoneNumber;
                        // });
                        widget.number == data['number']
                            ? null
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => IndividualPage(
                                          tag: data['name'],
                                          senderNumber: widget.number,
                                          receiverNumber: data['number'],
                                        )));
                      },
                      name: data['name'],
                      number: data['number'],
                      status: data['status'],
                    );
                  })
                  .toList()
                  .cast(),
            );
          },
          // body: StreamBuilder<QuerySnapshot>(
          //   stream: contacts,
          //   builder: (context, snapshot) {
          //     return ListView(

          //       if (snapshot.hasError) {
          //       return Center(child: const Text('No chats'));
          //     }

          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return Center(child: CircularProgressIndicator());
          //     }

          //     return ListView(
          //       children: snapshot.data!.docs
          //           .map((DocumentSnapshot document) {
          //             Map<String, dynamic> data =
          //                 document.data()! as Map<String, dynamic>;
          //             log(data['message']);
          //             // return ListTile(
          //             //   title: Text('sadsdas',
          //             //       style: TextStyle(color: Colors.black)),
          //             // );

          //             return CustomCard(
          //               recentMessage: data['message'],
          //               time: data['time'],
          //               reciever: data['reciever'],
          //               tag: data['sender'] == number!
          //                   ? data['recieverName']
          //                   : data['senderName'],
          //               sender: data['sender'],
          //             );
          //           })
          //           .toList()
          //           .cast(),

          // itemCount: contacts.length + 2,
          // itemBuilder: (context, index) {
          //        if (snapshot.hasError) {
          //   return Center(child: const Text('No chats'));
          // }

          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(child: CircularProgressIndicator());
          // }
          // if (index == 0) {
          //   return InkWell(
          //     onTap: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (builder) => CreateGroup()));
          //     },
          //     child: ButtonCard(
          //       icon: Icons.group,
          //       name: "New group",
          //     ),
          //   );
          // } else if (index == 1) {
          //   return ButtonCard(
          //     icon: Icons.person_add,
          //     name: "New contact",
          //   );
          // }
          // return ContactCard(
          //   onTap: (){
          //     Navigator.push(context,
          //           MaterialPageRoute(builder: (builder) => IndividualPage(tag: '',senderNumber: '',receiverNumber: '',)));
          //   },
          //   contact: contacts[index - 2],
          // );
        ));
  }
}
