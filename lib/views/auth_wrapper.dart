import 'dart:math' as math;
import 'package:badfood/controllers/user_info_controller.dart';
import 'package:badfood/models/backend_user_info.dart';
import 'package:badfood/models/user_report_history.dart';
import 'package:badfood/services/get_all_reports_by_user.dart';
import 'package:badfood/services/get_user_info.dart';
import 'package:badfood/widgets/indicator_app_bar.dart';
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

    return Scaffold(
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
                                    horizontal: 25, vertical: 45),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Sign In",
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
                                height: 240,
                              ),

                              Container(
                                height: 75,
                                width: 350,
                                decoration: BoxDecoration(
                                  color:
                                      _colorThemeController.colorTheme.color3,
                                  border: Border.all(
                                    color: _colorThemeController
                                        .colorTheme.color3
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
                                      color: _colorThemeController
                                          .colorTheme.color5,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        OutlinedBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    padding: MaterialStateProperty.all<
                                            EdgeInsetsGeometry>(
                                        const EdgeInsets.symmetric(
                                            vertical: 16)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            _colorThemeController
                                                .colorTheme.color4),
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
                                    });

                                    final UserCredential userCredential = kIsWeb
                                        ? await auth_web.signInWithGoogle()
                                        : await auth_native.signInWithGoogle();

                                    final String idToken =
                                        await userCredential.user.getIdToken();

                                    final String bearerToken =
                                        await auth_backend.signIn(idToken);

                                    _userInfoController.bearerToken =
                                        bearerToken;

                                    final BackendUserInfo backendUserInfo =
                                        await getUserInfo();

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
                                    });

                                    Get.to(() => const MainScreen());
                                  },
                                ),
                              ),

                              // Fixed Spacer
                              const SizedBox(
                                height: 240,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
