import 'package:flutter/widgets.dart';
import 'meedu_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// classs to inject a controller into the widgets tree
class MeeduProvider<T extends MeeduController>
    extends SingleChildStatelessWidget {
  /// instance that extends of MeeduController
  final T controller;

  MeeduProvider({
    Key key,
    @required this.controller,
    @required Widget child,
  })  : assert(controller != null && child != null),
        super(
          key: key,
          child: child,
        );

  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    // use the InheritedProvider to inject the controller and catch the life cycle widget
    return InheritedProvider<T>(
      create: (_) => this.controller,
      child: child,
      lazy: false,
      dispose: (_, __) => this.controller.onDispose(),
      startListening: (e, controller) {
        controller.onInit();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // if the controller is not disposed
          if (!controller.disposed) {
            controller.afterFirstLayout();
          }
        });
        return () {};
      },
    );
  }

  /// Search one instance of MeeduController using the context
  static T of<T extends MeeduController>(BuildContext context) {
    return Provider.of<T>(context, listen: false);
  }
}
