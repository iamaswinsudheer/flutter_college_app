import 'package:flutter/material.dart';
import 'package:tc_college_app/screens/home/library/units.dart';
import 'package:tc_college_app/screens/shared/constants.dart';
import 'package:tc_college_app/services/dbconnect.dart';

class SelectSubjects extends StatefulWidget {
  final dynamic notDegreebooks;
  final String? yearOfStudy;
  final String? userCourse;
  const SelectSubjects(
      {super.key, this.notDegreebooks, this.yearOfStudy, this.userCourse});

  @override
  State<SelectSubjects> createState() => _SelectSubjectsState();
}

class _SelectSubjectsState extends State<SelectSubjects> {
  DbConnector dbConnector = DbConnector();
  List<String> notDegreeSubjects = [];
  List<String> uniqueSubjects = [];

  List<Color> bgColorForTiles = [
    Color.fromARGB(255, 84, 124, 225),
    Color.fromARGB(255, 5, 184, 169),
    Color.fromARGB(255, 130, 132, 130),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.notDegreebooks != null) {
      for (int j = 0; j < widget.notDegreebooks.length; j++) {
        notDegreeSubjects.add(widget.notDegreebooks[j]['subject']);
      }
      uniqueSubjects = notDegreeSubjects.toSet().toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
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
      body: widget.notDegreebooks == null
          ? Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.02,
                  vertical: screenSize.height * 0.01),
              child: FutureBuilder(
                  future: dbConnector.getDegreeBooks(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(themeColor)),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Something went wrong :(',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.grey),
                              ),
                              Text(
                                'Please come back later',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.grey),
                              ),
                            ]),
                      );
                    } else {
                      final degreeBooks = snapshot.data!;
                      final selectedDegreeBooks = degreeBooks
                          .where((book) =>
                              book['year'].toString() == widget.yearOfStudy &&
                              book['course'] == widget.userCourse)
                          .toList();
                      List<String> degreeSubjects = [];
                      for (int i = 0; i < selectedDegreeBooks.length; i++) {
                        degreeSubjects.add(selectedDegreeBooks[i]['subject']);
                      }
                      List<String> uniqueDegreeSubjects =
                          degreeSubjects.toSet().toList();
                      if (uniqueDegreeSubjects.length == 0) {
                        return Center(
                          child: Text(
                            'Nothing here :(',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.grey),
                          ),
                        );
                      } else {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: uniqueDegreeSubjects.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    bottom: screenSize.height * 0.01),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  color: bgColorForTiles[(index + 1) % 3],
                                ),
                                width: screenSize.width,
                                height: screenSize.height * 0.17,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SelectUnits(
                                                books: degreeBooks,
                                                selectedSubject:
                                                    uniqueDegreeSubjects[
                                                        index])));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * 0.05,
                                        vertical: screenSize.height * 0.02),
                                    child: Text(
                                      uniqueDegreeSubjects[index],
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
                            });
                      }
                    }
                  }),
            )
          : uniqueSubjects.length == 0
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
                      shrinkWrap: true,
                      itemCount: uniqueSubjects.length,
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectUnits(
                                          books: widget.notDegreebooks,
                                          selectedSubject:
                                              uniqueSubjects[index])));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.05,
                                  vertical: screenSize.height * 0.02),
                              child: Text(
                                uniqueSubjects[index],
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
                      })),
    );
  }
}
