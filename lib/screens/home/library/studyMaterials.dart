import 'package:flutter/material.dart';
import 'package:tc_college_app/screens/home/library/docView.dart';
import 'package:tc_college_app/screens/shared/constants.dart';

class StudyMaterials extends StatefulWidget {
  final dynamic books;
  final String selectedSubject;
  final String selectedIndex;
  const StudyMaterials(
      {super.key,
      required this.books,
      required this.selectedSubject,
      required this.selectedIndex});

  @override
  State<StudyMaterials> createState() => _StudyMaterialsState();
}

class _StudyMaterialsState extends State<StudyMaterials> {
  late List<String> documents;

  List<String> getDocuments() {
    Set<String> docSet = widget.books
        .where((doc) =>
            doc['subject'] == widget.selectedSubject &&
            doc['unit'].toString() == widget.selectedIndex)
        .map<String>((doc) => doc['title'].toString())
        .toSet();
    return docSet.toList();
  }

  @override
  void initState() {
    super.initState();
    documents = getDocuments();
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
            // childAspectRatio: 0.9,
            childAspectRatio: 0.95
          ),
          itemCount: documents.length,
          itemBuilder: (context, index) {
            return CustomDocTile(
                title: documents[index],
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DocumentViewer(
                              selectedDoc: documents[index],
                              books: widget.books)));
                });
          },
        ),
      ),
    );
  }
}
