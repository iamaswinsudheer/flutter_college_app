import 'package:flutter/material.dart';
import 'package:tc_college_app/screens/home/library/subjects.dart';
import 'package:tc_college_app/screens/shared/constants.dart';

class ChooseCourse extends StatefulWidget {
  final dynamic selectedBook;
  const ChooseCourse({super.key, required this.selectedBook});

  @override
  State<ChooseCourse> createState() => _ChooseCourseState();
}

class _ChooseCourseState extends State<ChooseCourse> {
  List uniqueCourses = [];

  List<Color> bgColorForTiles = [
    Color.fromARGB(255, 84, 124, 225),
    Color.fromARGB(255, 5, 184, 169),
    Color.fromARGB(255, 130, 132, 130),
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.selectedBook.length; i++) {
      uniqueCourses.add(widget.selectedBook[i]['course']);
    }
    uniqueCourses = uniqueCourses.toSet().toList();
  }

  dynamic filterDiplomaBooks(String selectedCourse) {
    return widget.selectedBook
        .where((book) => book['course'] == selectedCourse)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: themeColor,
        title: Text(
          'Courses',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
      body: uniqueCourses.length == 0
          ? Center(
              child: Text(
                'Nothing here :(',
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.02,
                  vertical: screenSize.height * 0.01),
              child: ListView.builder(
                  itemCount: uniqueCourses.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: screenSize.height * 0.01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: bgColorForTiles[(index + 1) % 3],
                      ),
                      width: screenSize.width,
                      height: screenSize.height * 0.17,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectSubjects(
                                        notDegreebooks: filterDiplomaBooks(
                                            uniqueCourses[index]),
                                      )));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.05,
                              vertical: screenSize.height * 0.02),
                          child: Text(
                            uniqueCourses[index],
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
            ),
    );
  }
}
