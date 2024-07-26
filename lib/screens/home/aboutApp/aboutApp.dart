import 'package:flutter/material.dart';
import 'package:tc_college_app/screens/home/aboutApp/credits.dart';
import 'package:tc_college_app/screens/shared/constants.dart';
import 'package:tc_college_app/services/dbconnect.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});
  
  static DbConnector dbConnector = DbConnector();
  
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: themeColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'App Info',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
            vertical: screenSize.height * 0.01,
            horizontal: screenSize.width * 0.02),
        children: [
          ListTile(
            onTap: () async{
            try{
              await dbConnector.launchPrivacyPolicy();
            } catch(exception){
              showDialog(
                context: context, 
                builder: (BuildContext context){
                  return AlertDialog(
                    content: Text('Loading privacy policy failed.', style: TextStyle(fontSize: 16.0),),
                    actions: [TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Ok'))],
                  );
                });
            }
            },
            title: Text(
              'Privacy Policy',
              style: TextStyle(color: Colors.grey[800], fontSize: 18.0),
            ),
            shape: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Credits()));
            },
            title: Text(
              'Credits',
              style: TextStyle(color: Colors.grey[800], fontSize: 18.0),
            ),
            shape: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          ListTile(
            onTap: () {
              showLicensePage(context: context, applicationVersion: 'Version 1.0.0');
            },
            title: Text(
              'Licenses',
              style: TextStyle(color: Colors.grey[800], fontSize: 18.0),
            ),
            shape: Border(bottom: BorderSide(color: Colors.grey)),
          )
        ],
      ),
    );
  }
}
