.PHONY: gen clean watch

# Generate json_serializable code for request/response models only
gen:
	flutter pub run build_runner build --delete-conflicting-outputs --build-filter lib/domain/model**.g.dart --build-filter lib/domain/modelrequest/**.g.dart --build-filter lib/domain/modelresponse/**.g.dart

# Watch for changes and auto-generate for request/response models only
watch:
	flutter pub run build_runner watch --delete-conflicting-outputs --build-filter lib/domain/model**.g.dart --build-filter lib/domain/modelrequest/**.g.dart --build-filter lib/domain/modelresponse/**.g.dart

# Clean generated files
clean:
	flutter pub run build_runner clean
	dart run build_runner clean

# Full clean + generate
regen: clean gen
