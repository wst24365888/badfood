import 'package:flutter/material.dart';

class IndicatorAppBar extends PreferredSize {
  final double height;
  final Color backgroundColor;
  final Color initialIndicatorColor;
  final Color endIndicatorColor;

  const IndicatorAppBar({
    this.height = kToolbarHeight,
    @required this.backgroundColor,
    @required this.initialIndicatorColor,
    this.endIndicatorColor,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: Indicator(
        height: height,
        backgroundColor: backgroundColor,
        initialIndicatorColor: initialIndicatorColor,
        endIndicatorColor: endIndicatorColor,
      ),
    );
  }
}

class Indicator extends StatefulWidget {
  final double height;
  final Color backgroundColor;
  final Color initialIndicatorColor;
  final Color endIndicatorColor;

  const Indicator({
    this.height,
    this.backgroundColor,
    this.initialIndicatorColor,
    this.endIndicatorColor,
  });

  @override
  IndicatorState createState() => IndicatorState();
}

class IndicatorState extends State<Indicator> with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(
        reverse: true,
      );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: LinearProgressIndicator(
        backgroundColor: widget.backgroundColor,
        minHeight: widget.height,
        valueColor: widget.endIndicatorColor == null
            ? AlwaysStoppedAnimation<Color>(widget.initialIndicatorColor)
            : animationController.drive(
                ColorTween(
                  begin: widget.initialIndicatorColor,
                  end: widget.endIndicatorColor,
                ),
              ),
      ),
    );
  }
}
