import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DocumentViewer extends StatefulWidget {
  final String? docChoosed;
  final List<Map<String, dynamic>> courseDetails;
  const DocumentViewer({super.key, required this.docChoosed, required this.courseDetails}); 

  @override
  State<DocumentViewer> createState() => _DocumentViewerState();
}

class _DocumentViewerState extends State<DocumentViewer> {
  late String? filePath;

  @override
  void initState(){
    super.initState();
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

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    filePath = getFilePath();
  }

  String? getFilePath() {
    Map<String, dynamic>? document = widget.courseDetails
        .firstWhere((course) => course['title'].toString() == widget.docChoosed);

    return document['pdf']; // Assuming 'pdf' is the key for the file path in your courseDetails.
  }

  @override
  Widget build(BuildContext context) {
    print(widget.docChoosed);
    return SfPdfViewer.network(
      filePath!,
      enableTextSelection: false,
      enableDoubleTapZooming: true,
      
    );
  }
}