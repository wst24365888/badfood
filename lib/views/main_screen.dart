import 'package:badfood/controllers/main_screen_controller.dart';
import 'package:badfood/views/map_page.dart';
import 'package:badfood/views/person_page.dart';
import 'package:badfood/views/stores_page.dart';
import 'package:badfood/widgets/indicator_app_bar.dart';
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

class MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final MainScreenController _mainScreenController =
      Get.put(MainScreenController());
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
          appBar: _mainScreenController.isLoading
              ? IndicatorAppBar(
                  height: 10,
                  backgroundColor: _colorThemeController.colorTheme.color4,
                  initialIndicatorColor:
                      _colorThemeController.colorTheme.color5,
                  // endIndicatorColor: Colors.blue,
                )
              : AppBar(
                  toolbarHeight: 10,
                  backgroundColor: _colorThemeController.colorTheme.color4,
                  elevation: 0,
                ),
          body: IndexedStack(
            index: _mainScreenController.currentPage,
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
              selectedIndex: _mainScreenController.currentPage,
              onTabChange: (int _selectedIndex) {
                _mainScreenController.currentPage = _selectedIndex;
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
      webUI: Obx(
        () => Scaffold(
          appBar: _mainScreenController.isLoading
              ? IndicatorAppBar(
                  height: 10,
                  backgroundColor: _colorThemeController.colorTheme.color4,
                  initialIndicatorColor:
                      _colorThemeController.colorTheme.color5,
                  // endIndicatorColor: Colors.blue,
                )
              : AppBar(
                  toolbarHeight: 10,
                  backgroundColor: _colorThemeController.colorTheme.color4,
                  elevation: 0,
                ),
          body: IndexedStack(
            index: _mainScreenController.currentPage,
            children: _pages,
          ),
        ),
      ),
    );

    return responsiveUI.build(context);
  }
}
