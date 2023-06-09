import "dart:convert";
import "dart:io";
import "package:qr_code_scanner/qr_code_scanner.dart";
import "package:http/http.dart";
import "package:flutter/material.dart";

class ScannerScreen extends StatefulWidget{
  const ScannerScreen({super.key});
  

  @override
  _ScannerScreen createState() {
    return _ScannerScreen();
  }

}

class _ScannerScreen extends State<ScannerScreen>{
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");
  QRViewController? controller;
  BuildContext? globalContext;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onQrViewCreated(QRViewController controller,BuildContext context,String ipAdress) async {
    this.controller = controller;

    this.controller?.scannedDataStream.listen((event) async {
      String code = event.code.toString();
      String message = "";
      try {
        final result = await post(Uri(
          scheme: "http",
          host: ipAdress,
          port: 6789,
          path: "/set-to-present"
        ), body: { "numInscript":code });
        message = result.body;
      } catch(e) {
        print(e);
        message = "Il semble avoir une erreur sur l'Hote: ${ipAdress}";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: const Duration(seconds: 1),
            content: Text(
              message
            )
        )
      );
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    if(Platform.isAndroid){
      controller!.pauseCamera();
    } else if(Platform.isIOS){
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    globalContext = context;
    final String ipAdrss = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 7,
              child: QRView(
                key: qrKey,
                onQRViewCreated: (ctrl) =>_onQrViewCreated(ctrl,context,ipAdrss),
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.white,
                ),
              )
          ),
        ],
      )
    );
  }

}