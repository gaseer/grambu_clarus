import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grambu_task/core/constants/screen_constants.dart';
import 'package:grambu_task/screens/product_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'home_screen.dart';

class DesignCodeScanner extends StatefulWidget {
  const DesignCodeScanner({Key? key}) : super(key: key);

  @override
  State<DesignCodeScanner> createState() => _DesignCodeScannerState();
}

class _DesignCodeScannerState extends State<DesignCodeScanner> {
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
                        designCodeGlobal = barcode.code.toString().trim();
                      });
                      if (barcode.code!.isNotEmpty) {
                        Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(
                                builder: (context) => const ProductScreen()));
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
