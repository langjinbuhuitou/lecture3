# lecture3

第 5 周《Dart 语言基础二：面向对象与集合》课堂作业三的代码仓库。

本仓库包含两个相互独立的项目，分别对应本次作业的两项任务：

| 目录 | 任务 | 说明 |
| --- | --- | --- |
| `dart_oo/` | 案例复现 | 严格按实践指南《学生实践指南三》第五章复现课堂案例 `dart_oo`（课程成绩册统计） |
| `dart_practice/` | 自主实践 | 独立完成的图书库存管理小项目，覆盖类设计、mixin 改造、集合统计链与单元测试 |

## 运行环境

- Dart SDK 3.13.4（stable，windows_x64）

## 运行方式

```bash
# 案例复现
cd dart_oo
dart pub get
dart run bin/dart_oo.dart
dart test

# 自主实践
cd dart_practice
dart pub get
dart run bin/dart_practice.dart
dart test
```

## 目录说明

- `progress.md`：本次作业进度报告正文（与雨课堂提交内容一致）。
- 本仓库只包含代码与文档，不含课堂发放的模板文档与运行截图。
