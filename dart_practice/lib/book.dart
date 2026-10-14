/// 图书：库存管理中的一种商品。
///
/// 覆盖自主实践要求 1（类设计合理性）：字段封装、命名构造函数、校验 setter。
class Book {
  final String id;
  final String title;
  final String category;
  double _price; // 单价（元），私有
  int _quantity; // 库存数量，私有

  Book(this.id, this.title, this.category, this._price, this._quantity);

  /// 命名构造函数：从 Map/JSON 造对象。
  Book.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        category = map['category'],
        _price = (map['price'] as num).toDouble(),
        _quantity = (map['quantity'] as num).toInt();

  double get price => _price;

  /// setter 带校验：单价必须落在 [0, 9999]。
  set price(double v) {
    if (v < 0 || v > 9999) throw ArgumentError('单价越界: $v');
    _price = v;
  }

  int get quantity => _quantity;

  /// setter 带校验：库存不能为负。
  set quantity(int v) {
    if (v < 0) throw ArgumentError('库存不能为负: $v');
    _quantity = v;
  }

  /// 该图书占用的库存价值。
  double get value => _price * _quantity;

  @override
  String toString() =>
      'Book($id, $title, ${_price.toStringAsFixed(1)}元, x$_quantity)';
}
