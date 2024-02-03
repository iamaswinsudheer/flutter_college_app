import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tc_college_app/screens/authentication/welcome.dart';
import 'package:tc_college_app/screens/home/home.dart';
import 'package:tc_college_app/services/manageToken.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TC College App",
      home: FutureBuilder<String?>(
        future: TokenManager.getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Home();
            } else {
              return Welcome();          
               }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
