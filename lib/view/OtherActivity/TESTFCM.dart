import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For clipboard operations
import 'package:firebase_messaging/firebase_messaging.dart';

class FcmTokenPage extends StatefulWidget {
  const FcmTokenPage({super.key});

  @override
  _FcmTokenPageState createState() => _FcmTokenPageState();
}

class _FcmTokenPageState extends State<FcmTokenPage> {
  String _token = 'Waiting for token...';

  @override
  void initState() {
    super.initState();
    // Initialize Firebase Messaging
    FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        _token = token ?? 'No token available.';
      });
    });

    // Listen for incoming messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message while in the foreground!');
      if (message.notification != null) {
        debugPrint('Message data: ${message.notification!.body}');
      }
    });
  }

  // Function to copy the FCM token to clipboard
  void _copyTokenToClipboard() {
    Clipboard.setData(ClipboardData(text: _token));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Token copied to clipboard'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FCM Token'),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: _copyTokenToClipboard,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'FCM Token:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              _token,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

