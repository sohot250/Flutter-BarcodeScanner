import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? scanResult;
  bool checkYoutubeUrl = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Barcode Scanner'),
        ),
        body: Container(
            child: SizedBox(
          height: 300,
          width: double.infinity,
          child: Card(
              child: Column(
            children: [
              SizedBox(height: 50),
              Text('Result', style: TextStyle(fontSize: 25)),
              Text(scanResult ??= '', style: TextStyle(fontSize: 30)),
              Spacer(),
              checkYoutubeUrl
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (await canLaunch(scanResult!))
                            await launch(scanResult!);
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        child: Text('Youtube',
                            style: TextStyle(color: Colors.white)),
                      ))
                  : Container()
            ],
          )),
        )),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            onPressed: startScan,
            child: Icon(Icons.qr_code_scanner),
          ),
        ]));
  }

  startScan() async {
    //อ่านข้อมูลจาก barcode ได้เป็นข้อความ
    String? cameraScanResult = await scanner.scan();
    setState(() {
      scanResult = cameraScanResult;
    });
    if (scanResult!.contains('youtube.com')) checkYoutubeUrl = true;
  }
}
