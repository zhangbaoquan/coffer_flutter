import 'dart:math';

/// author       : coffer
/// date         : 2022/10/30
/// description  :
///
class TestAsync {
  main() {
    t1();
    t2();
    t3();
    t4();
  }

  t1() {
    testFuture().then((value) {
      // 下面是输出 success
      print(value);
    }, onError: (e) {
      print(e);
    }).catchError((onError) {
      print(onError);
    });
    // 如果catchError与onError同时存在，则会只调用onError；
  }

  /// 使用future.then获取future的值与捕获future的异常
  Future<String> testFuture() {
    return Future.value('success');
  }

  t2() {
    print('t1' + DateTime.now().toString());
    test2();
    print('t2' + DateTime.now().toString());
  }

  /// Future是异步的，如果我们要将异步转同步，那么可以借助async await来完成。
  test2() async {
    int res = await Future.delayed(Duration(milliseconds: 2000), () {
      return Future.value(123);
    });
    print('t3 : ' + DateTime.now().toString());
    print(res);
  }

  /// 有时候我们需要在Future结束的时候做些事情，
  /// 我们知道then().catchError()的模式类似于try-catch，
  /// try-catch有个finally代码块，而future.whenComplete就是Future的finally。
  t3() {
    var random = Random();
    Future.delayed(const Duration(seconds: 3), () {
      if (random.nextBool()) {
        return 100;
      } else {
        throw 'boom !';
      }
    })
        .then((value) => print(value))
        .catchError((value) => print(value))
        .whenComplete(() => {print('done !')});
  }

  /// 完成一个异步操作可能需要很长的时间，比如：网络请求，但有时我们需要为异步操作设置一个超时时间，
  /// 使用timeout 可以为Future设置超时时间
  t4() {
    Future.delayed(const Duration(seconds: 3), (){
      return 1;
    })
        .timeout(const Duration(seconds: 2))
        .then((value) => {print(value)})
        .catchError((onError) => {print(onError)});
  }
  // 运行上述代码会看到：TimeoutException after 0:00:02.000000: Future not completed。
}
