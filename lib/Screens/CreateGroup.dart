import 'package:chatapp/CustomUI/AvtarCard.dart';
import 'package:chatapp/CustomUI/ButtonCard.dart';
import 'package:chatapp/CustomUI/ContactCard.dart';
import 'package:chatapp/Model/ChatModel.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(name: "Kipo", status: "A cyber security expert"),
    ChatModel(name: "Nimako", status: "Flutter Developer..........."),
    ChatModel(name: "Amo Mensah", status: "Web developer..."),
    ChatModel(name: "Frank Adu", status: "App developer...."),
    ChatModel(name: "Collins", status: "Raect developer.."),
    ChatModel(name: "Kwadwo", status: "Full Stack Web"),
    ChatModel(name: "Ike", status: "Rich gang"),
    ChatModel(name: "Simi", status: "Sharing is caring"),
    ChatModel(name: "Tempest", status: "....."),
    ChatModel(name: "Banaya", status: "Love you Mom Dad"),
    ChatModel(name: "Dev Arafat", status: "I've found the bugs"),
  ];
  List<ChatModel> groupmember = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Group",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Add participants",
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
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFF128C7E),
            onPressed: () {},
            child: Icon(Icons.arrow_forward)),
        body: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Stack(
                children: [
                  ListView.builder(
                      itemCount: contacts.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Container(
                            height: groupmember.length > 0 ? 90 : 10,
                          );
                        }
                        return InkWell(
                          onTap: () {
                            setState(() {
                              if (contacts[index - 1].select == true) {
                                groupmember.remove(contacts[index - 1]);
                                contacts[index - 1].select = false;
                              } else {
                                groupmember.add(contacts[index - 1]);
                                contacts[index - 1].select = true;
                              }
                            });
                          },
                          child: ContactCard(
                            // contact: contacts[index - 1],
                            name: '',
                            status: '',
                            number: '',
                          ),
                        );
                      }),
                  groupmember.length > 0
                      ? Align(
                          child: Column(
                            children: [
                              Container(
                                height: 75,
                                color: Colors.white,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: contacts.length,
                                    itemBuilder: (context, index) {
                                      if (contacts[index].select == true)
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              groupmember
                                                  .remove(contacts[index]);
                                              contacts[index].select = false;
                                            });
                                          },
                                          child: AvatarCard(
                                            chatModel: contacts[index],
                                          ),
                                        );
                                      return Container();
                                    }),
                              ),
                              Divider(
                                thickness: 1,
                              ),
                            ],
                          ),
                          alignment: Alignment.topCenter,
                        )
                      : Container(),
                ],
              );
            }));
  }
}
