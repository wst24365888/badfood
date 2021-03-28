import 'package:badfood/services/get_detailed_report.dart';
import 'package:badfood/widgets/indicator_app_bar.dart';
import 'package:badfood/widgets/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:badfood/controllers/color_theme_controller.dart';
import 'package:get/get.dart';

class DetailedReportPage extends StatefulWidget {
  final int reportID;

  const DetailedReportPage({
    Key key,
    this.reportID,
  }) : super(key: key);

  @override
  DetailedReportPageState createState() => DetailedReportPageState();
}

class DetailedReportPageState extends State<DetailedReportPage> {
  final ColorThemeController _colorThemeController =
      Get.find<ColorThemeController>();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    getDetailedReport(widget.reportID).then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget mainComponent = Column(
      children: [],
    );

    final ResponsiveUI responsiveUI = ResponsiveUI(
      mobileUI: Scaffold(
        backgroundColor: _colorThemeController.colorTheme.color1,
        appBar: _isLoading
            ? IndicatorAppBar(
                indicatorHeight: 10,
                backgroundColor: _colorThemeController.colorTheme.color1,
                initialIndicatorColor: _colorThemeController.colorTheme.color5,
                // endIndicatorColor: Colors.blue,
              )
            : AppBar(
                toolbarHeight: 10,
                backgroundColor: _colorThemeController.colorTheme.color1,
                elevation: 0,
              ),
        body: Obx(
          () => Scrollbar(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                color: _colorThemeController.colorTheme.color1,
              ),
            ),
          ),
        ),
      ),
      webUI: Scaffold(
        backgroundColor: _colorThemeController.colorTheme.color1,
        appBar: _isLoading
            ? IndicatorAppBar(
                indicatorHeight: 10,
                backgroundColor: _colorThemeController.colorTheme.color1,
                initialIndicatorColor: _colorThemeController.colorTheme.color5,
                // endIndicatorColor: Colors.blue,
              )
            : AppBar(
                toolbarHeight: 10,
                backgroundColor: _colorThemeController.colorTheme.color1,
                elevation: 0,
              ),
        body: Obx(
          () => Scrollbar(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                color: _colorThemeController.colorTheme.color1,
              ),
            ),
          ),
        ),
      ),
    );

    return responsiveUI.build(context);
  }
}
