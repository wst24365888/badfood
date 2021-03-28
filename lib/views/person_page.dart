import 'dart:math' as math;
import 'package:badfood/controllers/user_info_controller.dart';
import 'package:badfood/views/report_history_page.dart';
import 'package:badfood/views/support_page.dart';
import 'package:badfood/widgets/responsive_ui.dart';
import 'package:badfood/widgets/wave_widget.dart';
import 'package:flutter/material.dart';
import 'package:badfood/controllers/color_theme_controller.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final _userInfoController = Get.find<UserInfoController>();
  final _colorThemeController = Get.find<ColorThemeController>();

  @override
  Widget build(BuildContext context) {
    final Widget mainComponent = Obx(
      () => SizedBox(
        height: 357,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 36,
                bottom: 24,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      _colorThemeController.colorTheme.color3.withOpacity(0.5),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[200],
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(3, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/donut.gif',
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 72,
                          width: double.infinity,
                        ),
                        Text(
                          _userInfoController.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                          width: double.infinity,
                        ),
                        Text(
                          _userInfoController.email,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                          width: double.infinity,
                        ),
                        const Divider(
                          color: Colors.white54,
                          thickness: 2,
                          indent: 25,
                          endIndent: 25,
                        ),
                        const SizedBox(
                          height: 12,
                          width: double.infinity,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 12,
                                    width: double.infinity,
                                  ),
                                  Text(
                                    "Registered\nDays",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                    width: double.infinity,
                                  ),
                                  Text(
                                    _userInfoController
                                        .getRegisteredDays()
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 12,
                                    width: double.infinity,
                                  ),
                                  Text(
                                    "Reported\nTimes",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                    width: double.infinity,
                                  ),
                                  Text(
                                    _userInfoController.reportCount.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Transform.scale(
              scale: 1.5,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[100],
                      spreadRadius: 5,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.network(
                      _userInfoController.photoURL,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final ResponsiveUI responsiveUI = ResponsiveUI(
      mobileUI: Scrollbar(
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
                          "Profile",
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

                      GestureDetector(
                        onTap: () {
                          Get.to(() => const ReportHistoryPage());
                        },
                        child: Container(
                          height: 125,
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                            left: 24,
                            right: 24,
                            bottom: 24,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _colorThemeController.colorTheme.color3
                                  .withOpacity(0.5),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[200],
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(3, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/donut.gif',
                                  fit: BoxFit.fitWidth,
                                  width: double.infinity,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: Container(
                                        height: double.infinity,
                                        padding:
                                            const EdgeInsets.only(left: 24),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Report History",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: LineIcon.arrowRight(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Get.to(() => const SupportPage());
                        },
                        child: Container(
                          height: 125,
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                            left: 24,
                            right: 24,
                            bottom: 24,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _colorThemeController.colorTheme.color3
                                  .withOpacity(0.5),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[200],
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(3, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/donut.gif',
                                  fit: BoxFit.fitWidth,
                                  width: double.infinity,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: Container(
                                        height: double.infinity,
                                        padding:
                                            const EdgeInsets.only(left: 24),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Support",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: LineIcon.arrowRight(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Fixed Spacing
                      const SizedBox(
                        height: 84,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      webUI: Scrollbar(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            color: _colorThemeController.colorTheme.color1,
            child: Stack(
              children: [
                // ignore: avoid_unnecessary_containers
                Container(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Container(
                            width: math.max(
                              MediaQuery.of(context).size.width / 4,
                              420,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            color: _colorThemeController.colorTheme.color3,
                            child: Column(
                              children: [
                                // Title
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 45,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    "Profile",
                                    style: TextStyle(
                                      fontSize: 50,
                                      height: 1.2,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),

                                mainComponent,

                                const SizedBox(
                                  height: 24,
                                ),

                                // Title
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 25,
                                    right: 25,
                                    bottom: 45,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    "Support",
                                    style: TextStyle(
                                      fontSize: 50,
                                      height: 1.2,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 240,
                                  child: SupportPage(),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 22,
                            child: Column(
                              children: [
                                // Title
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 45,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    "Report History",
                                    style: TextStyle(
                                      fontSize: 50,
                                      height: 1.2,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 726,
                                  child: ReportHistoryPage(),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return responsiveUI.build(context);
  }
}
