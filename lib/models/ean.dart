import 'package:snbs/models/sn.dart';

class EAN {
  final String ean;
  final List<SN> scannedSNs = List.empty(growable: true);

  EAN({required this.ean});

  List<String> toJson() {
    return scannedSNs.map((e) => e.toJson()).toList();
  }

  void addSN(SN sn) => scannedSNs.add(sn);

  @override
  String toString() => ean;
}
