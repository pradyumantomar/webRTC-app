import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SignallingService {
  //instance of socket
  Socket? socket;

  SignallingService._();
  static final instance = SignallingService._();

  init({required String websocketUrl, required String selfCallerID}) {
    //init socket
    socket = io(websocketUrl, {
      'transports': ['websocket'],
      'query': {'callerId': selfCallerID}
    });

    //listen onConnect event
    socket!.onConnect(
      (data) => debugPrint('Socket Connected !!'),
    );

    //listen onConnectError event
    socket!.onConnectError(
      (data) => debugPrint('Connect Error $data'),
    );

    //connect socket
    socket!.connect();
  }
}
