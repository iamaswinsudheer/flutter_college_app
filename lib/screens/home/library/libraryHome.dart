import 'package:flutter/material.dart';
import 'package:tc_college_app/screens/home/library/academicYear.dart';
import 'package:tc_college_app/screens/home/library/subjects.dart';
import 'package:tc_college_app/screens/home/library/units.dart';
import 'package:tc_college_app/screens/shared/constants.dart';
import 'package:tc_college_app/screens/shared/loading.dart';
import 'package:tc_college_app/services/dbconnect.dart';

class LibraryHome extends StatefulWidget {
  final String userCourse;
  final List<Map<String, dynamic>> courseDetails;
  const LibraryHome(
      {super.key, required this.userCourse, required this.courseDetails});

  @override
  State<LibraryHome> createState() => _LibraryHomeState();
}

class _LibraryHomeState extends State<LibraryHome> {
  List<String> uniqueCourses = [];
  DbConnector dbConnector = DbConnector();
  bool loadingScreen = false;

  @override
  void initState() {
    super.initState();
    print(widget.userCourse);
    print(widget.courseDetails);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.userCourse == 'degree' || widget.userCourse == 'diploma') {
      uniqueCourses = getUniqueCourseNames();
    } else if (widget.userCourse == 'certificate') {
      uniqueCourses = getUniqueSubjectNames();
    }
  }

  List<Color> bgColorForTiles = [
    Color.fromARGB(255, 150, 176, 196),
    Color.fromARGB(255, 150, 200, 152),
    const Color.fromARGB(255, 173, 126, 181),
    Color.fromARGB(255, 199, 167, 118),
  ];

  List<String> getUniqueCourseNames() {
    Set<String> courseNameSet = widget.courseDetails
        .map((course) => course['course'].toString())
        .toSet();
    return courseNameSet.toList();
  }

  List<String> getUniqueSubjectNames() {
    Set<String> courseNameSet = widget.courseDetails
        .map((course) => course['subject'].toString())
        .toSet();
    return courseNameSet.toList();
  }

  String _libraryContentSelector(int index) {
    return uniqueCourses[index];
  }

  void _onTapHandler(int index) async {
    setState(() {
      loadingScreen = true;
    });
    List<Map<String, dynamic>> _courseDetails;
    switch (widget.userCourse) {
      case 'degree':
        {
          _courseDetails = await dbConnector.getDegreeBooks();
          String _courseChoosed = uniqueCourses[index];
          print(_courseChoosed);
          setState(() {
            loadingScreen = false;
          });
          return AcademicYearSelector()
              .show(context, _courseChoosed, widget.userCourse, _courseDetails);
        }
      case 'diploma':
        {
          _courseDetails = await dbConnector.getDiplomaBooks();
          String _courseChoosed = uniqueCourses[index];
          print(_courseChoosed);
          setState(() {
            loadingScreen = false;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SelectSubjects(
                      courseChoosed: _courseChoosed,
                      yearChoosed: null,
                      userCourse: widget.userCourse,
                      courseDetails: _courseDetails)));
        }
        break;
      case 'certificate':
        {
          String _subjectChoosed = uniqueCourses[index];
          print(_subjectChoosed);
          _courseDetails = await dbConnector.getCertificateBooks();
          setState(() {
            loadingScreen = false;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SelectUnits(
                      courseChoosed: null,
                      yearChoosed: null,
                      subjectChoosed: _subjectChoosed,
                      userCourse: widget.userCourse,
                      courseDetails: _courseDetails)));
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return loadingScreen
        ? Loading()
        : Scaffold(
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
            body: Container(
              padding: EdgeInsets.all(screenSize.width * 0.02),
              child: ListView.builder(
                  itemCount: uniqueCourses.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: screenSize.height * 0.01),
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(blurRadius: 0.0001)],
                          color: bgColorForTiles[index % 4],
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      height: 150.0,
                      width: double.infinity,
                      child: ListTile(
                        title: Text(
                          _libraryContentSelector(index),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        onTap: () {
                          // AcademicYearSelector.show(context);
                          _onTapHandler(index);
                        },
                      ),
                    );
                  }),
            ),
          );
  }
}
