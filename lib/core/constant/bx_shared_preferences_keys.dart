/// Defines the keys used to read and write data in shared preferences.
///
/// All keys are grouped in a single, non‑instantiable class to avoid
/// typo‑prone string literals scattered across the codebase.
///
/// File: lib/core/constant/bx_shared_preferences_keys.dart
/// Architecture: Core Layer - Bx Shared Preferences Keys
/// Purpose: Define the shared preferences keys for the application
class BxSharedPreferencesKeys {
  // language made key
  /// Stores the currently selected locale language code (e.g. `'en'`, `'ar'`).
  static const String languageCode = 'language_code';

  // user data preference
  /// Stores the serialised user data of the logged‑in user.
  /// Typically a JSON string representation of the user profile.
  static const String userData = 'user_data_saved';

  // Theme mode key
  /// Stores the theme mode preference (e.g. light, dark, system).
  /// The actual value is an index or name of the selected [ThemeMode].
  static const String themeMode = 'theme_mode';

  // Onboarding completed key
  /// Indicates whether the user has completed the onboarding flow.
  /// A boolean flag (`true` once completed).
  static const String onboardingCompleted = 'onboarding_completed';
}
