/// Custom in‑app notification widgets styled with a glass‑morphism effect,
/// plus a [NotificationHelper] that displays them as overlay entries.
///
/// The main widget [BxCustomNotificationWidget] is a visually rich, full‑width
/// notification banner with a blurred backdrop, gradient overlay, and an
/// optional dismiss button. A compact variant [CompactNotificationWidget] is
/// also provided for less intrusive alerts.
///
/// [NotificationHelper] offers a static API to show / dismiss these widgets
/// as root‑level overlays, with automatic timeout and convenience methods
/// for high‑priority or compact notifications.
///
/// Architecture: Clean Architecture
/// Layer: Core
/// Core: Constant
///
/// File: lib/core/constant/bx_custom_notification_widget.dart
library;

// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:demo_app/core/constant/bx_app_constant.dart';
import 'package:flutter/material.dart';

/// Priority level of a notification, used to control visual indicators
/// (e.g. a red dot) and display duration.
enum NotificationPriority { high, normal, low }

/// A full‑width notification banner with a glass‑morphism design.
///
/// The widget uses a semi‑transparent blur effect (backdrop filter) and a
/// primary‑colour gradient. It displays a title, message, and an optional
/// leading icon or network image. A high‑priority notification adds a red
/// indicator dot. An optional dismiss button triggers [onDismiss].
///
/// Tapping the entire widget invokes [onTap].
class BxCustomNotificationWidget extends StatelessWidget {
  /// The bold title shown at the top of the notification.
  final String title;

  /// The descriptive body text of the notification.
  final String message;

  /// Controls the priority appearance and default display duration.
  final NotificationPriority priority;

  /// Called when the notification body is tapped.
  final VoidCallback? onTap;

  /// Called when the dismiss button (X icon) is tapped.
  final VoidCallback? onDismiss;

  /// An optional network image to use as a leading icon.
  final String? imageUrl;

  /// An optional widget to replace the default leading icon.
  final Widget? leadingIcon;

  const BxCustomNotificationWidget({
    super.key,
    required this.title,
    required this.message,
    this.priority = NotificationPriority.normal,
    this.onTap,
    this.onDismiss,
    this.imageUrl,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 15,
              sigmaX: 15,
              tileMode: TileMode.clamp,
            ),
            child: Stack(
              children: [
                // Background with enhanced gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).primaryColor.withOpacity(0.95),
                        Theme.of(context).primaryColor.withOpacity(0.85),
                        Theme.of(context).primaryColor.withOpacity(0.75),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),

                // Enhanced glass morphs effect with better shine
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.25),
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.05),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                // Content with improved padding
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Leading Icon/Image
                      _buildLeadingWidget(context),

                      SizedBox(width: 12),

                      // Title and Message
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Title with priority indicator
                            Row(
                              children: [
                                if (priority == NotificationPriority.high)
                                  Container(
                                    width: 8,
                                    height: 8,
                                    margin: EdgeInsets.only(right: 6),
                                    decoration: const BoxDecoration(
                                      color: Colors.redAccent,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                Expanded(
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.none,
                                      decorationColor: Colors.transparent,
                                      letterSpacing: 0.3,
                                      height: 1.2,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.3),
                                          offset: const Offset(0, 1),
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 8),

                            Text(
                              message,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.98),
                                fontSize: 14.5,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                decoration: TextDecoration.none,
                                decorationColor: Colors.transparent,
                                letterSpacing: 0.2,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: const Offset(0, 1),
                                    blurRadius: 1,
                                  ),
                                ],
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 8),

                      // Enhanced Dismiss Button
                      if (onDismiss != null)
                        GestureDetector(
                          onTap: onDismiss,
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Enhanced ripple effect on tap
                if (onTap != null)
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onTap,
                        borderRadius: BorderRadius.circular(16),
                        splashColor: Colors.white.withOpacity(0.25),
                        highlightColor: Colors.white.withOpacity(0.15),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the leading widget based on [leadingIcon] or [imageUrl].
  /// Falls back to a default app logo icon if neither is provided.
  Widget _buildLeadingWidget(BuildContext context) {
    if (leadingIcon != null) {
      return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: leadingIcon,
      );
    }

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.network(
            imageUrl!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                _buildDefaultIcon(context),
          ),
        ),
      );
    }

    return _buildDefaultIcon(context);
  }

  /// Returns the default leading icon – the app logo in a white circle.
  Widget _buildDefaultIcon(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Image.asset(
        BxAppConstant.appLogo,
        color: Colors.white,
        width: 26,
        height: 26,
      ),
    );
  }
}

/// A more compact in‑app notification banner with a subtle gradient
/// background, ideal for less important messages or smaller screen spaces.
///
/// It shows a small bell icon, a single‑line title and message, and an
/// optional dismiss button.
class CompactNotificationWidget extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;

  const CompactNotificationWidget({
    super.key,
    required this.title,
    required this.message,
    this.onTap,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.7),
              Theme.of(context).primaryColor.withOpacity(0.5),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_active,
                color: Colors.white,
                size: 18,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2),
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                      decoration: TextDecoration.none,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (onDismiss != null)
              GestureDetector(
                onTap: onDismiss,
                child: Icon(
                  Icons.close,
                  color: Colors.white.withOpacity(0.7),
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Static helper for displaying and dismissing custom in‑app notification
/// overlays using [BxCustomNotificationWidget] or [CompactNotificationWidget].
///
/// Notifications are shown as root‑level overlays positioned at the top of
/// the screen. Only one notification is displayed at a time; calling [show]
/// again will dismiss the current one before showing the new one.
///
/// Example:
/// ```dart
/// NotificationHelper.show(
///   context: context,
///   title: 'Success',
///   message: 'Your profile has been updated.',
/// );
/// ```
class NotificationHelper {
  static OverlayEntry? _currentOverlay;

  /// Shows a notification overlay.
  ///
  /// If a notification is already visible, it is dismissed first.
  /// The notification will auto‑dismiss after [duration] (default 4s).
  ///
  /// Parameters:
  /// - [context]: required to access the [Overlay].
  /// - [title], [message]: the text content.
  /// - [priority]: controls the red dot and (indirectly) the default duration.
  /// - [onTap]: callback when the notification is tapped.
  /// - [imageUrl] / [leadingIcon]: custom leading widget.
  /// - [duration]: how long the notification stays visible.
  /// - [compact]: if true, uses [CompactNotificationWidget] instead of the
  ///   default full‑size widget.
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    NotificationPriority priority = NotificationPriority.normal,
    VoidCallback? onTap,
    String? imageUrl,
    Widget? leadingIcon,
    Duration duration = const Duration(seconds: 4),
    bool compact = false,
  }) {
    // Remove existing notification if any
    dismiss();

    // Wait for the next frame to ensure overlay is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        // Find the overlay using the context
        final overlayState = Overlay.of(context, rootOverlay: true);

        late OverlayEntry overlayEntry;

        overlayEntry = OverlayEntry(
          builder: (overlayContext) => Positioned(
            top: MediaQuery.of(overlayContext).padding.top + 16,
            left: 0,
            right: 0,
            child: Material(
              color: Colors.transparent,
              elevation: 0,
              child: compact
                  ? CompactNotificationWidget(
                      title: title,
                      message: message,
                      onTap: () {
                        dismiss();
                        onTap?.call();
                      },
                      onDismiss: dismiss,
                    )
                  : BxCustomNotificationWidget(
                      title: title,
                      message: message,
                      priority: priority,
                      imageUrl: imageUrl,
                      leadingIcon: leadingIcon,
                      onTap: () {
                        dismiss();
                        onTap?.call();
                      },
                      onDismiss: dismiss,
                    ),
            ),
          ),
        );

        _currentOverlay = overlayEntry;
        overlayState.insert(overlayEntry);

        // Auto dismiss after duration
        Future.delayed(duration, () {
          if (_currentOverlay == overlayEntry) {
            dismiss();
          }
        });
      } catch (e) {
        // If overlay is not available, silently fail
        // The system notification will still be shown
        debugPrint('Failed to show custom notification overlay: $e');
      }
    });
  }

  /// Dismisses the currently visible notification overlay, if any.
  static void dismiss() {
    _currentOverlay?.remove();
    _currentOverlay = null;
  }

  /// Convenience method to show a high‑priority notification.
  ///
  /// Uses [NotificationPriority.high] and a 6‑second display duration.
  static void showHighPriority({
    required BuildContext context,
    required String title,
    required String message,
    VoidCallback? onTap,
    String? imageUrl,
  }) {
    show(
      context: context,
      title: title,
      message: message,
      priority: NotificationPriority.high,
      onTap: onTap,
      imageUrl: imageUrl,
      duration: const Duration(seconds: 6),
    );
  }

  /// Convenience method to show a compact notification.
  ///
  /// The overlay uses [CompactNotificationWidget] and a 3‑second duration.
  static void showCompact({
    required BuildContext context,
    required String title,
    required String message,
    VoidCallback? onTap,
  }) {
    show(
      context: context,
      title: title,
      message: message,
      onTap: onTap,
      compact: true,
      duration: const Duration(seconds: 3),
    );
  }
}
