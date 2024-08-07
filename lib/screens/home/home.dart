import 'package:flutter/material.dart';
import 'package:tc_college_app/screens/home/library/libraryHome.dart';
import 'package:tc_college_app/screens/home/studentProfile.dart';
import 'package:tc_college_app/screens/shared/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final List<Map<String, dynamic>> listItems = [
      {'item': 'Library', 'icon': Icons.book},
    ];

    final List<Map<String, dynamic>> extraItems = [
      {
        'description': 'Instant access to e-books and academic resources.',
        'bgColor': Color.fromARGB(255, 113, 167, 167)
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenSize.height * 0.09),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.05,
                  vertical: screenSize.height * 0.015,
                ),
                color: themeColor,
                child: SafeArea(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage('assets/logo/TC_college_logo1.png'),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StudentProfile()));
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                'assets/images/user.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenSize.height * 0.05,
            horizontal: screenSize.width * 0.02),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(
                vertical: screenSize.height * 0.025,
                horizontal: screenSize.width * 0.05,
              ),
              child: Image.asset('assets/logo/TC_college_logo.png'),
            ),
            SizedBox(
              height: screenSize.height * 0.05,
            ),
            InkWell(
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StudentProfile()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 218, 209, 130),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    border: Border.all(color: Colors.white)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'View your profile',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        )),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(
                            'assets/images/user.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            for (int index = 0; index < listItems.length; index++)
              Container(
                //adjust the margin here when more tiles are added.
                child: CustomMenuContainer(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LibraryHome()));
                  },
                  title: listItems[index]['item'],
                  description: extraItems[index]['description'],
                  bgColor: extraItems[index]['bgColor'],
                ),
              ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            InkWell(
              onTap: () {
                showLogoutDialog(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 232, 183, 162),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.logout),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Logout from app',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
