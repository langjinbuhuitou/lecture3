import 'package:dart_practice/book.dart';
import 'package:dart_practice/inventory.dart';

void main(List<String> arguments) {
  final inventory = Inventory([
    Book('B01', 'Dart 语言入门', '编程', 59.0, 3),
    Book('B02', 'Flutter 实战', '编程', 89.0, 0),
    // 命名构造函数：从 Map/JSON 造对象
    Book.fromMap(<String, dynamic>{
      'id': 'B03',
      'title': '三体',
      'category': '小说',
      'price': 45.5,
      'quantity': 5,
    }),
    Book('B04', '活着', '小说', 32.0, 2),
  ]);

  print('===== 图书库存统计 =====');
  print('库存总价值: ${inventory.totalValue.toStringAsFixed(2)} 元');
  print('平均单价: ${inventory.averagePrice.toStringAsFixed(2)} 元');
  print('分类: ${inventory.categories.join('、')}');
  print('全部有货: ${inventory.allInStock}；存在缺货: ${inventory.hasOutOfStock}');
  print('价值最高: ${inventory.topByValue()}');
  print('缺货清单: ${inventory.outOfStockTitles()}');
  print('按价值降序: ${inventory.titlesByValueDesc().join('、')}');
  print('分类价值: ${inventory.valueByCategory()}');
}
