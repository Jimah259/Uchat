import 'package:chatapp/CustomUI/MomentCard.dart';
import 'package:chatapp/Model/MomentModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MomentPage extends StatefulWidget {
  const MomentPage({Key? key}) : super(key: key);

  @override
  State<MomentPage> createState() => _MomentPageState();
}

class _MomentPageState extends State<MomentPage> {
  List<MomentModel> demoMoments = [
    MomentModel(
        mediaUrl: "assets/1.jpg", senderName: "Kipo", id: '1', image: true),
    MomentModel(
        mediaUrl: "assets/1.jpg", senderName: "Isaiah", id: '2', image: true),
    MomentModel(
        mediaUrl: "assets/1.jpg", senderName: "S.A", id: '3', image: true),
    MomentModel(
        mediaUrl: "assets/1.jpg", senderName: "Amigo", id: '4', image: true),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: demoMoments.length,
        itemBuilder: (contex, index) =>
            MomentCard(momentModel: demoMoments[index]),
      ),
    );
  }
}
