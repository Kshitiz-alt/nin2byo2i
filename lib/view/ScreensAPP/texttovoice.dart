// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';

// class TextToVoice extends StatefulWidget {
//   @override
//   _TextToVoiceState createState() => _TextToVoiceState();
// }

// class _TextToVoiceState extends State<TextToVoice> {
//   FlutterTts flutterTts = FlutterTts();
//   TextEditingController textEditingController = TextEditingController();

//   @override
//   void dispose() {
//     flutterTts.stop();
//     super.dispose();
//   }

//   Future<void> _speak(String text) async {
//     await flutterTts.setPitch(1.0);
//     await flutterTts.setSpeechRate(0.5);

//     // Set language to Hindi
//     await flutterTts.setLanguage("hi-IN");

//     // Get available voices
//     List<dynamic>? voices = await flutterTts.getVoices;

//     // Find a male voice (adjust according to available voices on your device)
//     Map<String, String>? maleVoice;
//     if (voices != null && voices.isNotEmpty) {
//       maleVoice = voices.firstWhere(
//         (voice) =>
//             voice["language"] == "hi-IN" && voice["name"].contains("male"),
//         orElse: () => null,
//       );
//     }

//     if (maleVoice != null) {
//       await flutterTts.setVoice(maleVoice);
//     }

//     if (text.isNotEmpty) {
//       await flutterTts.speak(text);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Text to Voice'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: textEditingController,
//               decoration: InputDecoration(labelText: 'Enter Text'),
//             ),
//             SizedBox(height: 20),
//             GestureDetector(
//               onLongPress: () => _speak(textEditingController.text),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 padding: EdgeInsets.all(16),
//                 child: Text(
//                   'Hold to Speak',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: TextToVoice(),
//   ));
// }
