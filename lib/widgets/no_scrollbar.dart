import 'package:flutter/material.dart';

class NoScrollbar extends StatelessWidget {
  final Widget child;
  const NoScrollbar({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (_) => true,
      child: child,
    );
  }
}
