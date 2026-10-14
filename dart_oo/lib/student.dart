/// 学生：课程成绩册中的一条记录。
///
/// 覆盖指南 2.1 要求：字段封装、命名构造函数 fromJson、带校验的 setter。
class Student {
  final String id;
  final String name;
  double _score; // 私有：下划线前缀

  /// 位置参数构造，分数可省略（默认 0）。
  Student(this.id, this.name, [this._score = 0]);

  /// 命名构造函数：从 Map/JSON 造对象的标准入口。
  Student.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        _score = (json['score'] as num).toDouble();

  /// getter：只读暴露分数。
  double get score => _score;

  /// setter：写入前校验分数区间，越界抛 ArgumentError。
  set score(double v) {
    if (v < 0 || v > 100) throw ArgumentError('分数越界');
    _score = v;
  }

  /// 是否及格。
  bool get passed => _score >= 60;

  @override
  String toString() => 'Student($id, $name, ${_score.toStringAsFixed(1)})';
}
