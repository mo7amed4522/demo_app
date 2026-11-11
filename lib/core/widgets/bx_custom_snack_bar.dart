// File: lib/core/widgets/bx_custom_snack_bar.dart
// Architecture: Core Layer - Bx Custom Snack Bar
// Purpose: Custom snack bar with logo support for dark/light themes

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/constant/bx_app_constant.dart';
import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum BxSnackBarType { success, warning, error, info }

class BxCustomSnackBar {
  // Show custom snack bar
  static void show({
    required BuildContext context,
    required String message,
    required BxSnackBarType type,
    String? title,
    Widget? logo,
    String? buttonText,
    VoidCallback? onButtonPressed,
    Duration duration = const Duration(seconds: 4),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: BxSnackBarContent(
          message: message,
          type: type,
          title: title,
          logo: logo,
          buttonText: buttonText,
          onButtonPressed: onButtonPressed,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: duration,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
    );
  }

  // Convenience methods
  static void success({
    required BuildContext context,
    String? title,
    required String message,
    Widget? logo,
    String? buttonText,
    VoidCallback? onButtonPressed,
  }) {
    show(
      title: title,
      context: context,
      message: message,
      type: BxSnackBarType.success,
      logo: logo,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
    );
  }

  static void warning({
    required BuildContext context,
    String? title,
    required String message,
    Widget? logo,
    String? buttonText,
    VoidCallback? onButtonPressed,
  }) {
    show(
      title: title,
      context: context,
      message: message,
      type: BxSnackBarType.warning,
      logo: logo,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
    );
  }

  static void error({
    required BuildContext context,
    String? title,
    required String message,
    Widget? logo,
    String? buttonText,
    VoidCallback? onButtonPressed,
  }) {
    show(
      context: context,
      title: title,
      message: message,
      type: BxSnackBarType.error,
      logo: logo,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
    );
  }

  static void info({
    required BuildContext context,
    String? title,
    required String message,
    Widget? logo,
    String? buttonText,
    VoidCallback? onButtonPressed,
  }) {
    show(
      title: title,
      context: context,
      message: message,
      type: BxSnackBarType.info,
      logo: logo,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
    );
  }
}

// Custom snack bar content widget
class BxSnackBarContent extends StatelessWidget {
  final String message;
  final BxSnackBarType type;
  final String? title;
  final Widget? logo;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const BxSnackBarContent({
    super.key,
    required this.message,
    required this.type,
    this.title,
    this.logo,
    this.buttonText,
    this.onButtonPressed,
  });

  Color _getBorderColor(BuildContext context) {
    switch (type) {
      case BxSnackBarType.success:
        return BxAppColors.success;
      case BxSnackBarType.warning:
        return BxAppColors.warning;
      case BxSnackBarType.error:
        return BxAppColors.error;
      case BxSnackBarType.info:
        return BxAppColors.info;
    }
  }

  Color _getTextColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    switch (type) {
      case BxSnackBarType.success:
        return isDarkMode ? BxAppColors.success : BxAppColors.success;
      case BxSnackBarType.warning:
        return isDarkMode ? BxAppColors.warning : BxAppColors.warning;
      case BxSnackBarType.error:
        return isDarkMode ? BxAppColors.error : BxAppColors.error;
      case BxSnackBarType.info:
        return isDarkMode ? BxAppColors.info : BxAppColors.info;
    }
  }

  IconData _getIcon() {
    switch (type) {
      case BxSnackBarType.success:
        return Icons.check_circle_outline;
      case BxSnackBarType.warning:
        return Icons.warning_amber_outlined;
      case BxSnackBarType.error:
        return Icons.error_outline;
      case BxSnackBarType.info:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? BxAppColors.darkSurface
        : BxAppColors.surface;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: _getBorderColor(context).withOpacity(0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Colorful accent bar at the top
            Container(height: 4.h, color: _getBorderColor(context)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo Section
                  if (logo != null)
                    Container(
                      margin: EdgeInsets.only(right: 12.w),
                      child: SizedBox(width: 32.w, height: 32.w, child: logo),
                    ),

                  // Icon Section (if no logo)
                  if (logo == null)
                    Container(
                      margin: EdgeInsets.only(right: 12.w),
                      child: Icon(
                        _getIcon(),
                        color: _getTextColor(context),
                        size: 24.sp,
                      ),
                    ),
                  SizedBox(width: 4.w),
                  // Message Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title == null ? _getTypeTitle(context) : title!,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _getTextColor(context),
                            letterSpacing: 0.5,
                            fontFamily: BxAppFonts.bxAppFonts,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          message,
                          style: TextStyle(
                            fontSize: 13,
                            color: isDarkMode
                                ? BxAppColors.darkOnBackground
                                : BxAppColors.onBackground,
                            height: 1.4,
                            fontFamily: BxAppFonts.bxAppFonts,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Action Button Section
                  if (buttonText != null && onButtonPressed != null)
                    TextButton(
                      onPressed: onButtonPressed,
                      style: TextButton.styleFrom(
                        foregroundColor: _getTextColor(context),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        buttonText!,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: BxAppFonts.bxAppFonts,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTypeTitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case BxSnackBarType.success:
        return l10n.success;
      case BxSnackBarType.warning:
        return l10n.warning;
      case BxSnackBarType.error:
        return l10n.error;
      case BxSnackBarType.info:
        return l10n.info;
    }
  }
}

// Optional: Animated snack bar with sliding effect
class BxAnimatedSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    required BxSnackBarType type,
    Widget? logo,
    String? buttonText,
    VoidCallback? onButtonPressed,
    Duration duration = const Duration(seconds: 4),
  }) {
    final overlay = Overlay.of(context);

    // Declare overlayEntry first
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _AnimatedSnackBarOverlay(
        message: message,
        type: type,
        logo: logo,
        buttonText: buttonText,
        onButtonPressed: onButtonPressed,
        duration: duration,
        onDismiss: () => overlayEntry.remove(),
      ),
    );

    overlay.insert(overlayEntry);
  }
}

class _AnimatedSnackBarOverlay extends StatefulWidget {
  final String message;
  final BxSnackBarType type;
  final Widget? logo;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final Duration duration;
  final VoidCallback onDismiss;

  const _AnimatedSnackBarOverlay({
    required this.message,
    required this.type,
    this.logo,
    this.buttonText,
    this.onButtonPressed,
    required this.duration,
    required this.onDismiss,
  });

  @override
  State<_AnimatedSnackBarOverlay> createState() =>
      _AnimatedSnackBarOverlayState();
}

class _AnimatedSnackBarOverlayState extends State<_AnimatedSnackBarOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse().then((_) => widget.onDismiss());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16.h,
      left: 16.w,
      right: 16.w,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Material(
            color: Colors.transparent,
            child: BxSnackBarContent(
              message: widget.message,
              type: widget.type,
              logo: widget.logo,
              buttonText: widget.buttonText,
              onButtonPressed: widget.onButtonPressed,
            ),
          ),
        ),
      ),
    );
  }
}
