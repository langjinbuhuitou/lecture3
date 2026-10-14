import 'package:dart_oo/gradebook.dart';
import 'package:dart_oo/student.dart';

void main(List<String> arguments) {
  final book = GradeBook([
    Student('01', '李华', 92),
    Student('02', '王芳', 55),
    Student('03', '张伟', 78),
  ]);

  print('已载入 ${book.students.length} 名学生：');
  book.students.forEach(print);
}
