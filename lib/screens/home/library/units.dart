import 'package:flutter/material.dart';
import 'package:tc_college_app/screens/home/library/studyMaterials.dart';
import 'package:tc_college_app/screens/shared/constants.dart';

class SelectUnits extends StatefulWidget {
  final dynamic books;
  final String selectedSubject;
  const SelectUnits(
      {super.key, required this.books, required this.selectedSubject});

  @override
  State<SelectUnits> createState() => _SelectUnitsState();
}

class _SelectUnitsState extends State<SelectUnits> {
  late List<String> uniqueUnits;

  List<String> getUnits() {
    Set<String> unitsSet = widget.books
        .where((book) => book['subject'] == widget.selectedSubject)
        .map<String>((book) => book['unit'].toString())
        .toSet();
    return unitsSet.toList();
  }

  @override
  void initState() {
    super.initState();
    uniqueUnits = getUnits();
  }


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
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
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.02,
            vertical: screenSize.height * 0.01),
        child: ListView.builder(
            itemCount: uniqueUnits.length,
            itemBuilder: (context, index) {
              return ListTile(
                shape: Border(bottom: BorderSide(color: Colors.grey[400]!)),
                title: Text(
                  'Unit ${uniqueUnits[index]}',
                  style: TextStyle(
                    color: Colors.grey[800],
                    letterSpacing: 1.0,
                    fontSize: 18.0,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudyMaterials(
                              books: widget.books,
                              selectedSubject: widget.selectedSubject,
                              selectedIndex: uniqueUnits[index])));
                },
              );
            }),
      ),
    );
  }
}
