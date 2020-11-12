import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  String _textValue = "sample";

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: new ThemeData(
          primarySwatch: Colors.blue,
          buttonColor: Colors.black,
        ),
        home: new Scaffold(
          backgroundColor: Colors.black,
          appBar: new AppBar(
            title: new Text('Mobivision'),
          ),
          body: Center(
            child: Container(
                width: 400,
                height: 500,
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: new Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text(
                            _textValue,
                            style: TextStyle(color: Colors.white),
                          ),
                          new RaisedButton.icon(
                            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            onPressed: _read,
                            icon: Icon(
                              Icons.camera,
                              color: Colors.white,
                            ),
                            label: new Text(
                              'Open Vision',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ]),
                  ),
                )),
          ),
        ));
  }

  Future<Null> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        camera: _cameraOcr,
        waitTap: true,
      );

      setState(() {
        _textValue = texts[0].value;
      });
    } on Exception {
      texts.add(new OcrText('Failed to recognize text.'));
    }
  }
}
