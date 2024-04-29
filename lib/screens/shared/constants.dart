import 'package:flutter/material.dart';
import 'package:tc_college_app/screens/authentication/login.dart';
import 'package:tc_college_app/services/manageToken.dart';

//color theme of the app
final Color themeColor = Color(0xff6a1515);

//custom list tile for the app home screen
class CustomMenuContainer extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;
  final Color bgColor;

  CustomMenuContainer(
      {required this.title,
      required this.description,
      required this.onTap,
      required this.bgColor});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: bgColor,
        ),
        width: screenSize.width,
        height: screenSize.height * 0.21,
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.symmetric(
            vertical: screenSize.height * 0.035,
            horizontal: screenSize.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
            Text(
              description,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

//custom grid tile for Study materials screen
class CustomDocTile extends StatelessWidget {
  final String title;
  final Function() onTap;

  const CustomDocTile(
      {required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 1.0)],
              border: Border.all(
                color: Colors.white,
              )),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Image.asset(
                  'assets/images/book.png',
                  //<a href="https://www.flaticon.com/free-icons/open-book" 
                  //title="open book icons">Open book icons created by Karyative - Flaticon</a>
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenSize.height * 0.015,
                      horizontal: screenSize.width * 0.05),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ))
            ],
          ),
        ));
  }
}

void showLogoutDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Logout?'),
            content: Text('Are you sure you want to logout?'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    TokenManager.destroyToken();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        (route) => false);
                  },
                  child: Text('Yes'))
            ],
          ));
}
