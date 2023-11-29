import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

/// Breakpoints to check if we are on mobile or tablet
class CustomBreakpoints extends Breakpoints {
  /// A window whose width is between 0 dp and 840 dp.
  static const Breakpoint mobileAndTablet =
      WidthPlatformBreakpoint(begin: 0, end: 840);
}
