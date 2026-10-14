/// 跨类复用的日志能力。
///
/// 设计说明（自主实践要求 2：mixin 改造）：
/// 最初 [Inventory] 通过 `extends LoggerBase` 继承来复用日志能力；
/// 但“写日志”是一种横切能力，二者并非“是一种（is-a）”关系，
/// 且继承会占用唯一的父类名额、一旦将来需要继承别的基类就无路可走。
/// 因此改造为 `with Loggable` 混入：复用同一份实现，又不破坏继承体系。
mixin Loggable {
  void log(String msg) => print('[$runtimeType] $msg');
}
