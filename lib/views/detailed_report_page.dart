import 'package:badfood/models/detailed_report.dart';
import 'package:badfood/services/get_detailed_report.dart';
import 'package:badfood/widgets/indicator_app_bar.dart';
import 'package:badfood/widgets/no_scrollbar.dart';
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

  DetailedReport _detailedReport = DetailedReport();

  final List<Image> _photos = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    getDetailedReport(widget.reportID)
        .then((DetailedReport detailedReport) async {
      setState(() {
        _detailedReport = detailedReport;

        if (_detailedReport.data.image.isNotEmpty) {
          for (ReportImage reportImage in _detailedReport.data.image) {
            print(reportImage.id);
          }
        }

        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUI responsiveUI = ResponsiveUI(
      mobileUI: Obx(
        () => Scrollbar(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height:
                          MediaQuery.of(context).size.height * 0.8 - 480 <= 0
                              ? 0
                              : MediaQuery.of(context).size.height * 0.8 - 480,
                      decoration: const BoxDecoration(
                        color: Color(0xff2394b0),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0),
                        ),
                      ),
                    ),
                    Container(
                      height: 480,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/food.gif"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                if (_detailedReport.data != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 48,
                        ),
                        Text(
                          _detailedReport.data.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: _colorThemeController.colorTheme.color1,
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 108,
                              child: Text(
                                "Time",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Text(
                              "|  ${_detailedReport.data.happenedAt}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 108,
                              child: Text(
                                "Place",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Text(
                              "|  ${_detailedReport.data.place.name}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 4),
                              width: 108,
                              child: Text(
                                "Symptom",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                "|  ",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: NoScrollbar(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Text(
                                    _detailedReport.data.symptom,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey[300],
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        if (_detailedReport.data.note != null)
                          Row(
                            children: [
                              SizedBox(
                                width: 108,
                                child: Text(
                                  "Note",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey[300],
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Text(
                                "|  ${_detailedReport.data.note}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                if (_isLoading)
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff2394b0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45.0),
                        topRight: Radius.circular(45.0),
                      ),
                    ),
                    child: Indicator(
                      height: 10,
                      backgroundColor: const Color(0xff2394b0),
                      initialIndicatorColor:
                          _colorThemeController.colorTheme.color5,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      webUI: Obx(
        () => Scrollbar(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              decoration: BoxDecoration(
                color: _colorThemeController.colorTheme.color1,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(45.0),
                  topRight: Radius.circular(45.0),
                ),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/food.gif"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return responsiveUI.build(context);
  }
}
