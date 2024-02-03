import 'package:flutter/material.dart';
import 'package:tc_college_app/screens/shared/constants.dart';
import 'package:tc_college_app/screens/shared/customShapes.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: themeColor,
          ),
          Container(
            child: Transform.translate(
              offset: Offset(-screenSize.width * 0.2, screenSize.height * 0.15),
              child: Transform.scale(
                scaleY: (screenSize.width / 4) * 0.015,
                child: CustomPaint(
                  painter: FaceOutlinePainter(),
                  child: Container(),
                ),
              ),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        width: screenSize.width,
                        height: screenSize.height * 0.6,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            )),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.12, vertical: screenSize.height * 0.08),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Forgot\nPassword?',
                                style: TextStyle(
                                  fontSize: 28.0,
                                  color: themeColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: (screenSize.height / 2) * 0.1),
                              Text(
                                'Don\'t worry, it happens. Please contact office for provisioning new login credentials',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(height: (screenSize.height / 2) * 0.15),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.call,
                                    color: Colors.grey[600],
                                  ),
                                  SizedBox(
                                    width: (screenSize.width) * 0.02,
                                  ),
                                  SelectableText(
                                    '+91 9207313116',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: (screenSize.height / 2) * 0.05),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.email,
                                    color: Colors.grey[600],
                                  ),
                                  SizedBox(
                                    width: (screenSize.width) * 0.02,
                                  ),
                                  SelectableText(
                                    'sm@travelconnect.in',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
