import 'dart:developer';

import 'package:chatapp/CustomUI/ButtonCard.dart';
import 'package:chatapp/Model/ChatModel.dart';
import 'package:chatapp/Screens/Homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ChatModel? sourceChat;
  List<ChatModel> chatmodels = [
    ChatModel(
      name: "Kipo",
      isGroup: false,
      currentMessage: "Hi Everyone",
      time: "4:00",
      icon: "person.svg",
      id: 1,
    ),
    ChatModel(
      name: "Nimako",
      isGroup: false,
      currentMessage: "Hi Kipo",
      time: "13:00",
      icon: "person.svg",
      id: 2,
    ),
    ChatModel(
      name: "Collins",
      isGroup: false,
      currentMessage: "Hello Kipo",
      time: "8:00",
      icon: "person.svg",
      id: 3,
    ),
    ChatModel(
      name: "Amo Mensah",
      isGroup: false,
      currentMessage: "Hi Kipo",
      time: "2:00",
      icon: "person.svg",
      id: 4,
    ),
    ChatModel(
      name: "NSS Group",
      isGroup: true,
      currentMessage: "NSS pins to be out soon",
      time: "2:00",
      icon: "group.svg",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PhoneNumber? phone;
  String? smsCode;
  AuthCredential? _credential;
  TextEditingController _codeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool readTerms = true;
  bool readPrivacy = true;
  String initialCountry = 'GH';
  //PhoneNumber number = PhoneNumber(isoCode: 'NG');
  ChatModel demoChat = ChatModel(
    name: "Kipo",
    isGroup: false,
    currentMessage: "Hi Everyone",
    time: "4:00",
    icon: "person.svg",
    id: 1,
  );

  Future registerUser(String mobile, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {
          _auth.signInWithCredential(authCredential).then((result) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Homescreen(
                          chatmodels: [demoChat],
                          sourchat: demoChat,
                        )));
          }).catchError((e) {
            print(e);
          });
        },
        verificationFailed: (authException) {
          print(authException.message);
        },
        codeSent: (verificationId, [forceResendingToken]) {
          //show dialog to take input from the user
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                    title: Text("Enter SMS Code"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          controller: _codeController,
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text("Done"),
                        style: TextButton.styleFrom(
                          textStyle: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          FirebaseAuth auth = FirebaseAuth.instance;

                          smsCode = _codeController.text.trim();

                          _credential = PhoneAuthProvider.credential(
                              verificationId: verificationId,
                              smsCode: smsCode!);
                          auth
                              .signInWithCredential(_credential!)
                              .then((result) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Homescreen(
                                          chatmodels: [demoChat],
                                          sourchat: demoChat,
                                        )));
                          }).catchError((e) {
                            print(e);
                          });
                        },
                      )
                    ],
                  ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("Timout");
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Text(
              'Your Phone number',
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.lightBlue, width: 2),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: InternationalPhoneNumberInput(
                      locale: 'GH',
                      // countries: [
                      //   'GH',
                      // ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Phone number';
                        }
                        return null;
                      },
                      selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.DIALOG),
                      onInputChanged: (value) {},
                      onSaved: (PhoneNumber number) {
                        phone = number;
                        log(phone!.phoneNumber!);
                      }),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            CheckboxListTile(
              title: Row(
                children: [
                  Text(
                    'I have read and accepted the ',
                    style: TextStyle(fontSize: 14),
                  ),
                  Expanded(
                      child: Text(
                    'Privacy Policy',
                    style: TextStyle(fontSize: 12, color: Colors.green),
                  )),
                ],
              ),
              value: readTerms,
              onChanged: (value) {
                setState(() {
                  readTerms = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Row(
                children: [
                  Text(
                    'I have read and accepted the ',
                    style: TextStyle(fontSize: 14),
                  ),
                  Expanded(
                      child: Text(
                    'Terms of use',
                    style: TextStyle(fontSize: 12, color: Colors.green),
                  )),
                ],
              ),
              value: readPrivacy,
              onChanged: (value) {
                setState(() {
                  readPrivacy = value!;
                });
              },
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  fixedSize: Size(200, 50),
                  backgroundColor: Colors.lightBlue,
                  primary: Colors.white),
              onPressed: () {
                formKey.currentState!.save();
                if (readPrivacy && readTerms == !false) {
                  if (formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.

                    registerUser(phone!.phoneNumber!, context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (ctx) => Homescreen(
                  //             chatmodels: [demoChat], sourchat: demoChat)),
                  //     (route) => false);
                }
              },
              child: Text(
                'Next',
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// ListView.builder(
//           itemCount: chatmodels.length,
//           itemBuilder: (contex, index) => InkWell(
//                 onTap: () {
//                   sourceChat = chatmodels.removeAt(index);
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (builder) => Homescreen(
//                                 chatmodels: chatmodels,
//                                 sourchat: sourceChat!,
//                               )));
//                 },
//                 child: ButtonCard(
//                   name: chatmodels[index].name!,
//                   icon: Icons.person,
//                 ),
//               )),