import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GetMyAppState();
  }
}

class _GetMyAppState extends State<MyApp>{
  final _localRenderer = RTCVideoRenderer();
  List _remoteRenderers = [];

  RTCPeerConnection _peerConnection;

  @override
  void initState() {
    super.initState();
    connect();
  }

  Future<void> connect() async {
    _peerConnection = await createPeerConnection({}, {});

    await _localRenderer.initialize();
    var localStream = await navigator.mediaDevices.getUserMedia({'audio':true, 'video':true});
    _localRenderer.srcObject = localStream;

    localStream.getTracks().forEach((track) async {
      await _peerConnection.addTrack(track, localStream);
    });

    _peerConnection.onIceCandidate = (candidate) {
      if (candidate == null) {
        return;
      }
      
    }
  }
}
