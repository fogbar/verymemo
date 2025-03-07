import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension ContextExtension on BuildContext {
  /// 1. [Navigation / Route]
  void pushNamed(
    String routeName, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
  }) {
    // Navigator.pushNamed(this, routeName, arguments: arguments);
    GoRouter.of(this).pushNamed(
      routeName,
      pathParameters: pathParameters ?? const <String, String>{},
      queryParameters: queryParameters ?? const <String, String>{},
    );
  }

  void pushReplacementNamed(
    String routeName, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
  }) {
    // Navigator.pushReplacementNamed(this, routeName, arguments: arguments);
    GoRouter.of(this).pushReplacementNamed(
      routeName,
      pathParameters: pathParameters ?? const <String, String>{},
      queryParameters: queryParameters ?? const <String, String>{},
    );
  }

  void poped([bool? result]) {
    if (GoRouter.of(this).canPop()) {
      GoRouter.of(this).pop(result ?? true);
    }
  }

  Uri get currentPath => GoRouter.of(this).routeInformationProvider.value.uri;

  /// 2. [Padding / Margin / Size]
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  Size get size => MediaQuery.of(this).size;

  /// 3. [Theme]
  ThemeData get theme => Theme.of(this);
  ColorScheme get scheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

  /// 4. snackbar
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String message, {
    Color? backgroundColor,
    int? seconds,
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: seconds ?? 3),
        showCloseIcon: true,
      ),
    );
  }

  void clearSnackBar() {
    ScaffoldMessenger.of(this).clearSnackBars();
  }

  /// 5. toast
  Future<bool?> showToast({
    required String message,
    Color? backgroundColor,
    ToastGravity? position,
  }) {
    return Fluttertoast.showToast(
      msg: message,
      backgroundColor: backgroundColor,
      toastLength: Toast.LENGTH_SHORT,
      gravity: position ?? ToastGravity.BOTTOM,
    );
  }
}
