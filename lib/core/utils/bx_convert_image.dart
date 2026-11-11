// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as path;

/// Image conversion helper for managing base64 to image conversions
///
/// Handles conversion between base64 strings and images with support for:
/// - Converting base64 to Image widget
/// - Converting base64 to File with custom names
/// - Saving images to local storage
/// - Extracting image metadata
/// - Batch processing multiple images
class BxConvertImage {
  final String? base64String;
  final Uint8List? bytes;
  final String? fileName;
  final String? filePath;

  const BxConvertImage({this.base64String, this.bytes, this.fileName, this.filePath});

  /// Creates a [BxConvertImage] from a base64 string
  factory BxConvertImage.fromBase64(String base64String, {String? fileName}) {
    return BxConvertImage(base64String: base64String, bytes: base64Decode(base64String), fileName: fileName);
  }

  /// Creates a [BxConvertImage] from bytes
  factory BxConvertImage.fromBytes(Uint8List bytes, {String? fileName}) {
    return BxConvertImage(base64String: base64Encode(bytes), bytes: bytes, fileName: fileName);
  }

  /// Creates a [BxConvertImage] from a File
  static Future<BxConvertImage> fromFile(File file) async {
    final bytes = await file.readAsBytes();
    final fileName = path.basename(file.path);
    return BxConvertImage.fromBytes(bytes, fileName: fileName);
  }

  /// Converts base64 string to Image widget
  static Image imageFromBase64String(String base64String, {double? height, double? width, BoxFit fit = BoxFit.cover}) {
    return Image.memory(base64Decode(base64String), height: height, width: width, fit: fit);
  }

  /// Converts bytes to Image widget
  static Image imageFromBytes(Uint8List bytes, {double? height, double? width, BoxFit fit = BoxFit.cover}) {
    return Image.memory(bytes, height: height, width: width, fit: fit);
  }

  /// Gets the Image widget from this instance
  Image toImage({double? height, double? width, BoxFit fit = BoxFit.cover}) {
    if (bytes == null) {
      throw Exception('No image data available');
    }
    return Image.memory(bytes!, height: height, width: width, fit: fit);
  }

  /// Extracts image metadata from base64 string
  static ImageMetadata getImageMetadata(String base64String) {
    final bytes = base64Decode(base64String);
    return ImageMetadata(sizeInBytes: bytes.length, sizeInKB: bytes.length / 1024, sizeInMB: bytes.length / (1024 * 1024), base64Length: base64String.length, bytes: bytes);
  }

  /// Gets metadata for this instance
  ImageMetadata get metadata {
    if (bytes == null) {
      throw Exception('No image data available');
    }
    return ImageMetadata(sizeInBytes: bytes!.length, sizeInKB: bytes!.length / 1024, sizeInMB: bytes!.length / (1024 * 1024), base64Length: base64String?.length ?? 0, bytes: bytes);
  }

  /// Validates if a string is a valid base64 image
  static bool isValidBase64Image(String base64String) {
    try {
      final bytes = base64Decode(base64String);
      // Check if it's likely an image (has minimum size and common image headers)
      if (bytes.length < 16) return false;

      // Check for common image headers
      // PNG: 137 80 78 71 13 10 26 10
      // JPEG: 255 216 255
      // GIF: 71 73 70 56
      if ((bytes[0] == 0x89 && bytes[1] == 0x50 && bytes[2] == 0x4E && bytes[3] == 0x47) || // PNG
          (bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF) || // JPEG
          (bytes[0] == 0x47 && bytes[1] == 0x49 && bytes[2] == 0x46 && bytes[3] == 0x38)) {
        // GIF
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Converts base64 string to Uint8List
  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  /// Converts Uint8List to base64 string
  static String base64StringFromBytes(Uint8List data) {
    return base64Encode(data);
  }

  /// Removes data URL prefix from base64 string if present
  static String cleanBase64String(String base64String) {
    if (base64String.contains(',')) {
      return base64String.split(',').last;
    }
    return base64String;
  }

  /// Adds data URL prefix to base64 string
  static String addDataUrlPrefix(String base64String, {String mimeType = 'image/png'}) {
    return 'data:$mimeType;base64,$base64String';
  }

  /// Creates a copy of this instance with updated values
  BxConvertImage copyWith({String? base64String, Uint8List? bytes, String? fileName, String? filePath}) {
    return BxConvertImage(base64String: base64String ?? this.base64String, bytes: bytes ?? this.bytes, fileName: fileName ?? this.fileName, filePath: filePath ?? this.filePath);
  }

  @override
  String toString() {
    return 'BxConvertImage(base64String: ${base64String?.substring(0, 50)}..., '
        'bytes: ${bytes?.length} bytes, fileName: $fileName, filePath: $filePath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BxConvertImage && other.base64String == base64String && other.fileName == fileName && other.filePath == filePath;
  }

  @override
  int get hashCode => Object.hash(base64String, fileName, filePath);
}

/// Metadata information for an image
class ImageMetadata {
  final int sizeInBytes;
  final double sizeInKB;
  final double sizeInMB;
  final int base64Length;
  final Uint8List? bytes;

  const ImageMetadata({required this.sizeInBytes, required this.sizeInKB, required this.sizeInMB, required this.base64Length, this.bytes});

  /// Formats the size in a human-readable format
  String get formattedSize {
    if (sizeInMB >= 1) {
      return '${sizeInMB.toStringAsFixed(2)} MB';
    } else if (sizeInKB >= 1) {
      return '${sizeInKB.toStringAsFixed(2)} KB';
    } else {
      return '$sizeInBytes B';
    }
  }

  /// Returns true if the image size is within limits
  bool isWithinSizeLimit({int maxSizeInMB = 10}) {
    return sizeInMB <= maxSizeInMB;
  }

  @override
  String toString() {
    return 'BxImageMetadata(size: $formattedSize, base64Length: $base64Length)';
  }
}
