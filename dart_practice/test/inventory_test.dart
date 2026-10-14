import 'package:dart_practice/book.dart';
import 'package:dart_practice/inventory.dart';
import 'package:test/test.dart';

void main() {
  group('Inventory 统计', () {
    final inventory = Inventory([
      Book('B01', 'Dart 语言入门', '编程', 59.0, 3),
      Book('B02', 'Flutter 实战', '编程', 89.0, 0),
      Book('B03', '三体', '小说', 45.5, 5),
      Book('B04', '活着', '小说', 32.0, 2),
    ]);

    test('正常数据统计正确', () {
      // 59*3 + 89*0 + 45.5*5 + 32*2 = 177 + 0 + 227.5 + 64 = 468.5
      expect(inventory.totalValue, closeTo(468.5, 1e-9));
      expect(inventory.categories, unorderedEquals(<String>['编程', '小说']));
      expect(inventory.allInStock, isFalse);
      expect(inventory.hasOutOfStock, isTrue);
      expect(inventory.topByValue()!.id, 'B03');
      expect(inventory.outOfStockTitles(), <String>['Flutter 实战']);
      expect(inventory.titlesByValueDesc().first, '三体');
    });

    test('非法单价与负库存抛出 ArgumentError', () {
      final b = Book('X', 'X', 'X', 10, 1);
      expect(() => b.price = -1, throwsA(isA<ArgumentError>()));
      expect(() => b.price = 10000, throwsA(isA<ArgumentError>()));
      expect(() => b.quantity = -1, throwsA(isA<ArgumentError>()));
      // 校验失败后原值保持不变
      expect(b.price, 10);
      expect(b.quantity, 1);
    });

    test('findById 未命中抛出 StateError', () {
      expect(inventory.findById('B01').title, 'Dart 语言入门');
      expect(() => inventory.findById('NOPE'), throwsA(isA<StateError>()));
    });
  });
}
