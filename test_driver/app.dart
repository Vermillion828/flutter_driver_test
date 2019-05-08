/// Расширение driver
import 'package:flutter_driver/driver_extension.dart';

/// Main файл основной апки
import 'package:flutter_driver_test/main.dart' as app;

void main() {
  /// Включаем расширение driver
  enableFlutterDriverExtension();

  /// Запускаем основную апку
  app.main();
}
