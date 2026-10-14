import 'logger.dart';
import 'student.dart';

/// 课程成绩册：内部持有一个学生列表，构造时接收。
///
/// 混入 [Logger] 获得日志能力（第 3 步：mixin）。
class GradeBook with Logger {
  final List<Student> students;

  GradeBook(this.students);

  /// 平均分：fold 聚合求和后再除以人数；空册返回 0。
  double get average {
    if (students.isEmpty) {
      log('average -> 0（空成绩册）');
      return 0;
    }
    final avg =
        students.fold<double>(0, (sum, s) => sum + s.score) / students.length;
    log('average -> ${avg.toStringAsFixed(2)}');
    return avg;
  }

  /// 最高分学生：reduce 一次遍历取分数最大者。
  Student maxBy() {
    final top = students.reduce((a, b) => a.score >= b.score ? a : b);
    log('maxBy -> ${top.name}(${top.score})');
    return top;
  }

  /// 及格人数：where 筛选出及格者再计数。
  int countPassed() {
    final n = students.where((s) => s.passed).length;
    log('countPassed -> $n');
    return n;
  }

  /// 按档位分组：fold 归组成 Map<档位, 学生列表>。
  ///
  /// 档位：优(>=85)、良(>=70)、中(>=60)、不及格(<60)。
  Map<String, List<Student>> groupByGrade() {
    final result = students.fold(
      <String, List<Student>>{},
      (acc, s) => acc..putIfAbsent(_gradeOf(s.score), () => <Student>[]).add(s),
    );
    log('groupByGrade -> ${result.keys.join('/')}');
    return result;
  }

  /// 分数到档位标签的映射。
  static String _gradeOf(double score) {
    if (score >= 85) return '优';
    if (score >= 70) return '良';
    if (score >= 60) return '中';
    return '不及格';
  }
}
