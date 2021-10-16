import 'package:snbs/models/ean.dart';

class DNN {
  final String dnn;
  final List<EAN> scannedEANs = List.empty(growable: true);
  DNN({required this.dnn});

  Map<String, List<String>> toJson() {
    Map<String, List<String>> json = Map();

    scannedEANs.forEach((element) {
      json[element.ean] = element.toJson();
    });

    return json;
  }

  @override
  String toString() => dnn;
}
