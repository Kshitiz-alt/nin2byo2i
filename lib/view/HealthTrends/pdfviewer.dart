// import 'dart:async';
// import 'dart:io';
import 'package:nin2byo2i/Common/appfontsize.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

// class PdfViwerPage extends StatefulWidget {
//   final String? path;
//   final String appBarText; // New parameter for app bar text

//   PdfViwerPage({Key? key, this.path, required this.appBarText})
//       : super(key: key);
//   @override
//   _PdfViwerPageState createState() => _PdfViwerPageState();
// }

// class _PdfViwerPageState extends State<PdfViwerPage> {
//   // String pathPDF = "";
//   // String landscapePathPdf = "";
//   String remotePDFpath = "assets/img/sample.pdf";
//   // String corruptedPathPDF = "";

//   @override
//   void initState() {
//     super.initState();
//     // fromAsset('assets/img/sample.pdf', 'corrupted.pdf').then((f) {
//     //   setState(() {
//     //     corruptedPathPDF = f.path;
//     //   });
//     // });
//     // fromAsset('assets/img/sample.pdf', 'demo.pdf').then((f) {
//     //   setState(() {
//     //     pathPDF = f.path;
//     //   });
//     // });
//     // fromAsset('assets/img/sample.pdf', 'landscape.pdf').then((f) {
//     //   setState(() {
//     //     landscapePathPdf = f.path;
//     //   });
//     // });

//     createFileOfPdfUrl().then((f) {
//       setState(() {
//         remotePDFpath = f.path;
//       });
//     });
//   }

//   Future<File> createFileOfPdfUrl() async {
//     Completer<File> completer = Completer();
//     debugPrint("Start download file from internet!");
//     try {
//       // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
//       // final url = "https://pdfkit.org/docs/guide.pdf";
//       final url = "http://www.pdf995.com/samples/pdf.pdf";
//       final filename = url.substring(url.lastIndexOf("/") + 1);
//       var request = await HttpClient().getUrl(Uri.parse(url));
//       var response = await request.close();
//       var bytes = await consolidateHttpClientResponseBytes(response);
//       var dir = await getApplicationDocumentsDirectory();
//       debugPrint("Download files");
//       debugPrint("${dir.path}/$filename");
//       File file = File("${dir.path}/$filename");

//       await file.writeAsBytes(bytes, flush: true);
//       completer.complete(file);
//     } catch (e) {
//       throw Exception('Error parsing asset file!');
//     }

//     return completer.future;
//   }

//   Future<File> fromAsset(String asset, String filename) async {
//     // To open from assets, you can copy them to the app storage folder, and the access them "locally"
//     Completer<File> completer = Completer();

//     try {
//       var dir = await getApplicationDocumentsDirectory();
//       File file = File("${dir.path}/$filename");
//       var data = await rootBundle.load(asset);
//       var bytes = data.buffer.asUint8List();
//       await file.writeAsBytes(bytes, flush: true);
//       completer.complete(file);
//     } catch (e) {
//       throw Exception('Error parsing asset file!');
//     }

//     return completer.future;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter PDF View',
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Plugin example app')),
//         body: Center(child: Builder(
//           builder: (BuildContext context) {
//             return Column(
//               children: <Widget>[
//                 // TextButton(
//                 //   child: Text("Open PDF"),
//                 //   onPressed: () {
//                 //     if (pathPDF.isNotEmpty) {
//                 //       Navigator.push(
//                 //         context,
//                 //         MaterialPageRoute(
//                 //           builder: (context) => PDFScreen(path: pathPDF),
//                 //         ),
//                 //       );
//                 //     }
//                 //   },
//                 // ),
//                 // TextButton(
//                 //   child: Text("Open Landscape PDF"),
//                 //   onPressed: () {
//                 //     if (landscapePathPdf.isNotEmpty) {
//                 //       Navigator.push(
//                 //         context,
//                 //         MaterialPageRoute(
//                 //           builder: (context) =>
//                 //               PDFScreen(path: landscapePathPdf),
//                 //         ),
//                 //       );
//                 //     }
//                 //   },
//                 // ),
//                 TextButton(
//                   child: Text("Remote PDF"),
//                   onPressed: () {
//                     if (remotePDFpath.isNotEmpty) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => PDFScreen(
//                             path: remotePDFpath,
//                             appBarText: 'Your AppBar Title Here',
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//                 // TextButton(
//                 //   child: Text("Open Corrupted PDF"),
//                 //   onPressed: () {
//                 //     if (pathPDF.isNotEmpty) {
//                 //       Navigator.push(
//                 //         context,
//                 //         MaterialPageRoute(
//                 //           builder: (context) =>
//                 //               PDFScreen(path: corruptedPathPDF),
//                 //         ),
//                 //       );
//                 //     }
//                 //   },
//                 // )
//               ],
//             );
//           },
//         )),
//       ),
//     );
//   }
// }

// class PDFScreen extends StatefulWidget {
//   final String? path;
//   final String appBarText; // New parameter for app bar text

//   PDFScreen({Key? key, this.path, required this.appBarText}) : super(key: key);

//   _PDFScreenState createState() => _PDFScreenState();
// }

// class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
//   final Completer<PDFViewController> _controller =
//       Completer<PDFViewController>();
//   int? pages = 0;
//   int? currentPage = 0;
//   bool isReady = false;
//   String errorMessage = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//             widget.appBarText), // Using the app bar text passed from parent
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.share),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Stack(
//         children: <Widget>[
//           PDFView(
//             filePath: widget.path,
//             enableSwipe: true,
//             swipeHorizontal: true,
//             autoSpacing: false,
//             pageFling: true,
//             pageSnap: true,
//             defaultPage: currentPage!,
//             fitPolicy: FitPolicy.BOTH,
//             preventLinkNavigation:
//                 false, // if set to true the link is handled in flutter
//             onRender: (_pages) {
//               setState(() {
//                 pages = _pages;
//                 isReady = true;
//               });
//             },
//             onError: (error) {
//               setState(() {
//                 errorMessage = error.toString();
//               });
//               debugPrint(error.toString());
//             },
//             onPageError: (page, error) {
//               setState(() {
//                 errorMessage = '$page: ${error.toString()}';
//               });
//               debugPrint('$page: ${error.toString()}');
//             },
//             onViewCreated: (PDFViewController pdfViewController) {
//               _controller.complete(pdfViewController);
//             },
//             onLinkHandler: (String? uri) {
//               debugPrint('goto uri: $uri');
//             },
//             onPageChanged: (int? page, int? total) {
//               debugPrint('page change: $page/$total');
//               setState(() {
//                 currentPage = page;
//               });
//             },
//           ),
//           errorMessage.isEmpty
//               ? !isReady
//                   ? Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : Container()
//               : Center(
//                   child: Text(errorMessage),
//                 )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';

class PDFScreen2 extends StatefulWidget {
  final String pdfAssetPath;
  final String lablename;
  PDFScreen2({Key? key, required this.pdfAssetPath, required this.lablename})
      : super(key: key);

  @override
  _PDFScreen2State createState() => _PDFScreen2State();
}

class _PDFScreen2State extends State<PDFScreen2> {
  String? _localFilePath;
  String? _error;

  @override
  void initState() {
    super.initState();
    _preparePdfFile().catchError((error) {
      setState(() {
        _error = error.toString();
      });
    });
  }

  Future<void> _preparePdfFile() async {
    try {
      final ByteData data = await rootBundle.load(widget.pdfAssetPath);
      final Uint8List bytes = data.buffer.asUint8List();
      final Directory dir = await getApplicationDocumentsDirectory();
      final File file =
          File('${dir.path}/${widget.pdfAssetPath.split('/').last}');

      await file.writeAsBytes(bytes);
      setState(() {
        _localFilePath = file.path;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeManager.themeColor,
          centerTitle: true,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: ThemeManager.themelightColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                "assets/img/black_btn.png",
                color: ThemeManager.themeText,
                width: 15,
                height: 15,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text(
            widget.lablename,
            style: TextStyle(
                color: ThemeManager.themeText,
                fontSize: AppFontSizes.mediumDefault,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: Center(
          child: Text('Error loading PDF: $_error'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeManager.themeColor,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ThemeManager.themelightColor,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/img/black_btn.png",
              color: ThemeManager.themeText,
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          widget.lablename,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: _localFilePath == null
          ? const Center(child: CircularProgressIndicator())
          : PDFView(
              filePath: _localFilePath,
              autoSpacing: true, // Automatically add space between pages
              enableSwipe: true, // Allow swipe to navigate
              pageSnap: true, // Snap pages to screen boundaries
              swipeHorizontal: false, // Swipe horizontally or vertically
              nightMode: false, // View in night mode with inverted colors
            ),
    );
  }
}
