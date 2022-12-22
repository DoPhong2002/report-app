import 'dart:async';
import 'dart:ui';

class MybuttomBloc {
  final _myButtomStream = StreamController<bool>.broadcast();

  Stream<bool> get streamButtom => _myButtomStream.stream;
  bool lock = false;

  void isLock(VoidCallback onTap) {
    if (lock == false) {
      lock = true;
      onTap();
      _myButtomStream.add(lock);
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      lock = false;
      _myButtomStream.add(lock);
    });
  }
}
