import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter-WebRTC',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter-WebRTC: HomePage'),
    );
  }
}

// Home Page:- Init
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// Home Page:- Code
class _MyHomePageState extends State<MyHomePage> {
  final _localRenderer = new RTCVideoRenderer();
  final _remoteRenderer = new RTCVideoRenderer();

  @override
  dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initRenderers();
    _getUserMedia();
    super.initState();
  }

  initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  _getUserMedia() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': false,
      'video': {
        'facingMode': 'user',
      },
    };

    MediaStream stream =
        await navigator.mediaDevices.getUserMedia(mediaConstraints);
    _localRenderer.srcObject = stream;
  }

  videoRenderers() => SizedBox(
      height: 210,
      child: Row(
        children: [
          Flexible(
              child: Container(
            key: Key('local'),
            margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            decoration: BoxDecoration(color: Colors.black),
            child: RTCVideoView(_localRenderer),
          )),
          Flexible(
              child: Container(
            key: Key('remote'),
            margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            decoration: BoxDecoration(color: Colors.black),
            child: RTCVideoView(_localRenderer),
          ))
        ],
      )
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(children: [
       videoRenderers(),
        //   offerAndAnswerButtons(),
        //   sdpCondidateTF(),
        //   sdpCondidateButtons(),
        ])
      ),
    );
  }
}
