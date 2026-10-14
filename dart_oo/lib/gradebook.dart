import 'student.dart';

/// 课程成绩册：内部持有一个学生列表，构造时接收。
class GradeBook {
  final List<Student> students;

  GradeBook(this.students);
}
