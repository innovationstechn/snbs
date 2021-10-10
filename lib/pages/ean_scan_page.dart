import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/src/framework.dart';
import 'package:snbs/models/dnn.dart';
import 'package:snbs/models/ean.dart';
import 'package:snbs/pages/base_scan_page.dart';
import 'package:snbs/pages/sn_scan_page.dart';
import 'package:snbs/state/scanned_barcodes.dart';

class EANScanPage extends BaseScanScreen {
  final int dnnIndex;

  EANScanPage({required this.dnnIndex});

  @override
  Widget build(BuildContext context, ScopedReader ref) {
    final scanned = ref(ScannedBarcodes.state).scanned[dnnIndex];

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
                      'DNN',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        scanned.dnn,
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
                Text("Scanned EANs"),
                Consumer(
                  builder: (context, ref, child) {
                    return common(scanned.articleNumbers, ref);
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
  Future<void> onScanSuccess(ScopedReader ref, String item) async {
    DNN old = ref(ScannedBarcodes.state).scanned[dnnIndex];
    DNN updated = DNN(
      dnn: old.dnn,
      articleNumbers: [...old.articleNumbers, EAN(ean: item)],
    );

    ref(ScannedBarcodes.state).updateItem(dnnIndex, updated);
  }

  @override
  void onItemTap(int index, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SNScanPage(dnnIndex: dnnIndex, eanIndex: index),
      ),
    );
  }

  @override
  Future<void> onDelete(ScopedReader ref, int index) async {
    ref(ScannedBarcodes.state).scanned[dnnIndex].articleNumbers.removeAt(index);
    ref(ScannedBarcodes.state)
        .updateItem(dnnIndex, ref(ScannedBarcodes.state).scanned[dnnIndex]);
  }

  @override
  Future<void> onUpdate(ScopedReader ref, int index) {
    // TODO: implement onUpdate
    throw UnimplementedError();
  }
}
