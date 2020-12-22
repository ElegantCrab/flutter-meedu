import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:meedu/meedu.dart';

const times = 50;
void main() {
  test('SimpleController', () async {
    final Completer completer = Completer();
    final c = Controller();
    expect(() {
      c.update(null);
    }, throwsAssertionError);
    int value = c.counter;
    expect(value, 0);
    c.onInit();
    c.afterFirstLayout();
    final subscribe = BaseListener<List<String>>((listeners) {
      value = c.counter;
      if (value == times) {
        completer.complete();
      }
    });
    c.addListener(subscribe);
    for (int i = 1; i <= times; i++) {
      c.counter = i;
      c.update();
    }
    await completer.future;
    expect(value, times);
    c.removeListener(subscribe);
    c.onDispose();
    expect(c.disposed, true);
    expect(() {
      c.update();
    }, throwsAssertionError);
  });
}

class Controller extends SimpleController {
  int counter = 0;

  @override
  void onInit() {
    super.onInit();
    print("😜 onInit");
  }

  @override
  void afterFirstLayout() {
    super.afterFirstLayout();
    print("😜 afterFirstLayout");
  }

  @override
  Future<void> onDispose() {
    print("😜 onDispose");
    return super.onDispose();
  }
}