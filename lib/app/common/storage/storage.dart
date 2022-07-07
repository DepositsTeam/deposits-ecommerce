import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class Storage {
  const Storage._();

  static final GetStorage _storage = GetStorage("deposits-ecommerce");

  static GetStorage get storage => _storage;

  static Future<void> saveValue(String key, dynamic value) async =>
      await _storage.write(key, value);

  static T? getValue<T>(String key) => _storage.read<T>(key);

  static bool hasData(String key) => _storage.hasData(key);

  static Future<void> removeValue(String key) => _storage.remove(key);

  static Future<void> clearStorage() => _storage.erase();
}
