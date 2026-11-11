# demo_app Build Makefile
# Provides target for generating localization files

.PHONY: help
help: ## Display this help message
	@echo "demo_app Build System"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  help                    Show this help message"
	@echo "  l10n                    Generate localization files from ARB"
	@echo ""

.PHONY: l10n
l10n: ## Generate localization files from ARB
	@echo "Generating localization files..."
	@if [ ! -d "lib/l10n/arb" ]; then \
		echo "ERROR: lib/l10n/arb directory not found"; \
		exit 1; \
	fi
	@if [ -z "$$(ls -A lib/l10n/arb/*.arb 2>/dev/null)" ]; then \
		echo "ERROR: No .arb files found in lib/l10n/arb/"; \
		exit 1; \
	fi
	flutter gen-l10n \
		--arb-dir=lib/l10n/arb \
		--output-dir=lib/l10n/generated \
		--template-arb-file=app_ar.arb \
		--output-localization-file=app_localizations.dart
	@echo "✓ Localization files generated in lib/l10n/generated/"

# Default target
all: l10n