import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:snbs/models/configuration.dart';

class ConfigurationState extends ChangeNotifier {
  static ChangeNotifierProvider<ConfigurationState> state =
      ChangeNotifierProvider(
    (_) => ConfigurationState(),
  );

  static bool _initialized = false;
  static Box<Configuration>? _box;

  static Future<void> initialize() async {
    _box = await Hive.openBox("configuration");
    _initialized = true;
  }

  bool get isInitialized => _initialized;
  bool get isConfigurationNeeded => _box!.get('configuration') != null;

  Configuration? get configuration => _box!.get('configuration');
  Future<void> setConfiguration(Configuration configuration) =>
      _box!.put('configuration', configuration);
}
