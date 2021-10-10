import 'package:snbs/models/ean.dart';

class DNN {
  final String dnn;
  final List<EAN> articleNumbers;
  DNN({required this.dnn, this.articleNumbers = const []});

  Map<String, List<String>> toJson() {
    Map<String, List<String>> json = Map();

    articleNumbers.forEach((element) {
      json[element.ean] = element.toJson();
    });

    return json;
  }

  @override
  String toString() => dnn;
}
