# 进度报告3（第5周·Dart语言基础二：面向对象与集合）

> 本文件为仓库内的进度报告正文；与雨课堂提交的报告内容一致。截图见提交文档，仓库中不存放截图。

## 一、任务理解

本次作业为第 5 周《Dart 语言基础二：面向对象与集合》课堂作业三，由三部分组成：

1. **案例复现**：严格按《学生实践指南三》第五章，分三步复现课堂案例 `dart_oo`（课程成绩册统计），要求代码与指南一致、可运行、按步骤 Git 提交。
2. **自主实践基本要求**：独立完成一个小项目，覆盖类设计（字段封装 / 命名构造 / 校验 setter）、mixin 改造（用混入替代一层继承并说明理由）、集合统计链（≥5 个链式方法）、`test` 包单元测试（≥2 个用例，覆盖正常与异常路径）、AI 使用标注。
3. **独立研究任务（选做）**：本次不完成。

验收标准（检查点）：

- `dart run` 统计输出正确；
- `dart test` 全部通过（案例复现 ≥2 个用例，自主实践 ≥2 个用例）；
- 代码按步骤 Git 提交到独立公开仓库 `lecture3`，含 README；
- 进度报告按模板十节填写，并存入仓库 `lecture3/progress.md`。

## 二、环境与工具

- 操作系统：Windows（windows_x64），屏幕 2560×1600。
- 开发环境：Dart SDK 3.13.4 (stable)；终端 Windows PowerShell 5 / cmd。
- 运行目标：Dart 控制台（CLI）程序（本课不涉及 Flutter Web / 模拟器 / 真机）。
- 版本控制：Git 2.55.0.windows.5；远程仓库 GitHub 公开仓库 `lecture3`。
- 依赖：`test` 包（单元测试）；项目由 `dart create -t console` 生成。
- AI 工具：TraeCode（Trae CN IDE 内置 AI 助手），用于辅助生成初稿与排查问题；AI 生成内容均经本人运行验证（详见第七、九节）。

## 三、过程记录

按时间线：

1. 环境确认：`dart --version` 输出 3.13.4；`git --version` 输出 2.55.0。
2. 建仓：新建 `lecture3` 目录并 `git init`（分支 main）。
3. **案例复现步骤一（建模）**：`dart create -t console dart_oo`；在 `lib/` 下新建 `student.dart`（Student：私有 `_score`、命名构造 `fromJson`、getter、带校验 setter、`passed`）与 `gradebook.dart`（GradeBook：持有 `List<Student>`）。`dart run bin/dart_oo.dart` 验证载入成功。提交 1 次。
4. **案例复现步骤二（统计）**：为 GradeBook 实现 `average`（fold 求和 / 长度）、`maxBy`（reduce 取最大）、`countPassed`（where + length）、`groupByGrade`（fold 归组成 Map），全部链式方法实现、无手写 `for`。`dart run` 输出平均分 78.38、最高分李华(92.0)、及格 3/4、分档正确。提交 1 次。
5. **案例复现步骤三（mixin 与测试）**：新增 `lib/logger.dart`（`mixin Logger`），`class GradeBook with Logger`；在 `test/` 新建 `gradebook_test.dart`（3 个用例：正常统计、越界抛 `ArgumentError`、`fromJson` 解析）。`dart test` 全绿。提交 1 次。
6. **自主实践**：`dart create -t console dart_practice`；新建 `lib/book.dart`（Book：私有 `price`/`quantity`、命名构造 `fromMap`、两个校验 setter）、`lib/loggable.dart`（`mixin Loggable`）、`lib/inventory.dart`（`Inventory with Loggable`，含集合统计方法）；`test/inventory_test.dart`（3 个用例）。`dart run`、`dart test` 验证通过。分 4 次提交。
7. **推送**：`git remote add origin https://github.com/langjinbuhuitou/lecture3.git`；因远程已有一次初始提交（`start.txt`），先 `git pull --rebase origin main` 将本地 8 次提交变基到远程之上，再 `git push -u origin main`，推送成功（`7247a55..24ed2db  main -> main`）。
8. 证据截图：运行输出、测试输出、Git 记录、仓库页面等整屏截图（含任务栏与右下角时间）。

仓库地址：https://github.com/langjinbuhuitou/lecture3

## 四、关键代码

### 代码一　集合统计链（`dart_oo/lib/gradebook.dart`）

```dart
double get average => students.isEmpty
    ? 0
    : students.fold<double>(0, (sum, s) => sum + s.score) / students.length;

Map<String, List<Student>> groupByGrade() => students.fold(
      <String, List<Student>>{},
      (acc, s) => acc..putIfAbsent(_gradeOf(s.score), () => <Student>[]).add(s),
    );
```

逐行解释：

- `average`：先判空（避免除以 0）；非空时用 `fold` 把每个学生分数累加进 `sum`（显式泛型 `<double>` 避免被推断为 int），再除以人数得到平均分。
- `groupByGrade`：以空 Map 为初始累加值，对每个学生用 `_gradeOf` 求档位，`putIfAbsent` 保证该档位的列表存在，再用级联 `..` 把学生加入列表并返回 Map 本身（级联返回接收者，是 `fold` 能连续累加的关键）。
- 是否 AI 生成：初稿由 TraeCode 生成；本人重点核对 `fold` 泛型与级联 `..` 的返回值语义，并用 `dart test` 断言平均分≈78.375 与分档归属，验证通过。

### 代码二　mixin 复用（`dart_oo/lib/logger.dart`、`gradebook.dart`）

```dart
mixin Logger {
  void log(String msg) => print('[$runtimeType] $msg');
}

class GradeBook with Logger { /* ... */ }
```

逐行解释：

- `mixin` 定义一段可被多个类复用的能力；`$runtimeType` 在运行时打印宿主类的真实类型名。
- `class ... with Logger` 把该能力线性混入 `GradeBook`，无需继承，`GradeBook` 内可直接调用 `log`。
- 是否 AI 生成：AI 辅助生成；验证方式：`dart run` 输出中每行日志前缀为 `[GradeBook]`，与预期一致。

### 代码三　封装的校验 setter（`dart_practice/lib/book.dart`）

```dart
set quantity(int v) {
  if (v < 0) throw ArgumentError('库存不能为负: $v');
  _quantity = v;
}
```

逐行解释：

- 私有字段 `_quantity` 只能经该 setter 修改；越界立即抛 `ArgumentError`，把错误挡在数据入口。
- 是否 AI 生成：AI 辅助生成；验证方式：`test` 中断言 `b.quantity = -1` 抛 `ArgumentError` 且原值不变，`dart test` 通过。

## 五、检查点结果

- **统计输出正确**：`dart_oo` 输出 —— 平均分 78.38、最高分学生 `Student(01, 李华, 92.0)`、及格人数 3/4、分档 优:李华,赵敏 / 良:张伟 / 不及格:王芳（图1）。
- **测试全部通过**：`dart_oo` 3 个用例全绿（图2）；`dart_practice` 3 个用例全绿（图4）。
- **Git 提交记录**：共 11 次提交（含远程初始提交 1 次），见（图5、图7）。

附证据说明：以上每一项均有整屏截图佐证，截图包含任务栏与右下角时间，见第八节。

## 六、问题与调试

**问题一：`git log` 分页器报错（真实记录）**

- 现象：在 cmd 中执行 `git log --oneline --graph --decorate`，终端报 `error: cannot spawn more: No such file or directory` / `fatal: unable to execute pager 'more'`，看不到提交历史。
- 定位：git 默认把输出交给分页器 `more`，而当前 Git 自带的 `more` 在 cmd 环境下无法启动（PATH / 环境问题），属分页器问题而非仓库故障。
- 解决：改用 `git --no-pager log --oneline --graph --decorate` 直接输出到终端；如需永久生效可执行 `git config --global core.pager ""`。之后成功打印出全部提交记录（图5）。

**问题二：`fold` 泛型推断导致类型不符**

- 现象：写成 `students.fold(0, (sum, s) => sum + s.score)` 时，累加器被推断为 `int`，与 `double` 分数相加类型不符。
- 定位：Dart 依据初始值 `0` 推断累加器类型为 `int`。
- 解决：改写成 `fold<double>(0, ...)`，显式指定泛型实参为 `double`，编译通过且精度正确。

## 七、AI 使用记录（TraeCode）

| 用途 | 指令摘要 | 输出 | 本人验证方式 |
| --- | --- | --- | --- |
| 复现案例骨架 | 按指南第五章实现 Student 与 GradeBook（命名构造 / 封装 / 校验 setter） | `lib/student.dart`、`lib/gradebook.dart` | 对照指南逐条核对字段与构造形式；`dart run` 输出正确 |
| 集合统计链 | 用 where/map/fold/reduce 等链式方法实现 average/maxBy/countPassed/groupByGrade，禁止 for 循环 | `gradebook.dart` 统计方法 | 数值与手算一致（78.375、3/4、分档正确）；`dart test` 断言通过 |
| mixin 改造 | 把日志能力抽成 `mixin Logger` 并混入 GradeBook，说明相比继承的理由 | `logger.dart`、`with` 写法 | 运行观察日志前缀为 `[GradeBook]` |
| 单元测试 | 为统计与校验写 ≥2 个用例，覆盖正常与异常 | 两个 `_test.dart` | `dart test` 全绿（图2、图4） |
| 自主实践项目 | 设计图书库存类并做 mixin 改造与集合统计链 | `book/loggable/inventory` | 复核 ≥5 个链式方法；`dart run`/`dart test` 通过 |
| 排查报错 | cmd 中 `git log` 报 pager 错误如何解决 | 建议 `--no-pager` | 复现验证：加 `--no-pager` 后正常输出 |

## 八、证据截图

运行截图、控制台输出与 Git 提交记录共 8 张（均为整屏截图，含任务栏与右下角时间）。详见提交文档中的第八节插图（图1–图8）。

## 九、自评

对照 6.1–6.3 逐项自查：

- **6.1 案例复现**：`dart_oo` 完整复现三步，代码与指南一致、可运行、分步提交（完成）。
- **检查点**：统计输出正确、`dart test` 全绿（完成）。
- **Git 规范**：独立公开仓库 `lecture3`，11 次提交，含 README（完成）。
- **报告记录**：本报告按十节填写并存入仓库 `progress.md`（完成）。
- **6.2-1 类设计合理性**：字段封装（私有）、命名构造（`fromJson`/`fromMap`）、校验 setter 齐全（完成）。
- **6.2-2 mixin 改造**：自主实践以 `with Loggable` 替代一层继承，并说明理由（完成）。
- **6.2-3 集合统计链**：`Inventory` 使用 `map/fold/every/any/toSet/reduce/where/firstWhere/sort/update` 等 ≥5 个链式方法（完成）。
- **6.2-4 单元测试**：两个项目各 3 个用例，覆盖正常与异常路径（完成）。
- **6.2-5 AI 使用标注**：第七节逐条标注用途、指令、输出与验证方式（完成）。
- **6.3 独立研究任务**：本次未完成（选做，不计分）。

说明：全部 AI 辅助内容均已运行验证并在本节与第七节标注，无未经验证的直接提交，无伪造证据。

## 十、一句话收获与下一步计划

- **一句话收获**：Dart 用「下划线私有 + 命名构造 + 校验 setter」把数据约束收口到类内，用 mixin 在不占用唯一父类名额的前提下复用横切能力，再把统计交给 `where/map/fold` 这类链式方法，代码更短也更可测。
- **遗留问题**：mixin 同名方法的线性化顺序（后混入者胜出）只做了原理性理解，尚未亲手做顺序对比实验；`groupByGrade` 的档位是硬编码阈值，尚未做成可配置。
- **下一步预习要点**：阅读 dart.dev 的 mixins 与 Iterable 章节；动手做「两个同名 `log` 的 mixin 改 `with` 顺序」实验；尝试重写 `==` 与 `hashCode` 观察 `Set` 去重与 `List.contains` 的行为变化。
