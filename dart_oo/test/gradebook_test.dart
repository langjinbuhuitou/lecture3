import 'package:dart_oo/gradebook.dart';
import 'package:dart_oo/student.dart';
import 'package:test/test.dart';

void main() {
  group('GradeBook 统计', () {
    final book = GradeBook([
      Student('01', '李华', 92),
      Student('02', '王芳', 55),
      Student('03', '张伟', 78),
      Student.fromJson(
          <String, dynamic>{'id': '04', 'name': '赵敏', 'score': 88.5}),
    ]);

    test('正常数据统计正确', () {
      expect(book.average, closeTo(78.375, 1e-9));
      expect(book.maxBy().name, '李华');
      expect(book.countPassed(), 3);
      expect(
        book.groupByGrade()['优']!.map((s) => s.name),
        containsAll(<String>['李华', '赵敏']),
      );
      expect(book.groupByGrade()['不及格']!.single.name, '王芳');
    });

    test('越界分数抛出 ArgumentError', () {
      final s = Student('09', '越界', 60);
      expect(() => s.score = 101, throwsA(isA<ArgumentError>()));
      expect(() => s.score = -1, throwsA(isA<ArgumentError>()));
      // 校验失败后原值保持不变
      expect(s.score, 60);
    });

    test('命名构造函数 fromJson 正确解析', () {
      final s = Student.fromJson(
          <String, dynamic>{'id': '07', 'name': '测试', 'score': 71.5});
      expect(s.id, '07');
      expect(s.name, '测试');
      expect(s.score, 71.5);
      expect(s.passed, isTrue);
    });
  });
}
