import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snbs/utils/barcode_utils.dart';
import 'package:snbs/widgets/barcode_list_element.dart';
import 'package:snbs/widgets/verification_modal.dart';

abstract class BaseScanScreen extends ConsumerWidget {
  const BaseScanScreen({Key? key}) : super(key: key);

  Widget common(List items, ScopedReader ref) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      reverse: true,
      itemBuilder: (context, index) {
        return BarcodeListElement(
          barcode: items[index].toString(),
          index: index,
          onTap: (int index) {
            onItemTap(index, context);
          },
          onDelete: (int index) => onDelete(ref, index),
          onUpdate: (int index) => onUpdate(ref, index),
        );
      },
    );
  }

  Future<void> scan(BuildContext outerContext, ScopedReader ref) async {
    final scanResults = await scanBarcode();

    switch (scanResults.item1) {
      case ScanResult.SCANNED:
        {
          await showModalBottomSheet(
            context: outerContext,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
            ),
            builder: (context) {
              return VerificationModal(
                barcode: scanResults.item2,
                onVerified: (String barcode) {
                  onScanSuccess(
                    ref,
                    barcode,
                  );
                  Navigator.pop(context);
                },
                onRetake: () async {
                  Navigator.pop(context);
                  scan(outerContext, ref);
                },
              );
            },
          );

          break;
        }
      case ScanResult.CANCELED:
        onScanCancel();
        break;
      case ScanResult.ERROR:
        onScanError();
        break;
    }
  }

  Future<void> onScanError();
  Future<void> onScanSuccess(ScopedReader ref, String item);
  Future<void> onScanCancel();
  Future<void> onDelete(ScopedReader ref, int index);
  Future<void> onUpdate(ScopedReader ref, int index);

  void onItemTap(int index, BuildContext context);

  FloatingActionButton fab(BuildContext context, ScopedReader ref) =>
      FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () => scan(context, ref),
      );
}
