// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_ui/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_ui/models/chat_contact.dart';

class YourContacts extends StatefulWidget {
  const YourContacts({Key? key}) : super(key: key);

  @override
  State<YourContacts> createState() => _YourContactsState();
}

class _YourContactsState extends State<YourContacts> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Contact'),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data!.docs[index];
                  return ListTile(
                    title: Text(
                      doc['name'],
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        doc['profilePic'],
                      ),
                      radius: 30,
                    ),
                    trailing: Text(
                      '',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  );

                  // ChatContact(name: doc['name'], profilePic: doc['profilePic'], contactId: doc['uid'], timeSent: DateTime.now(), lastMessage: 'lastMessage');
                });
          } else {
            return Text("No contacts");
          }
        },
      ),
    );
  }
}
