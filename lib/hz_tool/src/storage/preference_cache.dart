import 'package:hz_tools/hz_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 缓存键值对数据，对SharedPreferences的二次封装
///
class PreferenceCache {
  static SharedPreferences? _prefs;
  static SharedPreferences get prefs {
    if (_prefs == null) {
      HzLog.e('You need to call PreferenceCache.setup method before PreferenceCache');
    }
    return _prefs!;
  }

  static setup() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Returns all keys in the persistent storage.
  static Set<String> getKeys() => prefs.getKeys();

  /// Reads a value of any type from persistent storage.
  static Object? get(String key) => key.isNotEmpty ? prefs.get(key) : null;

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// bool.
  static bool? getBool(String key) => key.isNotEmpty ? prefs.getBool(key) : null;

  /// Reads a value from persistent storage, throwing an exception if it's not
  /// an int.
  static int? getInt(String key) => key.isNotEmpty ? prefs.getInt(key) : null;

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// double.
  static double? getDouble(String key) => key.isNotEmpty ? prefs.getDouble(key) : null;

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// String.
  static String? getString(String key) => key.isNotEmpty ? prefs.getString(key) : null;

  /// Returns true if the persistent storage contains the given [key].
  static bool containsKey(String key) => key.isNotEmpty ? prefs.containsKey(key) : false;

  /// Reads a set of string values from persistent storage, throwing an
  /// exception if it's not a string set.
  static List<String>? getStringList(String key) =>
      key.isNotEmpty ? prefs.getStringList(key) : null;

  /// Saves a boolean [value] to persistent storage in the background.
  static Future<bool> setBool(String key, bool value) => prefs.setBool(key, value);

  /// Saves an integer [value] to persistent storage in the background.
  static Future<bool> setInt(String key, int value) => prefs.setInt(key, value);

  /// Saves a double [value] to persistent storage in the background.
  ///
  /// Android doesn't support storing doubles, so it will be stored as a float.
  static Future<bool> setDouble(String key, double value) => prefs.setDouble(key, value);

  /// Saves a string [value] to persistent storage in the background.
  ///
  /// Note: Due to limitations in Android's SharedPreferences,
  /// values cannot start with any one of the following:
  ///
  /// - 'VGhpcyBpcyB0aGUgcHJlZml4IGZvciBhIGxpc3Qu'
  /// - 'VGhpcyBpcyB0aGUgcHJlZml4IGZvciBCaWdJbnRlZ2Vy'
  /// - 'VGhpcyBpcyB0aGUgcHJlZml4IGZvciBEb3VibGUu'
  static Future<bool> setString(String key, String value) => prefs.setString(key, value);

  /// Saves a list of strings [value] to persistent storage in the background.
  static Future<bool> setStringList(String key, List<String> value) =>
      prefs.setStringList(key, value);

  /// Removes an entry from persistent storage.
  static Future<bool> remove(String key) => prefs.remove(key);

  /// Completes with true once the user preferences for the app has been cleared.
  static Future<bool> clear() => prefs.clear();
}
