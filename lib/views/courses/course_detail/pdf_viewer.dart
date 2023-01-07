import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewer extends StatefulWidget {
  const PDFViewer({Key? key, required this.url, required this.title}) : super(key: key);
  final String url;
  final String title;

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leadingWidth: 20,
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey[800]),
          title: Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              widget.title,
              style: TextStyle(color: Colors.grey[800]),
            ),
          ),
        ),
        body: Center(
          child: Container(
            child: SfPdfViewer.network(
              widget.url,
              canShowScrollHead: false,
              canShowScrollStatus: false,
            ),
          ),
        ),
      ),
    );
  }
}