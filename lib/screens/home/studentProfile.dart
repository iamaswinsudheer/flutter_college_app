import 'package:flutter/material.dart';
import 'package:tc_college_app/screens/shared/constants.dart';
import 'package:tc_college_app/services/fetchUserDetails.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({
    super.key,
  });

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  late Future<List<dynamic>> _futureUser;
  UserDetailsFetcher userDetailsFetcher = UserDetailsFetcher();

  @override
  void initState() {
    super.initState();
    _futureUser = userDetailsFetcher.fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return FutureBuilder(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(themeColor)),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Text(
                    'Something went wrong :(',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                  Text(
                    'Please come back later',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                ]),
              ),
            );
          } else {
            print(snapshot.data);
            final userDetails = snapshot.data![0];
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
                  padding: EdgeInsets.symmetric(
                      vertical: screenSize.height * 0.05,
                      horizontal: screenSize.width * 0.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SafeArea(
                        child: CircleAvatar(
                          backgroundColor: themeColor,
                          radius: 70.0,
                          backgroundImage: AssetImage('assets/images/user.png'),
                          //<a href="https://www.flaticon.com/free-icons/student" 
                          //title="student icons">Student icons created by Aficons studio - Flaticon</a>
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.03,
                      ),
                      Text(
                        '${userDetails['first_name']} ${userDetails['last_name']}',
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
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.05,
                    vertical: screenSize.height * 0.04),
                child: ListView(children: [
                  Text(
                    'Email',
                    style: TextStyle(color: Colors.grey[700], fontSize: 20.0),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  Text(
                    userDetails['email'],
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                  Divider(
                    height: screenSize.height * 0.03,
                  ),
                  Text(
                    'Phone',
                    style: TextStyle(color: Colors.grey[700], fontSize: 20.0),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  Text(
                    userDetails['phone'],
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                  Divider(
                    height: screenSize.height * 0.03,
                  ),
                  Text(
                    'Course',
                    style: TextStyle(color: Colors.grey[700], fontSize: 20.0),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  Text(
                    userDetails['course'],
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                  Divider(
                    height: screenSize.height * 0.03,
                  ),
                  Text(
                    'Year of study',
                    style: TextStyle(color: Colors.grey[700], fontSize: 20.0),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  Text(
                    userDetails['year_of_study'],
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                  Divider(
                    height: screenSize.height * 0.03,
                  ),
                  Text(
                    'Location',
                    style: TextStyle(color: Colors.grey[700], fontSize: 20.0),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  Text(
                    userDetails['place'],
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                  Divider(
                    height: screenSize.height * 0.03,
                  ),
                  Text(
                    'Date of joining',
                    style: TextStyle(color: Colors.grey[700], fontSize: 20.0),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  Text(
                    userDetails['date_joined'],
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
                      backgroundColor: themeColor,
                      minimumSize: const Size.fromHeight(50),
                    ),
                  ),
                ]),
              ),
            );
          }
        });
  }
}
