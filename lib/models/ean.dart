import 'package:snbs/models/sn.dart';

class EAN {
  final String ean;
  final List<SN> serialNumbers = List.empty(growable: true);

  EAN({required this.ean});

  List<String> toJson() {
    return serialNumbers.map((e) => e.toJson()).toList();
  }

  void addSN(SN sn) => serialNumbers.add(sn);

  @override
  String toString() => ean;
}
