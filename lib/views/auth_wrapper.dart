import 'dart:math' as math;
import 'package:badfood/controllers/user_info_controller.dart';
import 'package:badfood/models/backend_user_info.dart';
import 'package:badfood/models/user_report_history.dart';
import 'package:badfood/services/get_all_reports_by_user.dart';
import 'package:badfood/services/get_user_info.dart';
import 'package:badfood/widgets/indicator_app_bar.dart';
import 'package:badfood/widgets/no_scrollbar.dart';
import 'package:badfood/widgets/responsive_ui.dart';
import 'package:badfood/widgets/wave_widget.dart';
import 'package:badfood/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:badfood/controllers/color_theme_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:badfood/services/auth_native.dart' as auth_native;
import 'package:badfood/services/auth_web.dart' as auth_web;
import 'package:badfood/services/auth_backend.dart' as auth_backend;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key key}) : super(key: key);

  @override
  AuthWrapperState createState() => AuthWrapperState();
}

class AuthWrapperState extends State<AuthWrapper> {
  final _userInfoController = Get.put(UserInfoController());
  final _colorThemeController = Get.put(ColorThemeController());

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    final Widget mainComponent = Container(
      color: _colorThemeController.colorTheme.color1,
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 240,
            width: 240,
            child: ClipOval(
              child: Image.asset("assets/icon.png"),
            ),
          ),
          const SizedBox(
            height: 48,
          ),
          NoScrollbar(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                decoration: BoxDecoration(
                  color: _colorThemeController.colorTheme.color3,
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
                      offset: const Offset(
                        3,
                        3,
                      ),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton.icon(
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: FaIcon(
                      FontAwesomeIcons.google,
                      color: _colorThemeController.colorTheme.color5,
                    ),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.all(24)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        _colorThemeController.colorTheme.color4),
                  ),
                  label: const Text(
                    "SIGN IN WITH GOOGLE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 1.05,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                      // debugPrint("Google Login");
                    });

                    final UserCredential userCredential = kIsWeb
                        ? await auth_web.signInWithGoogle()
                        : await auth_native.signInWithGoogle();

                    final String idToken =
                        await userCredential.user.getIdToken();

                    final String bearerToken =
                        await auth_backend.signIn(idToken);

                    _userInfoController.bearerToken = bearerToken;

                    final BackendUserInfo backendUserInfo = await getUserInfo();

                    _userInfoController.setUserInfo(
                      name: userCredential.user.displayName,
                      email: userCredential.user.email,
                      photoURL: userCredential.user.photoURL,
                      createAt: backendUserInfo.createdAt,
                    );

                    final UserReportHistory userReportHistory =
                        await getAllReportsByUser();

                    _userInfoController.reportCount =
                        userReportHistory.data.length;

                    setState(() {
                      _isLoading = false;
                      // debugPrint("Login Success");
                    });

                    Get.to(() => const MainScreen());
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );

    final ResponsiveUI responsiveUI = ResponsiveUI(
      mobileUI: Scaffold(
        resizeToAvoidBottomInset: false, // Prevent Keyboard Overflow
        appBar: _isLoading
            ? IndicatorAppBar(
                indicatorHeight: 10,
                backgroundColor: _colorThemeController.colorTheme.color4,
                initialIndicatorColor: _colorThemeController.colorTheme.color5,
                // endIndicatorColor: Colors.blue,
              )
            : AppBar(
                toolbarHeight: 10,
                backgroundColor: _colorThemeController.colorTheme.color4,
                elevation: 0,
              ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Obx(
              () => Stack(
                children: [
                  mainComponent,
                  Transform.rotate(
                    angle: math.pi,
                    child: Transform(
                      transform: Matrix4.rotationY(math.pi),
                      alignment: Alignment.center,
                      child: WaveWidget(
                        size: Size(
                          MediaQuery.of(context).size.width,
                          100,
                        ),
                        yOffset: 25,
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
                          100,
                        ),
                        yOffset: 25,
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
                          100,
                        ),
                        yOffset: 25,
                        waveHeight: 15.0,
                        color: _colorThemeController.colorTheme.color4,
                        speed: 7892,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      webUI: Scaffold(
        resizeToAvoidBottomInset: false, // Prevent Keyboard Overflow
        appBar: _isLoading
            ? IndicatorAppBar(
                indicatorHeight: 10,
                backgroundColor: Colors.transparent,
                initialIndicatorColor: _colorThemeController.colorTheme.color5,
                // endIndicatorColor: Colors.blue,
              )
            : AppBar(
                toolbarHeight: 10,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Obx(
              () => Scrollbar(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      // Flexible and has min height.
                      height: math.max(
                        750,
                        constraints.maxHeight,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Spacer(),
                        Expanded(
                          flex: 4,
                          child: Container(
                            color: _colorThemeController.colorTheme.color1,
                            child: Stack(
                              children: [
                                mainComponent,
                                Transform.rotate(
                                  angle: math.pi,
                                  child: Transform(
                                    transform: Matrix4.rotationY(math.pi),
                                    alignment: Alignment.center,
                                    child: WaveWidget(
                                      size: Size(
                                        MediaQuery.of(context).size.width,
                                        250,
                                      ),
                                      yOffset: 85,
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
                                        250,
                                      ),
                                      yOffset: 85,
                                      waveHeight: 17.5,
                                      color: _colorThemeController
                                          .colorTheme.color5,
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
                                        250,
                                      ),
                                      yOffset: 85,
                                      waveHeight: 15.0,
                                      color: _colorThemeController
                                          .colorTheme.color4,
                                      speed: 7892,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    return responsiveUI.build(context);
  }
}
