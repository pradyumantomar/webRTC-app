import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc_node/screens/join_screen.dart';
import 'package:flutter_webrtc_node/services/signalling.service.dart';

void main() {
  runApp(VideoCallApp());
}

class VideoCallApp extends StatelessWidget {
  VideoCallApp({super.key});

  //signalling server url
  final String websocketUrl = 'https://signalling-server-eaja.onrender.com';

  //generate callerID of local user
  final String selfCallerID =
      Random().nextInt(999999).toString().padLeft(6, '0');

  @override
  Widget build(BuildContext context) {
    // init signalling service
    SignallingService.instance.init(
      websocketUrl: websocketUrl,
      selfCallerID: selfCallerID,
    );

    // return Material app
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: const ColorScheme.dark(),
        ),
        themeMode: ThemeMode.system,
        home: JoinScreen(selfCallerId: selfCallerID));
  }
}
