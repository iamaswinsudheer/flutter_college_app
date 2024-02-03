import 'package:flutter/material.dart';
import 'package:tc_college_app/screens/home/library/subjects.dart';
import 'package:tc_college_app/screens/shared/loading.dart';
import 'package:tc_college_app/services/dbconnect.dart';

class AcademicYearSelector {
  bool loadingScreen = false;
  DbConnector dbConnector = DbConnector();
  void show(BuildContext context, String courseChoosed, String userCourse,
      List<Map<String, dynamic>> courseDetails) {
    List<String> uniqueYears = getUniqueYears(courseDetails, courseChoosed);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: _buildListItems(
                  context, uniqueYears, courseChoosed, userCourse),
            ),
          ),
        );
      },
    );
  }

  static List<String> getUniqueYears(
      List<Map<String, dynamic>> courseDetails, String selectedCourse) {
    Set<String> yearsSet = courseDetails
        .where((course) => course['course'].toString() == selectedCourse)
        .map((course) => course['year'].toString())
        .toSet();
    return yearsSet.toList()..sort();
  }

  List<Widget> _buildListItems(BuildContext context, List<String> itemList,
      String courseChoosed, String userCourse) {
    return itemList.map((itemName) {
      return _buildListItem(context, itemName, courseChoosed, userCourse);
    }).toList();
  }

  void _onTapHandler(BuildContext context, String yearChoosed,
      String courseChoosed, String userCourse) async {
    List<Map<String, dynamic>> _courseDetails;
    _courseDetails = await dbConnector.getDegreeBooks();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SelectSubjects(
                courseChoosed: courseChoosed,
                yearChoosed: yearChoosed,
                userCourse: userCourse,
                courseDetails: _courseDetails)));
  }

  Widget _buildListItem(BuildContext context, String itemName,
      String courseChoosed, String userCourse) {
    return loadingScreen
        ? Loading()
        : ListTile(
            title: Text('Year $itemName'),
            onTap: () {
              print(itemName);
              _onTapHandler(context, itemName, courseChoosed, userCourse);
            },
          );
  }
}
