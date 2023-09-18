import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grambu_task/core/constants/screen_constants.dart';
import 'package:grambu_task/screens/product_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'home_screen.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final qrkey = GlobalKey(debugLabel: 'QR');
  Barcode? _barcode;
  QRViewController? _controller;
  double zoomValue = 1.0;

  @override
  void reassemble() async {
    // TODO: implement reassemble
    super.reassemble();
    if (Platform.isAndroid) {
      await _controller!.pauseCamera();
    }
    _controller!.resumeCamera();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  bool isScanning = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
                child: InteractiveViewer(
              child: QRView(
                key: qrkey,
                onQRViewCreated: (QRViewController controller) {
                  _controller = controller;

                  controller.scannedDataStream.listen((barcode) async {
                    if (!isScanning) {
                      setState(() {
                        isScanning = true;
                        productCodeGlobal = barcode.code.toString().trim();
                      });
                      if (barcode.code!.isNotEmpty) {
                        Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(
                                builder: (context) => ProductScreen()));
                        showSnackBar(
                            context, 'SCANNED SUCCESSFULLY', Colors.green);
                      } else {
                        showSnackBar(context, 'SCAN A VALID BARCODE OR QR CODE',
                            Colors.red);
                      }
                    }
                  });
                },
                overlay: QrScannerOverlayShape(
                  borderWidth: 20,
                  borderLength: 30,
                  borderRadius: 20,
                  borderColor: Color(0xFF000000),
                  cutOutSize: MediaQuery.of(context).size.width * 0.35,
                ),
              ),
            )),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.04,
              left: MediaQuery.of(context).size.width * 0.05,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.015),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.height * 0.03,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.18,
                  ),
                  Center(
                    child: Text(
                      "Scanning",
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height * 0.033,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class QrScannerScreen extends StatefulWidget {
//   const QrScannerScreen({Key? key}) : super(key: key);
//
//   @override
//   State<QrScannerScreen> createState() => _QrScannerScreenState();
// }
//
// class _QrScannerScreenState extends State<QrScannerScreen> {
//   String scannedData = "Scan a QR code";
//
//   Future<void> scanQRCode() async {
//     print("object FUNCOCKp");
//     try {
//       String barcode = await FlutterBarcodeScanner.scanBarcode(
//         "#ff6666", // Color for the toolbar
//         "Cancel", // Text for the cancel button
//         true, // Use the flashlight
//         ScanMode.QR, // Specify the scan mode (QR code in this case)
//       );
//       print("object");
//       print(barcode);
//       print(barcode.length);
//       print("barcode.length");
//       setState(() {
//         scannedData = barcode; // Update the scanned data.
//       });
//     } catch (e) {
//       if (e is FormatException) {
//         // Handle exceptions such as a user canceling the scan.
//         setState(() {
//           scannedData = "Scan canceled";
//         });
//       } else {
//         // Handle other exceptions.
//         setState(() {
//           scannedData = "Error: $e";
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Center(
//                 child: ElevatedButton(
//               onPressed: scanQRCode,
//               child: Text('SCAN'),
//             )),
//             Positioned(
//               top: MediaQuery.of(context).size.height * 0.04,
//               left: MediaQuery.of(context).size.width * 0.05,
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(
//                         left: MediaQuery.of(context).size.width * 0.015),
//                     child: IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: Icon(
//                         Icons.arrow_back_ios_new_rounded,
//                         color: Colors.white,
//                         size: MediaQuery.of(context).size.height * 0.03,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.18,
//                   ),
//                   Center(
//                     child: Text(
//                       "Scanning",
//                       style: GoogleFonts.poppins(
//                         fontSize: MediaQuery.of(context).size.height * 0.033,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
