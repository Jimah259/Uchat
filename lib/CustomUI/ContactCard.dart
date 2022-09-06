import 'package:chatapp/Model/ChatModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, this.onTap, this.name, this.status, this.number})
      : super(key: key);
  // final ChatModel contact;
  final String? name;
  final String? status;
  final String? number;

  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    bool selected = false;
    return ListTile(
      leading: Container(
        width: 50,
        height: 53,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 23,
              child: SvgPicture.asset(
                "assets/person.svg",
                color: Colors.white,
                height: 30,
                width: 30,
              ),
              backgroundColor: Colors.blueGrey[200],
            ),
            // select
            //     ? Positioned(
            //         bottom: 4,
            //         right: 5,
            //         child: CircleAvatar(
            //           backgroundColor: Colors.teal,
            //           radius: 11,
            //           child: Icon(
            //             Icons.check,
            //             color: Colors.white,
            //             size: 18,
            //           ),
            //         ),
            //       )
            //     : Container(),
          ],
        ),
      ),
      title: Text(
        name!,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        status!,
        style: TextStyle(
          fontSize: 13,
        ),
      ),
      onTap: onTap,
    );
  }
}
