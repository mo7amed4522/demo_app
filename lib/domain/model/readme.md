# Models Documentation

## Overview

The NMMC application uses a comprehensive model system to handle data structures for both requests and responses. Models are generated using the `json_serializable` package for efficient JSON serialization and deserialization.


### Request Models
Located in `lib/domain/model/request/`, these models represent data sent to the API:


### Response Models
Located in `lib/domain/model/response/`, these models represent data received from the API:

## Model Generation

Models are automatically generated using the `json_serializable` package. The generation process creates `.g.dart` files with serialization/deserialization code.

### Generation Commands

To generate models, run the following command:
```bash
make -C lib/domain/model gen
```

To watch for changes and auto-generate:
```bash
make -C lib/domain/model watch
```

To clean generated files:
```bash
make -C lib/domain/model clean
```

To clean and regenerate:
```bash
make -C lib/domain/model regen
```

### Makefile Configuration

The Makefile in `lib/domain/model/` contains specific build filters to only process request/response models:

```makefile
# Generate json_serializable code for request/response models only
gen:
	flutter pub run build_runner build --delete-conflicting-outputs --build-filter lib/domain/model/**.g.dart --build-filter lib/domain/model/request/**.g.dart --build-filter lib/domain/model/response/**.g.dart

# Watch for changes and auto-generate for request/response models only
watch:
	flutter pub run build_runner watch --delete-conflicting-outputs --build-filter lib/domain/model/**.g.dart --build-filter lib/domain/model/request/**.g.dart --build-filter lib/domain/model/response/**.g.dart
```

## Model Structure

Each model follows the json_serializable pattern:

```dart
import 'package:json_annotation/json_annotation.dart';

part 'model_name.g.dart';

@JsonSerializable()
class ModelName {
  // Fields with appropriate types
  
  ModelName({
    required this.field,
  });
  
  factory ModelName.fromJson(Map<String, dynamic> json) => _$ModelNameFromJson(json);
  
  Map<String, dynamic> toJson() => _$ModelNameToJson(this);
}
```

## Usage

Models are used throughout the application in:
- Service layer for API communication
- BLoC layer for state management
- UI layer for data presentation

## Dependencies

The model generation depends on:
- `json_annotation` - For serialization annotations
- `json_serializable` - For code generation
- `build_runner` - For build automation

These are defined in the `pubspec.yaml` file.
