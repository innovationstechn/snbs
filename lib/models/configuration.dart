import 'package:hive_flutter/adapters.dart';

part 'configuration.g.dart';

@HiveType(typeId: 2)
class Configuration {
  @HiveField(0)
  String apiUrl;
  @HiveField(1)
  String deviceID;
  @HiveField(2)
  String key;

  Configuration({
    required this.apiUrl,
    required this.deviceID,
    required this.key,
  });
}
