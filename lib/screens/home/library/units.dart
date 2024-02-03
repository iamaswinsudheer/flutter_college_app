import 'package:flutter/material.dart';
import 'package:tc_college_app/screens/home/library/studyMaterials.dart';
import 'package:tc_college_app/screens/shared/constants.dart';
import 'package:tc_college_app/screens/shared/loading.dart';
import 'package:tc_college_app/services/dbconnect.dart';

class SelectUnits extends StatefulWidget {
  final String? courseChoosed;
  final String? yearChoosed;
  final String? subjectChoosed;
  final String? userCourse;
  final List<Map<String, dynamic>> courseDetails;
  const SelectUnits(
      {super.key,
      required this.courseChoosed,
      required this.yearChoosed,
      required this.subjectChoosed,
      required this.userCourse,
      required this.courseDetails});

  @override
  State<SelectUnits> createState() => _SelectUnitsState();
}

class _SelectUnitsState extends State<SelectUnits> {
  late List<String> uniqueUnits;
  DbConnector dbConnector = DbConnector();
  bool loadingScreen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    uniqueUnits = getUniqueUnits();
  }

  List<String> getUniqueUnits() {
    switch (widget.userCourse) {
      case 'degree':
        {
          Set<String> unitsSet = widget.courseDetails
              .where((course) =>
                  course['course'].toString() == widget.courseChoosed &&
                  course['year'].toString() == widget.yearChoosed &&
                  course['subject'].toString() == widget.subjectChoosed)
              .map((course) => course['unit'].toString())
              .toSet();
          return unitsSet.toList()..sort();
        }
      case 'diploma':
        {
          Set<String> unitsSet = widget.courseDetails
              .where((course) =>
                  course['course'].toString() == widget.courseChoosed &&
                  course['subject'].toString() == widget.subjectChoosed)
              .map((course) => course['unit'].toString())
              .toSet();
          return unitsSet.toList();
        }
      case 'certificate':
        {
          Set<String> unitsSet = widget.courseDetails
              .where((course) =>
                  course['subject'].toString() == widget.subjectChoosed)
              .map((course) => course['unit'].toString())
              .toSet();
          return unitsSet.toList();
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
    String unitChoosed = uniqueUnits[index];
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
                  builder: (context) => StudyMaterials(
                      courseChoosed: widget.courseChoosed,
                      yearChoosed: widget.yearChoosed,
                      subjectChoosed: widget.subjectChoosed,
                      unitChoosed: unitChoosed,
                      userCourse: widget.userCourse,
                      courseDetails: _courseDetails)));
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
                  builder: (context) => StudyMaterials(
                      courseChoosed: widget.courseChoosed,
                      yearChoosed: null,
                      subjectChoosed: widget.subjectChoosed,
                      unitChoosed: unitChoosed,
                      userCourse: widget.userCourse,
                      courseDetails: _courseDetails)));
        }
        break;
      case 'certificate':
        {
          _courseDetails = await dbConnector.getCertificateBooks();
          setState(() {
            loadingScreen = false;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StudyMaterials(
                      courseChoosed: null,
                      yearChoosed: null,
                      subjectChoosed: widget.subjectChoosed,
                      unitChoosed: unitChoosed,
                      userCourse: widget.userCourse,
                      courseDetails: _courseDetails)));
        }
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
                'Units',
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
                itemCount: uniqueUnits.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.005),
                    child: ListTile(
                      title: Text(
                        'Unit ${uniqueUnits[index]}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        _onTapHandler(index);
                      },
                    ),
                  );
                },
              ),
            ),
          );
  }
}
