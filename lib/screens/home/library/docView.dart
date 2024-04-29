import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tc_college_app/screens/shared/constants.dart';

class DocumentViewer extends StatefulWidget {
  final String? selectedDoc;
  final List<dynamic> books;
  const DocumentViewer({super.key, required this.selectedDoc, required this.books}); 

  @override
  State<DocumentViewer> createState() => _DocumentViewerState();
}

class _DocumentViewerState extends State<DocumentViewer> {
  late String? filePath;

  @override
  void initState(){
    super.initState();
    filePath = getFilePath();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    super.dispose();
  }

  String? getFilePath() {
    Map<String, dynamic>? document = widget.books
        .firstWhere((course) => course['title'].toString() == widget.selectedDoc);

    return document!['pdf']; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor,
      body: SafeArea(
        child: SfPdfViewer.network(
          filePath!,
          enableTextSelection: false,
          enableDoubleTapZooming: true,
          
        ),
      ),
    );
  }
}