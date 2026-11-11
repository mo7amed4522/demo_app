/// Utility that formats phone numbers for display, adapting to the
/// current locale and text direction.
///
/// All methods are static and handle both LTR (English) and RTL (Arabic)
/// contexts while preserving the Western digit representation.  The
/// class adds proper directional markers so numbers remain readable
/// regardless of the surrounding text direction.
///
/// File: lib/core/utils/bx_phone_formatter.dart
/// Architecture: Core Layer - Phone Formatter
/// Purpose: Format phone numbers based on language
library;

import 'package:flutter/material.dart';

class BxPhoneFormatter {
  /// Formats a phone number according to the current locale and text direction.
  ///
  /// For Arabic or RTL contexts the result includes a left‑to‑right marker
  /// (`\u200E`) to prevent the number from being rearranged by the bidirectional
  /// algorithm.  Otherwise a standard English grouping is used.
  static String formatPhoneNumber(String phoneNumber, BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    // Check if it's Arabic language
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    if (isArabic || isRtl) {
      return _formatForArabicDisplay(phoneNumber);
    } else {
      return _formatForEnglish(phoneNumber);
    }
  }

  /// Formats a phone number for a left‑to‑right (English) context.
  ///
  /// Groups a UAE number (`+971XXXXXXXXX`) as `+971 XX XXX XXXX`.
  /// For other international numbers with 13 characters it uses a
  /// `+XXX XX XXX XXXX` pattern.  Returns the original string if
  /// no pattern matches.
  static String _formatForEnglish(String phoneNumber) {
    // Remove any non-digit characters except +
    String cleaned = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

    // Format: +971 50 271 4255
    if (cleaned.startsWith('+971')) {
      String withoutCode = cleaned.substring(4); // Remove +971
      if (withoutCode.length == 9) {
        return '+971 ${withoutCode.substring(0, 2)} ${withoutCode.substring(2, 5)} ${withoutCode.substring(5)}';
      }
    }

    // Alternative formatting for other formats
    if (cleaned.length == 13 && cleaned.startsWith('+')) {
      return '${cleaned.substring(0, 4)} ${cleaned.substring(4, 6)} ${cleaned.substring(6, 9)} ${cleaned.substring(9)}';
    }

    return phoneNumber;
  }

  /// Formats a phone number for Arabic / RTL display while keeping
  /// English digits.
  ///
  /// Uses the same grouping as [_formatForEnglish] but prepends a
  /// left‑to‑right mark (`\u200E`) so the number stays properly
  /// ordered within an RTL paragraph.
  static String _formatForArabicDisplay(String phoneNumber) {
    // Remove any non-digit characters except +
    String cleaned = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

    // Format with English numbers but add RTL markers
    String formatted = '';

    // Format: +971 50 271 4255
    if (cleaned.startsWith('+971')) {
      String withoutCode = cleaned.substring(4); // Remove +971
      if (withoutCode.length == 9) {
        formatted = '+971 ${withoutCode.substring(0, 2)} ${withoutCode.substring(2, 5)} ${withoutCode.substring(5)}';
      } else {
        formatted = cleaned;
      }
    } else if (cleaned.length == 13 && cleaned.startsWith('+')) {
      formatted = '${cleaned.substring(0, 4)} ${cleaned.substring(4, 6)} ${cleaned.substring(6, 9)} ${cleaned.substring(9)}';
    } else {
      formatted = phoneNumber;
    }

    // Add RTL mark to ensure proper display in RTL context
    // This keeps the numbers displayed left-to-right even in RTL text
    return '\u200E$formatted';
  }

  /// Formats a phone number for display, adding a directional marker only
  /// when the locale is Arabic.
  ///
  /// This combines the English grouping with an RTL guard, offering a
  /// safe output for mixed‑direction UIs.
  static String formatPhoneNumberForDisplay(String phoneNumber, BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    // Format the number with English digits
    String formatted = _formatForEnglish(phoneNumber);

    if (isArabic) {
      // Add RTL mark for proper alignment in Arabic context
      // but keep the English/Western digits
      return '\u200E$formatted';
    }

    return formatted;
  }

  /// Formats a phone number without requiring a [BuildContext].
  ///
  /// Uses the same English‑style grouping as [_formatForEnglish].
  /// No directional markers are added.  If you need locale‑aware
  /// handling use [formatPhoneNumber] or [formatPhoneNumberForDisplay].
  static String formatSimple(String phoneNumber) {
    String cleaned = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

    if (cleaned.startsWith('+971')) {
      String withoutCode = cleaned.substring(4);
      if (withoutCode.length == 9) {
        return '+971 ${withoutCode.substring(0, 2)} ${withoutCode.substring(2, 5)} ${withoutCode.substring(5)}';
      }
    }

    if (cleaned.length == 13 && cleaned.startsWith('+')) {
      return '${cleaned.substring(0, 4)} ${cleaned.substring(4, 6)} ${cleaned.substring(6, 9)} ${cleaned.substring(9)}';
    }

    return phoneNumber;
  }
}
