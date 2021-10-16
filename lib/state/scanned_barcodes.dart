import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snbs/models/dnn.dart';
import 'package:snbs/models/ean.dart';
import 'package:snbs/models/sn.dart';

class ScannedBarcodes extends ChangeNotifier {
  static final ChangeNotifierProvider<ScannedBarcodes> state =
      ChangeNotifierProvider(
    (_) => ScannedBarcodes(),
  );

  List<DNN> scannedDNNs = List.empty(growable: true);

  void addDNN(DNN dnn) {
    scannedDNNs.add(dnn);
    print('Item Added: $dnn');
    notifyListeners();
  }

  void updateDNN(int index, DNN updated) {
    if (index != -1) {
      scannedDNNs[index] = updated;
      notifyListeners();
    }
  }

  void removeDNN(int index) {
    scannedDNNs.removeAt(index);
    notifyListeners();
  }

  void addEAN(int dnnIndex, EAN ean) {
    scannedDNNs[dnnIndex].scannedEANs.add(ean);
    notifyListeners();
  }

  void updateEAN(int dnnIndex, int eanIndex, EAN ean) {
    scannedDNNs[dnnIndex].scannedEANs[eanIndex] = ean;
    notifyListeners();
  }

  void removeEAN(int dnnIndex, int eanIndex) {
    scannedDNNs[dnnIndex].scannedEANs.removeAt(eanIndex);
    notifyListeners();
  }

  void addSN(int dnnIndex, int eanIndex, SN sn) {
    scannedDNNs[dnnIndex].scannedEANs[eanIndex].scannedSNs.add(sn);
    notifyListeners();
  }

  void updateSN(int dnnIndex, int eanIndex, int snIndex, SN sn) {
    scannedDNNs[dnnIndex].scannedEANs[eanIndex].scannedSNs[snIndex] = sn;
    notifyListeners();
  }

  void removeSN(int dnnIndex, int eanIndex, int snIndex) {
    scannedDNNs[dnnIndex].scannedEANs[eanIndex].scannedSNs.removeAt(snIndex);
    notifyListeners();
  }

  void clearAll() {
    scannedDNNs.clear();
    notifyListeners();
  }
}
