import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QRScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  String? scannedValue;
  bool checkYoutubeUrl = false;
  MobileScannerController mobileController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Scan QR'),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Scan Result',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '$scannedValue',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          checkYoutubeUrl
              ? SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final Uri url = Uri.parse(scannedValue!);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      'Youtube',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              : Container(),
          SizedBox(height: 72),
          Expanded(
            flex: 4,
            child: MobileScanner(
              controller: mobileController,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  setState(() {
                    scannedValue = barcode.rawValue;
                    checkYoutubeUrl = scannedValue!.contains('youtube.com');
                  });
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.flash_on),
                onPressed: () => mobileController.toggleTorch(),
              ),
              IconButton(
                icon: const Icon(Icons.cameraswitch),
                onPressed: () => mobileController.switchCamera(),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  // Future<void> scanQRCode() async {
  //   try {
  //     final qrCode = await FlutterBarcodeScanner.scanBarcode(
  //       '#ff6666',
  //       'Cancel',
  //       true,
  //       ScanMode.QR,
  //     );

  //     if (!mounted) return;

  //     setState(() {
  //       this.scannedValue = qrCode;
  //     });
  //     if (scannedValue.contains('youtube.com')) checkYoutubeUrl = true;
  //   } on PlatformException {
  //     scannedValue = 'Failed to get platform version.';
  //   }
  // }
}
