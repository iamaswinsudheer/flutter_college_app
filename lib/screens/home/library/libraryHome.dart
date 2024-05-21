import 'package:flutter/material.dart';
import 'package:tc_college_app/screens/home/library/courses.dart';
import 'package:tc_college_app/screens/home/library/subjects.dart';
import 'package:tc_college_app/screens/shared/constants.dart';
import 'package:tc_college_app/services/fetchUserDetails.dart';

class LibraryHome extends StatefulWidget {
  const LibraryHome({
    super.key,
  });

  @override
  State<LibraryHome> createState() => _LibraryHomeState();
}

class _LibraryHomeState extends State<LibraryHome> {
  late Future<List<dynamic>> futureUserDetails;
  UserDetailsFetcher userDetailsFetcher = UserDetailsFetcher();
  ScrollController _scrollController = ScrollController();

  String mapToKeys(String program) {
    if (program == "Degree books") {
      return "degree_books";
    } else if (program == "Certificate books") {
      return "certificate_books";
    } else if (program == "Diploma books") {
      return "diploma_books";
    } else {
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    futureUserDetails = userDetailsFetcher.fetchUserDetails();
  }

  List<Color> bgColorForTiles = [
    Color.fromARGB(255, 84, 124, 225),
    Color.fromARGB(255, 5, 184, 169),
    Color.fromARGB(255, 130, 132, 130),
    // Color.fromARGB(255, 192, 108, 6)
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return FutureBuilder(
        future: futureUserDetails,
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
                        'Please come back later.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.0, color: Colors.grey),
                      ),
                    ]),
              ),
            );
          } else {
            final userDetails = snapshot.data![0];
            String? yearOfStudy = userDetails['year_of_study'];
            String? userCourse = userDetails['course'];
            List<String> programs = ['Certificate books', 'Diploma books'];
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(screenSize.height * 0.3),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.05,
                      vertical: screenSize.height * 0.05),
                  decoration: BoxDecoration(
                      color: themeColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0))),
                  height: screenSize.height * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Welcome!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.001,
                      ),
                      Text(
                        "Library",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 60.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.02,
                    vertical: screenSize.height * 0.01),
                child: ListView(controller: _scrollController, children: [
                  Container(
                    margin: EdgeInsets.only(bottom: screenSize.height * 0.01),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: bgColorForTiles[0 % 3],
                    ),
                    width: screenSize.width,
                    height: screenSize.height * 0.17,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectSubjects(
                                      yearOfStudy: yearOfStudy,
                                      userCourse: userCourse,
                                    )));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.05,
                            vertical: screenSize.height * 0.02),
                        child: Text(
                          'Degree books',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900]),
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: programs.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                              EdgeInsets.only(bottom: screenSize.height * 0.01),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: bgColorForTiles[(index + 1) % 3],
                          ),
                          width: screenSize.width,
                          height: screenSize.height * 0.17,
                          child: InkWell(
                            onTap: () {
                              if (index == 0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SelectSubjects(
                                              notDegreebooks: userDetails[
                                                  mapToKeys(programs[index])],
                                            )));
                              } else if (index == 1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChooseCourse(
                                              selectedBook: userDetails[
                                                  mapToKeys(programs[1])],
                                            )));
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.05,
                                  vertical: screenSize.height * 0.02),
                              child: Text(
                                programs[index],
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[900]),
                              ),
                            ),
                          ),
                        );
                      }),
                ]),
              ),
            );
          }
        });
  }
}
