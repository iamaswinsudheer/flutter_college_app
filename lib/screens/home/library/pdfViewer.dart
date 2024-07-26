import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:tc_college_app/screens/shared/constants.dart';

class PDFViewer extends StatefulWidget {
  final String selectedDoc;
  final List<dynamic> books;
  const PDFViewer({super.key, required this.selectedDoc, required this.books});

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  late String? filePath;
  PdfViewerController _pdfViewerController = PdfViewerController();

  @override
  void initState() {
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  String? getFilePath() {
    Map<String, dynamic>? document = widget.books.firstWhere(
        (course) => course['title'].toString() == widget.selectedDoc);
    return document!['pdf'];
  }

  @override
  Widget build(BuildContext context) {
    print(widget.selectedDoc);
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: SafeArea(
            child: Text(
          widget.selectedDoc,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        )),
      ),
      body: PdfViewer.uri(
        Uri.parse(filePath!),
        controller: _pdfViewerController,
        params: PdfViewerParams(
            viewerOverlayBuilder: (context, size) {
              return <Widget>[
                PdfViewerScrollThumb(
                  controller: _pdfViewerController,
                  orientation: ScrollbarOrientation.right,
                  margin: 5.0,
                  thumbBuilder: (context, thumbSize, pageNumber, controller) {
                    return Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_drop_up,
                              size: 20.0,
                              color: Colors.black,
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 20.0,
                              color: Colors.black,
                            )
                          ],
                        ));
                  },
                ),
              ];
            },
            pageOverlaysBuilder: (context, pageRect, page) {
              return <Widget>[
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.01),
                        color: Colors.grey,
                        child: Text(page.pageNumber.toString())),
                  ),
                )
              ];
            },
            backgroundColor: Colors.grey[200]!,
            loadingBannerBuilder: (context, bytesDownloaded, totalBytes) {
              return Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(themeColor),
              ));
            }),
      ),
    );
  }
}
