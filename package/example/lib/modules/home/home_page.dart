import 'package:flutter/material.dart';
import 'package:meedu/state.dart';
import 'package:meedu/router.dart' as router;
import 'package:meedu_example/modules/login/login_page.dart';
import 'package:meedu_example/modules/rx_example.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<HomeController>(
      controller: HomeController(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SimpleBuilder<HomeController>(
                  id: 'counter',
                  builder: (controller) => Text(
                    "${controller.counter}",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => RxExample()),
                    );
                    // router.push(
                    //   RxExample(),
                    //   transition: router.Transition.material,
                    //   backGestureEnabled: true,
                    // );
                  },
                  child: Text("StateController example"),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: SimpleBuilder<HomeController>(
          allowRebuild: false,
          builder: (_) => FloatingActionButton(
            onPressed: () {
              _.incremment();
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
