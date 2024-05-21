import 'package:flutter/material.dart';
import 'package:tc_college_app/screens/authentication/login.dart';
import 'package:tc_college_app/screens/shared/constants.dart';
import 'package:tc_college_app/screens/shared/customShapes.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          CustomPaint(
            painter: WelcomeCustomShape(),
            child: Container(),
          ),
          Container(
            // color: Colors.white,
            padding: EdgeInsets.fromLTRB(
                screenSize.width * 0.08,
                screenSize.height * 0.25,
                screenSize.width * 0.08,
                screenSize.height * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/_Pngtree_education_and_online_learning_flat_5373900-removebg-preview.png',
                  //illustration PNG Designed By RedvyCreative from https://pngtree.com/freepng/education-and-
                  //online-learning-flat-concept_5373900.html?sol=downref&id=bef
                  height: 250.0,
                  width: 250.0,
                ),
                SizedBox(height: screenSize.height * 0.04),
                Text(
                  'Greetings!',
                  style: TextStyle(fontSize: 30.0),
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                Text(
                  'Welcome to TC College App, your gateway to academic excellence! Explore our app and discover a wealth of resources designed to enrich your educational journey.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: themeColor,
                          shape: BeveledRectangleBorder(),
                        ),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            letterSpacing: 1.5,
                          ),
                        )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
