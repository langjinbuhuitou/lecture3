/// 日志能力：与继承体系无关，任何类都可以 `with Logger` 混入。
///
/// 用 $runtimeType 让每条日志带上宿主类的实际类型名。
mixin Logger {
  void log(String msg) => print('[$runtimeType] $msg');
}
