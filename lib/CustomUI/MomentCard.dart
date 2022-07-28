import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Model/MomentModel.dart';

class MomentCard extends StatelessWidget {
  const MomentCard({
    Key? key,
    required this.momentModel,
  }) : super(key: key);
  final MomentModel momentModel;
  //final ChatModel sourchat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (contex) => IndividualMoments(moment: momentModel)));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(momentModel.mediaUrl!),
              // child: Image.asset(
              //   momentModel.mediaUrl!,
              //   fit: BoxFit.fill,
              //   //color: Colors.white,
              //   height: 36,
              //   width: 36,
              // ),
              backgroundColor: Colors.blueGrey,
            ),
            title: Text(
              momentModel.senderName!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                // Icon(Icons.done_all),
                // SizedBox(
                //   width: 3,
                // ),
                Text(
                  DateTime.now().toString(),
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            //trailing: Text(chatModel.time!),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class IndividualMoments extends StatefulWidget {
  const IndividualMoments({Key? key, required this.moment}) : super(key: key);
  final MomentModel moment;

  @override
  State<IndividualMoments> createState() => _IndividualMomentsState();
}

class _IndividualMomentsState extends State<IndividualMoments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget.moment.image!
            ? Container(child: Image.asset(widget.moment.mediaUrl!))
            : Container(child: Image.asset(widget.moment.mediaUrl!)));
  }
}
