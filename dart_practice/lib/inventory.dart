import 'book.dart';
import 'loggable.dart';

/// 库存：持有一批图书，提供基于集合链式方法的一组统计。
///
/// 自主实践要求 2：混入 [Loggable] 复用日志能力（替代原先的继承写法）。
/// 自主实践要求 3：统计全部由集合链式方法组合完成，无手写 for 循环。
class Inventory with Loggable {
  final List<Book> books;

  Inventory(this.books);

  /// 库存总价值：map 取价值 + fold 求和。
  double get totalValue =>
      books.map((b) => b.value).fold<double>(0, (sum, v) => sum + v);

  /// 平均单价：map 取单价 + fold 求和，再除以本数。
  double get averagePrice => books.isEmpty
      ? 0
      : books.map((b) => b.price).fold<double>(0, (sum, p) => sum + p) /
          books.length;

  /// 是否全部有货：every 判定。
  bool get allInStock => books.every((b) => b.quantity > 0);

  /// 是否存在缺货：any 判定。
  bool get hasOutOfStock => books.any((b) => b.quantity == 0);

  /// 分类集合：map 取分类 + toSet 去重。
  Set<String> get categories => books.map((b) => b.category).toSet();

  /// 价值最高的图书：reduce 一次遍历取得。
  Book? topByValue() =>
      books.isEmpty ? null : books.reduce((a, b) => a.value >= b.value ? a : b);

  /// 各分类库存价值：fold 归组成 Map<分类, 价值>。
  Map<String, double> valueByCategory() => books.fold(
        <String, double>{},
        (acc, b) =>
            acc..update(b.category, (v) => v + b.value, ifAbsent: () => b.value),
      );

  /// 缺货书名清单：在副本上 where 筛选 + map 取书名 + toList。
  List<String> outOfStockTitles() => [...books]
      .where((b) => b.quantity == 0)
      .map((b) => b.title)
      .toList();

  /// 按库存价值降序的书名：复制原列表后 sort + map + toList，不动原列表。
  List<String> titlesByValueDesc() {
    final sorted = [...books]..sort((a, b) => b.value.compareTo(a.value));
    return sorted.map((b) => b.title).toList();
  }

  /// 按 id 查找：firstWhere + orElse，找不到抛 StateError。
  Book findById(String id) => books.firstWhere(
        (b) => b.id == id,
        orElse: () => throw StateError('未找到图书 $id'),
      );
}
