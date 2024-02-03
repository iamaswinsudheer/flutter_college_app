import 'package:flutter/material.dart';
import 'package:tc_college_app/screens/home/library/units.dart';
import 'package:tc_college_app/screens/shared/constants.dart';
import 'package:tc_college_app/screens/shared/loading.dart';
import 'package:tc_college_app/services/dbconnect.dart';

class SelectSubjects extends StatefulWidget {
  final String? courseChoosed;
  final String? yearChoosed;
  final String? userCourse;
  final List<Map<String, dynamic>> courseDetails;
  const SelectSubjects(
      {super.key,
      required this.courseChoosed,
      required this.yearChoosed,
      required this.userCourse,
      required this.courseDetails});

  @override
  State<SelectSubjects> createState() => _SelectSubjectsState();
}

class _SelectSubjectsState extends State<SelectSubjects> {
  late List<String> uniqueSubjects;
  DbConnector dbConnector = DbConnector();
  bool loadingScreen = false;

  List<Color> bgColorForTiles = [
    Color.fromARGB(255, 150, 176, 196),
    Color.fromARGB(255, 150, 200, 152),
    const Color.fromARGB(255, 173, 126, 181),
    Color.fromARGB(255, 199, 167, 118),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    uniqueSubjects = getUniqueSubjects();
  }

  List<String> getUniqueSubjects() {
    switch (widget.userCourse) {
      case 'degree':
        {
          Set<String> subjectsSet = widget.courseDetails
              .where((course) =>
                  course['course'].toString() == widget.courseChoosed &&
                  course['year'].toString() == widget.yearChoosed)
              .map((course) => course['subject'].toString())
              .toSet();
          return subjectsSet.toList();
        }
      case 'diploma':
        {
          Set<String> subjectsSet = widget.courseDetails
              .where((course) =>
                  course['course'].toString() == widget.courseChoosed)
              .map((course) => course['subject'].toString())
              .toSet();
          return subjectsSet.toList();
        }
      default:
        return [];
    }
  }

  void _onTapHandler(int index) async {
    setState(() {
      loadingScreen = true;
    });
    List<Map<String, dynamic>> _courseDetails;
    final String subjectChoosed = uniqueSubjects[index];
    switch (widget.userCourse) {
      case 'degree':
        {
          _courseDetails = await dbConnector.getDegreeBooks();
          setState(() {
            loadingScreen = false;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SelectUnits(
                        courseChoosed: widget.courseChoosed,
                        yearChoosed: widget.yearChoosed,
                        subjectChoosed: subjectChoosed,
                        userCourse: widget.userCourse,
                        courseDetails: _courseDetails,
                      )));
        }
        break;
      case 'diploma':
        {
          _courseDetails = await dbConnector.getDiplomaBooks();
          setState(() {
            loadingScreen = false;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SelectUnits(
                        courseChoosed: widget.courseChoosed,
                        yearChoosed: null,
                        subjectChoosed: subjectChoosed,
                        userCourse: widget.userCourse,
                        courseDetails: _courseDetails,
                      )));
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
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: themeColor,
              title: Text(
                'Subjects',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            body: Container(
              padding: EdgeInsets.all(screenSize.width * 0.04),
              child: ListView.builder(
                  itemCount: uniqueSubjects.length,
                  itemBuilder: (context, index) {
                    return Container(
                        decoration: BoxDecoration(
                            boxShadow: [BoxShadow(blurRadius: 0.0001)],
                            color: bgColorForTiles[index % 4],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        margin:
                            EdgeInsets.only(bottom: screenSize.height * 0.01),
                        height: screenSize.height * 0.19,
                        width: double.infinity,
                        child: ListTile(
                          title: Text(
                            uniqueSubjects[index],
                            style: TextStyle(
                              fontSize: (24.0),
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          onTap: () {
                            _onTapHandler(index);
                          },
                        ));
                  }),
            ),
          );
  }
}
