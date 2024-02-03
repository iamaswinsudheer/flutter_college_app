import 'package:flutter/material.dart';
import 'package:tc_college_app/screens/shared/constants.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(child: CircularProgressIndicator(
          valueColor:AlwaysStoppedAnimation<Color>(themeColor),
        )),
      ),
    );
  }
}