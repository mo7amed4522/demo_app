// File: lib/core/data/data_sources/local/bx_shared_preferences_data_source.dart
// Architecture: Core -> Data -> Data Sources -> Local -> Bx Shared Preferences Data Source
// Purpose: Provides methods to save and retrieve data using SharedPreferences

import 'package:demo_app/core/constant/bx_shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Abstraction over [SharedPreferences] that provides typed read/write
/// operations for primitive values, user data and app settings (language,
/// theme).
///
/// All methods return [Future] values and are meant to be implemented by
/// a concrete class that wraps the platform's shared preferences.
abstract class BxSharedPreferencesDataSource {
  /// Persists a [String] value associated with the given [key].
  Future<bool> saveString(String key, String value);

  /// Returns the [String] value for [key], or `null` if it does not exist.
  Future<String?> getString(String key);

  /// Persists an [int] value associated with the given [key].
  Future<bool> saveInt(String key, int value);

  /// Returns the [int] value for [key], or `null` if it does not exist.
  Future<int?> getInt(String key);

  /// Persists a [bool] value associated with the given [key].
  Future<bool> saveBool(String key, bool value);

  /// Returns the [bool] value for [key], or `null` if it does not exist.
  Future<bool?> getBool(String key);

  /// Removes the entry identified by [key].
  Future<bool> remove(String key);

  /// Clears all shared preferences.
  Future<bool> clearAll();

  /// Saves the currently selected language code (e.g. `'en'`, `'ar'`) using
  /// the predefined key [BxSharedPreferencesKeys.languageCode].
  Future<bool> saveLanguageCode(String languageCode);

  /// Retrieves the saved language code, or `null` if not set.
  Future<String?> getLanguageCode();

  /// Saves the current theme mode preference (e.g. `'light'`, `'dark'`,
  /// `'system'`) using the predefined key [BxSharedPreferencesKeys.themeMode].
  Future<bool> saveThemeMode(String themeMode);

  /// Retrieves the saved theme mode, or `null` if not set.
  Future<String?> getThemeMode();
}

/// Concrete implementation of [BxSharedPreferencesDataSource] that uses
/// the [SharedPreferences] plugin for persistent storage.
///
/// The constructor takes an existing [SharedPreferences] instance, which
/// should be obtained via `SharedPreferences.getInstance()` before creating
/// this data source.
class BxSharedPreferencesDataSourceImpl
    implements BxSharedPreferencesDataSource {
  final SharedPreferences _sharedPreferences;

  BxSharedPreferencesDataSourceImpl(this._sharedPreferences);

  @override
  Future<bool> saveString(String key, String value) async {
    return _sharedPreferences.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    return _sharedPreferences.getString(key);
  }

  @override
  Future<bool> saveInt(String key, int value) async {
    return _sharedPreferences.setInt(key, value);
  }

  @override
  Future<int?> getInt(String key) async {
    return _sharedPreferences.getInt(key);
  }

  @override
  Future<bool> saveBool(String key, bool value) async {
    return _sharedPreferences.setBool(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    return _sharedPreferences.getBool(key);
  }

  @override
  Future<bool> remove(String key) async {
    return _sharedPreferences.remove(key);
  }

  @override
  Future<bool> clearAll() async {
    return _sharedPreferences.clear();
  }

  @override
  Future<bool> saveLanguageCode(String languageCode) async {
    return _sharedPreferences.setString(
      BxSharedPreferencesKeys.languageCode,
      languageCode,
    );
  }

  @override
  Future<String?> getLanguageCode() async {
    return _sharedPreferences.getString(BxSharedPreferencesKeys.languageCode);
  }

  @override
  Future<bool> saveThemeMode(String themeMode) async {
    return _sharedPreferences.setString(
      BxSharedPreferencesKeys.themeMode,
      themeMode,
    );
  }

  @override
  Future<String?> getThemeMode() async {
    return _sharedPreferences.getString(BxSharedPreferencesKeys.themeMode);
  }
}
