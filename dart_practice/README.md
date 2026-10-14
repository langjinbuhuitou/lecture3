# dart_practice

第 5 周课堂作业三「自主实践基本要求」的独立项目：一个简单的图书库存管理程序。

## 覆盖的基本要求

| 序号 | 要求 | 实现位置 |
| --- | --- | --- |
| 1 | 类设计合理性（字段封装、命名构造、校验 setter） | `lib/book.dart` |
| 2 | mixin 改造：用混入替代一层继承 | `lib/loggable.dart`、`lib/inventory.dart` |
| 3 | 集合统计链（≥5 个链式方法组合） | `lib/inventory.dart` |
| 4 | 单元测试（≥2 个用例，正常 + 异常） | `test/inventory_test.dart` |
| 5 | AI 使用标注 | 见仓库根目录 `progress.md` 第七节 |

## 关于 mixin 改造

改造前 `Inventory` 通过 `extends LoggerBase` 继承获得日志能力。问题是：

- “写日志”是横切能力，库存与日志之间不是「是一种（is-a）」关系，用继承语义不对；
- Dart 类只能继承一个父类，日志占了这个名额，将来若要继承别的基类就没有位置。

改造后改为 `class Inventory with Loggable`，复用同一份 `log` 实现，且不占用继承名额、语义也更准确。

## 运行

```bash
dart pub get
dart run bin/dart_practice.dart
dart test
```

## 集合统计链用到的链式方法

`map`、`fold`、`every`、`any`、`toSet`、`reduce`、`where`、`toList`、`firstWhere`、`sort`、`update`——共 11 个，全部无手写 `for` 循环。
