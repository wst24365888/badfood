import 'dart:math' as math;
import 'package:badfood/widgets/no_scrollbar.dart';
import 'package:badfood/widgets/responsive_ui.dart';
import 'package:badfood/widgets/wave_widget.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:badfood/controllers/color_theme_controller.dart';
import 'package:get/get.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key key}) : super(key: key);

  @override
  SupportPageState createState() => SupportPageState();
}

class SupportPageState extends State<SupportPage> {
  final ColorThemeController _colorThemeController =
      Get.find<ColorThemeController>();

  bool _initMobileUI = false;

  @override
  Widget build(BuildContext context) {
    if (_initMobileUI && MediaQuery.of(context).size.width >= 960) {
      Navigator.pop(context);
    }

    _initMobileUI = MediaQuery.of(context).size.width < 960;

    final Widget mainComponent = Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(3, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(30),
          ),
          child: ExpansionCard(
            background: Container(
              height: 280,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/donut.gif"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            leading: Icon(
              Icons.question_answer_rounded,
              size: 56,
              color: _colorThemeController.colorTheme.color4,
            ),
            title: Container(
              margin: const EdgeInsets.only(left: 12, top: 12),
              child: const Text(
                "What should I do if I find a bug?",
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            children: [
              const SizedBox(
                height: 24,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: const Text(
                  "Please contact xyphuzwu@gmail.com.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    final ResponsiveUI responsiveUI = ResponsiveUI(
      mobileUI: Scaffold(
        appBar: AppBar(
          toolbarHeight: 10,
          backgroundColor: _colorThemeController.colorTheme.color4,
          elevation: 0,
        ),
        body: Obx(
          () => Scrollbar(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                color: _colorThemeController.colorTheme.color1,
                child: Stack(
                  children: [
                    Transform.rotate(
                      angle: math.pi,
                      child: Transform(
                        transform: Matrix4.rotationY(math.pi),
                        alignment: Alignment.center,
                        child: WaveWidget(
                          size: Size(
                            MediaQuery.of(context).size.width,
                            350,
                          ),
                          yOffset: 130,
                          waveHeight: 17.5,
                          color: Colors.blue,
                          speed: 1234,
                        ),
                      ),
                    ),
                    Transform.rotate(
                      angle: math.pi,
                      child: Transform(
                        transform: Matrix4.rotationY(0),
                        alignment: Alignment.center,
                        child: WaveWidget(
                          size: Size(
                            MediaQuery.of(context).size.width,
                            350,
                          ),
                          yOffset: 130,
                          waveHeight: 17.5,
                          color: _colorThemeController.colorTheme.color5,
                          speed: 2344,
                        ),
                      ),
                    ),
                    Transform.rotate(
                      angle: math.pi,
                      child: Transform(
                        transform: Matrix4.rotationY(math.pi),
                        alignment: Alignment.center,
                        child: WaveWidget(
                          size: Size(
                            MediaQuery.of(context).size.width,
                            350,
                          ),
                          yOffset: 130,
                          waveHeight: 15.0,
                          color: _colorThemeController.colorTheme.color4,
                          speed: 7892,
                        ),
                      ),
                    ),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: Column(
                        children: [
                          // Fixed Spacer
                          const SizedBox(
                            height: 24,
                          ),

                          // Title
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 45,
                            ),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "Support",
                              style: TextStyle(
                                fontSize: 50,
                                height: 1.2,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          // Fixed Spacer
                          const SizedBox(
                            height: 108,
                          ),

                          mainComponent,

                          // Fixed Spacing
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 450,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          margin: const EdgeInsets.only(right: 24, top: 24),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.close_rounded,
                              size: 36,
                              color: _colorThemeController.colorTheme.color5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      webUI: Scaffold(
        body: Container(
          color: _colorThemeController.colorTheme.color3,
          child: NoScrollbar(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: mainComponent,
            ),
          ),
        ),
      ),
    );

    return responsiveUI.build(context);
  }
}
