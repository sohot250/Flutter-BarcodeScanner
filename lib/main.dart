import 'package:flutter/material.dart';
import 'package:mybarcode/page/qr_create_page.dart';
import 'package:mybarcode/page/qr_scan_page.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Barcode Scanner'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => QRCreatePage())),
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: Text('Create QR Code',
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => QRScanPage())),
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child:
                    Text('Scan QR Code', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ));
  }
}
