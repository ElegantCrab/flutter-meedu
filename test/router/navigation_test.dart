import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meedu/router.dart' as router;

void main() {
  testWidgets('normal navigation', (test) async {
    router.setDefaultTransition(router.Transition.material);
    await test.pumpWidget(
      MaterialApp(
        navigatorKey: router.navigatorKey,
        home: HomePage(),
        routes: {
          'detail': (_) => DetailPage(),
        },
      ),
    );
    expect(router.canPop(), false);
    await test.tap(find.text("pushNamed"));
    await test.pumpAndSettle();
    expect(find.text("meedu"), findsOneWidget);
    expect(router.canPop(), true);
    await test.tap(find.text("back"));
    await test.pumpAndSettle();
    expect(find.text("meedu"), findsNothing);
    await test.tap(find.text("pushReplacement"));
    await test.pumpAndSettle();
    expect(find.text("meedu"), findsOneWidget);
    expect(router.canPop(), false);
  });
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FlatButton(
            onPressed: () {
              router.pushReplacement(
                DetailPage(),
                arguments: "meedu",
                transition: router.Transition.zoom,
                transitionDuration: Duration(milliseconds: 100),
              );
            },
            child: Text("pushReplacement"),
          ),
          FlatButton(
            onPressed: () {
              router.pushNamed(
                'detail',
                arguments: "meedu",
              );
            },
            child: Text("pushNamed"),
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String productName = router.arguments(context);
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          onPressed: () {
            router.popUntil((route) {
              print(" route.settings.name ${route.settings.name}");
              return route.settings.name == '/';
            });
          },
          child: Text("back"),
        ),
      ),
      body: Text(productName),
    );
  }
}