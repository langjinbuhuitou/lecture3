import 'package:dart_oo/gradebook.dart';
import 'package:dart_oo/student.dart';

void main(List<String> arguments) {
  final book = GradeBook([
    Student('01', '李华', 92),
    Student('02', '王芳', 55),
    Student('03', '张伟', 78),
    // 命名构造函数：从 Map/JSON 造对象
    Student.fromJson(<String, dynamic>{'id': '04', 'name': '赵敏', 'score': 88.5}),
  ]);

  print('===== 课程成绩册统计 =====');
  print('平均分: ${book.average.toStringAsFixed(2)}');
  print('最高分学生: ${book.maxBy()}');
  print('及格人数: ${book.countPassed()} / ${book.students.length}');
  print('分档结果:');
  book.groupByGrade().forEach((grade, list) {
    print('  $grade: ${list.map((s) => s.name).join(', ')}');
  });
}
