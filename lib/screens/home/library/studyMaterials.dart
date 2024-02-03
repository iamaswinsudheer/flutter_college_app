import 'package:flutter/material.dart';
import 'package:tc_college_app/screens/home/library/docView.dart';
import 'package:tc_college_app/screens/shared/constants.dart';
import 'package:tc_college_app/services/dbconnect.dart';

class StudyMaterials extends StatefulWidget {
  final String? courseChoosed;
  final String? yearChoosed;
  final String? subjectChoosed;
  final String? unitChoosed;
  final String? userCourse;
  final List<Map<String, dynamic>> courseDetails;
  const StudyMaterials({
    super.key,
    required this.courseChoosed,
    required this.yearChoosed,
    required this.subjectChoosed,
    required this.unitChoosed,
    required this.userCourse,
    required this.courseDetails,
  });

  @override
  State<StudyMaterials> createState() => _StudyMaterialsState();
}

class _StudyMaterialsState extends State<StudyMaterials> {
  DbConnector dbConnector = DbConnector();
  late List<String> docTitles;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    docTitles = getDocTitles();
  }

  List<String> getDocTitles() {
    switch (widget.userCourse) {
      case 'degree':
        {
          Set<String> titleSet = widget.courseDetails
              .where((course) =>
                  course['course'].toString() == widget.courseChoosed &&
                  course['year'].toString() == widget.yearChoosed &&
                  course['subject'].toString() == widget.subjectChoosed &&
                  course['unit'].toString() == widget.unitChoosed)
              .map((course) => course['title'].toString())
              .toSet();
          return titleSet.toList();
        }
      case 'diploma':{
        Set<String> titleSet = widget.courseDetails
              .where((course) =>
                  course['course'].toString() == widget.courseChoosed &&
                  course['subject'].toString() == widget.subjectChoosed &&
                  course['unit'].toString() == widget.unitChoosed)
              .map((course) => course['title'].toString())
              .toSet();
          return titleSet.toList();
      }
      case 'certificate':{
        Set<String> titleSet = widget.courseDetails
              .where((course) =>
                  course['subject'].toString() == widget.subjectChoosed &&
                  course['unit'].toString() == widget.unitChoosed)
              .map((course) => course['title'].toString())
              .toSet();
          return titleSet.toList();
      }
      default:
        return [];
    }
  }

  void _onTapHandler(index) {
    final String docChoosed = docTitles[index];
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DocumentViewer(
                docChoosed: docChoosed, courseDetails: widget.courseDetails)));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: themeColor,
        title: Text(
          'Study Materials',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(screenSize.width * 0.05),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
            childAspectRatio: 0.9,
          ),
          itemCount: docTitles.length,
          itemBuilder: (context, index) {
            return CustomDocTile(
                title: docTitles[index],
                onTap: () {
                  _onTapHandler(index);
                });
          },
        ),
      ),
    );
  }
}
