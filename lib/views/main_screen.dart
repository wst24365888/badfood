import 'package:badfood/controllers/navigator_controller.dart';
import 'package:badfood/views/map_page.dart';
import 'package:badfood/views/person_page.dart';
import 'package:badfood/views/stores_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:badfood/controllers/report_form_controller.dart';
import 'package:badfood/widgets/responsive_ui.dart';
import 'package:badfood/views/report_page.dart';
import 'package:flutter/services.dart';
import 'package:badfood/controllers/color_theme_controller.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final NavigatorController _navigatorController =
      Get.put(NavigatorController());
  final ColorThemeController _colorThemeController =
      Get.find<ColorThemeController>();

  final List<Widget> _pages = const [
    ReportPage(),
    StoresPage(),
    MapPage(),
    PersonPage(),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(ReportFormController());

    SystemChrome.setEnabledSystemUIOverlays([]);

    final ResponsiveUI responsiveUI = ResponsiveUI(
      mobileUI: Obx(
        () => Scaffold(
          body: IndexedStack(
            index: _navigatorController.currentPage,
            children: _pages,
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            color: _colorThemeController.colorTheme.color4,
            child: GNav(
              backgroundColor: _colorThemeController.colorTheme.color4,
              tabBackgroundColor: _colorThemeController.colorTheme.color5,
              color: Colors.white70,
              activeColor: Colors.black,
              hoverColor: Colors.grey[400],
              gap: 8,
              tabBorderRadius: 50,
              duration: const Duration(milliseconds: 750),
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              selectedIndex: _navigatorController.currentPage,
              onTabChange: (int _selectedIndex) {
                _navigatorController.currentPage = _selectedIndex;
                // debugPrint("Current Page: $_selectedIndex");
              },
              tabs: const [
                GButton(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  icon: LineIcons.exclamation,
                  text: 'Report',
                ),
                GButton(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  icon: LineIcons.store,
                  text: 'Stores',
                ),
                GButton(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  icon: LineIcons.mapMarked,
                  text: 'Map',
                ),
                // GButton(
                //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                //   icon: LineIcons.bullhorn,
                //   text: 'Notifications',
                // ),
                GButton(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  icon: LineIcons.user,
                  text: 'Person',
                ),
              ],
            ),
          ),
        ),
      ),
      webUI: Scaffold(
        resizeToAvoidBottomInset: false, // Prevent Keyboard Overflow
        body: Container(
          color: Colors.black,
          child: const Center(
            child: Text(
              "Web UI",
              style: TextStyle(
                color: Colors.white,
                fontSize: 60,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ),
      ),
    );

    return responsiveUI.build(context);
  }
}
