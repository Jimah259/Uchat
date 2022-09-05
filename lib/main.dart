import 'package:camera/camera.dart';
import 'package:chatapp/Screens/CameraScreen.dart';
import 'package:chatapp/Screens/Homescreen.dart';
import 'package:chatapp/Screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Widget defaultRoute = LoginScreen();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  cameras = await availableCameras();
  checkSignedIn() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    if (_auth.currentUser == null) {
      defaultRoute = defaultRoute;
    } else {
      defaultRoute = Homescreen();
    }
  }

  checkSignedIn();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            fontFamily: "OpenSans",
            primaryColor: Color(0xFF0277BD),
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(secondary: Color(0xFF039BE5))),
        home: defaultRoute);
  }
}
