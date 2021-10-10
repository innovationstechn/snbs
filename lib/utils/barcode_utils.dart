import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:tuple/tuple.dart';

enum ScanResult { SCANNED, CANCELED, ERROR }

Future<Tuple2<ScanResult, String>> scanBarcode() async {
  String scanned = "";
  ScanResult scanResult = ScanResult.SCANNED;

  try {
    scanned = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", 'Cancel', false, ScanMode.DEFAULT);
  } on PlatformException {
    return Tuple2(ScanResult.ERROR, scanned);
  }

  if (scanned != "-1")
    scanResult = ScanResult.SCANNED;
  else
    scanResult = ScanResult.CANCELED;

  return Tuple2(scanResult, scanned);
}
