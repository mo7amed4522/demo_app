// File: lib/core/widgets/bx_loading_app.dart
// Architecture: Core Layer - Bx Custom Loading
// Purpose: Custom Loading support for dark/light themes

// ignore_for_file: use_build_context_synchronously

import 'package:demo_app/core/constant/bx_app_constant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BxLoadingApp {
  BxLoadingApp._();
  static Widget lottieWidget() {
    return Center(
      child: Lottie.asset(BxAppConstant.loadingIcon, height: 100, width: 100),
    );
  }
}
