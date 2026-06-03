// import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'PDF Viewer',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: PDFViewerPage(),
//     );
//   }
// }

// class PDFViewerPage extends StatefulWidget {
//   @override
//   _PDFViewerPageState createState() => _PDFViewerPageState();
// }

// class _PDFViewerPageState extends State<PDFViewerPage> {
//   bool _isLoading = true;

//   late PDFDocument document;

//   @override
//   void initState() {
//     super.initState();
//     loadDocument();
//   }

//   Future<void> loadDocument() async {
//     final doc = await PDFDocument.fromAsset(
//         "assets/img/myplate.pdf"); // Path to your PDF file
//     setState(() {
//       document = doc;
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Viewer'),
//       ),
//       body: Center(
//         child: _isLoading
//             ? CircularProgressIndicator()
//             : PDFViewer(
//                 document: document,
//                 zoomSteps: 1,
//               ),
//       ),
//     );
//   }
// }
