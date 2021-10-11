import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:snbs/api/api.dart';
import 'package:snbs/models/dnn.dart';
import 'package:snbs/pages/base_scan_page/base_scan_page.dart';
import 'package:snbs/pages/base_scan_page/upload_button.dart';
import 'package:snbs/pages/ean_scan_page.dart';
import 'package:snbs/state/scanned_barcodes.dart';
import 'package:snbs/utils/encoding_utils.dart';
import 'package:tuple/tuple.dart';

class DNNScanPage extends BaseScanScreen {
  const DNNScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader ref) {
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
                UploadButton(
                  onTap: () => onFinishPressed(
                      context,
                      context.read(ScannedBarcodes.state).scanned,
                      '8d92jAss+o',
                      'DEV001'),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Scanned DNNs"),
                Consumer(
                  builder: (context, ref, child) {
                    final scanned = ref(ScannedBarcodes.state).scanned;

                    return common(scanned, ref);
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
    final newElement = DNN(dnn: item);

    final positionOfOldIfExists =
        scannedBarcodes.scanned.indexWhere((element) => element.dnn == item);

    if (positionOfOldIfExists == -1)
      scannedBarcodes.addItem(newElement);
    else
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Barcode $item already exists.'),
        ),
      );
  }

  @override
  void onItemTap(int index, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EANScanPage(dnnIndex: index),
      ),
    );
  }

  Future<void> onFinishPressed(
      BuildContext context, List<DNN> scanned, String key, String id) async {
    final data = Map<String, Map<String, List<String>>>();

    scanned.forEach((element) {
      data[element.dnn] = element.toJson();
    });

    Tuple2<String, String> processed = scannedToEncodings(data, key);

    print('Data: ${processed.item1}');
    print('Checksum: ${processed.item2}');

    Dio dio = Dio();
    APIClient client = APIClient(dio);

    final response = await http.get(
      Uri.parse(
          'https://serial.aitigo.de/?data=${processed.item1}&checksum=${processed.item2}&id=$id&debug=0'),
    );

    final result = response.body;

    if (result == "OK")
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully uploaded to the server.'),
        ),
      );
    else
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error while uploading to the server. $result'),
        ),
      );

    context.read(ScannedBarcodes.state).clearAll();
    //
    // String result =
    //     await client.sendDNNs(processed.item1, processed.item2, id, 0);

    print(result);
  }

  @override
  Future<void> onDelete(ScopedReader ref, int index) async {
    ref(ScannedBarcodes.state)
        .removeItem(ref(ScannedBarcodes.state).scanned[index]);
  }

  @override
  Future<void> onUpdate(ScopedReader ref, int index) {
    // TODO: implement onUpdate
    throw UnimplementedError();
  }
}
