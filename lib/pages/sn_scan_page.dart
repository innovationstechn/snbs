import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/src/framework.dart';
import 'package:snbs/models/dnn.dart';
import 'package:snbs/models/sn.dart';
import 'package:snbs/pages/base_scan_page/base_scan_page.dart';
import 'package:snbs/state/scanned_barcodes.dart';

class SNScanPage extends BaseScanScreen {
  final int dnnIndex, eanIndex;

  SNScanPage({required this.dnnIndex, required this.eanIndex});

  @override
  Widget build(BuildContext context, ScopedReader ref) {
    final scanned = context
        .read(ScannedBarcodes.state)
        .scanned[dnnIndex]
        .articleNumbers[eanIndex];

    return Scaffold(
      appBar: null,
      floatingActionButton: fab(context, ref),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Text(
                      'EAN',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        scanned.ean,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.done,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Scanned SNs"),
                Consumer(
                  builder: (context, ref, child) {
                    return common(scanned.serialNumbers, ref);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<void> onScanCancel() {
    // TODO: implement onScanCancel
    throw UnimplementedError();
  }

  @override
  Future<void> onScanError() {
    // TODO: implement onScanError
    throw UnimplementedError();
  }

  @override
  Future<void> onScanSuccess(
      BuildContext context, ScopedReader ref, String item) async {
    final scannedBarcodes = ref(ScannedBarcodes.state);
    DNN old = scannedBarcodes.scanned[dnnIndex];

    final positionOfOldIfExists = old.articleNumbers[eanIndex].serialNumbers
        .indexWhere((element) => element.sn == item);

    if (positionOfOldIfExists == -1) {
      old.articleNumbers[eanIndex].addSN(SN(sn: item));

      DNN updated = DNN(
        dnn: old.dnn,
        articleNumbers: old.articleNumbers,
      );

      scannedBarcodes.updateItem(dnnIndex, updated);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Barcode $item already exists.'),
        ),
      );
    }
  }

  @override
  void onItemTap(int index, BuildContext context) {
    // TODO: implement onTap
  }

  @override
  Future<void> onDelete(ScopedReader ref, int index) async {
    ref(ScannedBarcodes.state)
        .scanned[dnnIndex]
        .articleNumbers[eanIndex]
        .serialNumbers
        .removeAt(index);
    ref(ScannedBarcodes.state)
        .updateItem(dnnIndex, ref(ScannedBarcodes.state).scanned[dnnIndex]);
  }

  @override
  Future<void> onUpdate(ScopedReader ref, int index) {
    // TODO: implement onUpdate
    throw UnimplementedError();
  }
}
