/// Импортим IO для сохранения скриншотов в файлы
import 'dart:io';

/// Сам flutter driver
import 'package:flutter_driver/flutter_driver.dart';

/// Тесты, ассерты и тд.
import 'package:test/test.dart';

void main() {
  /// Создаем группу тестов - Test suite
  group(
    'Test App',
        () {
      /// Инстанс driver
      FlutterDriver driver;

      setUpAll(() async {
        /// Подключаем driver к запушенному приложению
        driver = await FlutterDriver.connect();

        /// Создаем пааку для скриншотов
        new Directory('Screenshots').create();
      });

      tearDownAll(() async {
        if (driver != null) {
          /// Не забываем выключать за собой драйвер
          driver.close();
        }
      });

      /// Скриншоты
      takeScreenshot(FlutterDriver driver, String path) async {
        final List<int> pixels = await driver.screenshot();
        final File file = File(path);
        await file.writeAsBytes(pixels);
        print(path);
      }

      /// Первый делом перед запуском тестов проверяем состояние драйвера
      test('Check driver health', () async {
        Health health = await driver.checkHealth();
        print(health.status);
        assert(health.status == HealthStatus.ok);
      });

      /// Test suite
      test(
        'Main page tests',
            () async {
          /// Тап по UI елементу, перевединия фокуса на него. Найдет по ключу
          await driver.tap(find.byValueKey('inputKeyString'));

          /// Простой ввод текста
          await driver.enterText('Hello !');

          /// Поиск элемента по тексту. Проверяем успешный ввод
          await driver.waitFor(find.text('Hello !'));

          /// Деалем первый скриншот
          await takeScreenshot(driver, 'screenshots/entered_text.png');

          /// Вводим другой текст. Предыдущий стирается
          await driver.enterText('World');

          /// Проверяем ОТСУТСТВИЕ старого текста
          await driver.waitForAbsent(find.text('Hello !'));

          /// Еще один скриншот
          await takeScreenshot(driver, 'screenshots/new_text.png');
          print('World');

          /// Находим кнопку по ключу
          await driver.waitFor(find.byValueKey('button'));

          /// Жмем кнопку
          await driver.tap(find.byValueKey('button'));
          print('Button clicked');

          /// Находим текст по ключу
          await driver.waitFor(find.byValueKey('text'));

          /// подскролливаем родительский элемент
          /// так чтоб искомый был виден и переводим фокус на него
          await driver.scrollIntoView(find.byValueKey('text'));

          /// Проверяем наличие текста
          await driver.waitFor(find.text('Scroll till here'));
          print('I found you buddy !');
        },
      );
    },
  );
}
