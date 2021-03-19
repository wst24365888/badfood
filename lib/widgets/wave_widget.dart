import 'dart:math' as math;
import 'package:badfood/widgets/clipper_widget.dart';
import 'package:flutter/material.dart';

class WaveWidget extends StatefulWidget {
  final Size size;
  final double yOffset;
  final double waveHeight;
  final Color color;
  final double speed;

  const WaveWidget({
    this.size,
    this.yOffset,
    this.waveHeight,
    this.color,
    this.speed,
  });

  @override
  _WaveWidgetState createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget> with TickerProviderStateMixin {
  AnimationController animationController;
  List<Offset> wavePoints = [];

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000))
      ..addListener(() {
        wavePoints.clear();

        final double waveSpeed = animationController.value * widget.speed;
        final double fullSphere = animationController.value * math.pi * 2;
        final double normalizer = math.cos(fullSphere);
        final double waveWidth = math.pi / (widget.speed / 4);
        final double waveHeight = widget.waveHeight;

        for (double i = 0; i <= widget.size.width; i += 1) {
          final double calc = math.sin((waveSpeed - i) * waveWidth);
          wavePoints.add(
            Offset(
              i.toDouble(), //X
              calc * waveHeight * normalizer + widget.yOffset, //Y
            ),
          );
        }
      });

    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, _) {
        return ClipPath(
          clipper: ClipperWidget(
            waveList: wavePoints,
          ),
          child: Container(
            width: widget.size.width,
            height: widget.size.height,
            color: widget.color,
          ),
        );
      },
    );
  }
}
