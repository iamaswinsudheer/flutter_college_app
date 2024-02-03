import 'package:flutter/material.dart';
import 'package:tc_college_app/screens/shared/constants.dart';

class StudentProfile extends StatefulWidget {
  final List<Map<String, dynamic>> userDetails;
  const StudentProfile({super.key, required this.userDetails});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  @override
  void initState() {
    super.initState();
    print(widget.userDetails);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenSize.height * 0.35),
        child: Container(
          decoration: BoxDecoration(
              color: themeColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              )),
          width: screenSize.width,
          padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.05, horizontal: screenSize.width * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SafeArea(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 70.0,
                  backgroundImage: AssetImage(
                      'assets/images/user.png'),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              Text(
                '${widget.userDetails[0]['first_name']} ${widget.userDetails[0]['last_name']}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.symmetric(
              vertical: screenSize.height * 0.04,
              horizontal: screenSize.width * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Email',
                style: TextStyle(color: Colors.grey[700], fontSize: 20.0),
              ),
              SizedBox(
                height: screenSize.height * 0.015,
              ),
              Text(
                widget.userDetails[0]['email'],
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
              SizedBox(
                height: screenSize.height * 0.025,
              ),
              Text(
                'Phone',
                style: TextStyle(color: Colors.grey[700], fontSize: 20.0),
              ),
              SizedBox(
                height: screenSize.height * 0.015,
              ),
              Text(
                widget.userDetails[0]['phone'],
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
              SizedBox(
                height: screenSize.height * 0.025,
              ),
              Text(
                'Location',
                style: TextStyle(color: Colors.grey[700], fontSize: 20.0),
              ),
              SizedBox(
                height: screenSize.height * 0.015,
              ),
              Text(
                widget.userDetails[0]['place'],
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
              SizedBox(
                height: screenSize.height * 0.025,
              ),
              Text(
                'Date of joining',
                style: TextStyle(color: Colors.grey[700], fontSize: 20.0),
              ),
              SizedBox(
                height: screenSize.height * 0.015,
              ),
              Text(
                widget.userDetails[0]['date_joined'],
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              ElevatedButton(
                onPressed: () {
                  showLogoutDialog(context);
                },
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: BeveledRectangleBorder(),
                  primary: themeColor,
                  minimumSize: const Size.fromHeight(50),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
