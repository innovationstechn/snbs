import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snbs/models/dnn.dart';

class ScannedBarcodes extends ChangeNotifier {
  static final ChangeNotifierProvider<ScannedBarcodes> state =
      ChangeNotifierProvider(
    (_) => ScannedBarcodes(),
  );

  List<DNN> scanned = <DNN>[];

  void addItem(DNN dnn) {
    scanned.add(dnn);
    print('Item Added: $dnn');
    notifyListeners();
  }

  void removeItem(DNN dnn) {
    scanned.remove(dnn);
    notifyListeners();
  }

  void clearAll() {
    scanned.clear();
    notifyListeners();
  }

  void updateItem(int index, DNN updated) {
    if (index != -1) {
      scanned[index] = updated;
      notifyListeners();
    }
  }
}
