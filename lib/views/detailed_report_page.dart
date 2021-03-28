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

  final List<Widget> _photos = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    getDetailedReport(widget.reportID)
        .then((DetailedReport detailedReport) async {
      setState(() {
        _detailedReport = detailedReport;
      });

      if (_detailedReport.data.image.isNotEmpty) {
        for (final ReportImageInfo reportImageInfo
            in _detailedReport.data.image) {
          setState(() {
            _photos.add(
              Image.network(
                  "https://dscncu-c8a09.appspot.com.storage.googleapis.com/${reportImageInfo.id}"),
            );
            _photos.add(
              const SizedBox(
                width: 24,
              ),
            );
          });
        }
        _photos.removeLast();
      }

      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget mainComponent = Obx(
      () => Stack(
        children: [
          if (_detailedReport.data != null)
            Container(
              color: const Color(0xff2394b0),
              child: Padding(
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
                      height: 36,
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
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 120,
                          ),
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
                    if (_detailedReport.data.note != null)
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
                    if (_photos.isNotEmpty)
                      const SizedBox(
                        height: 24,
                      ),
                    if (_photos.isNotEmpty)
                      Text(
                        "Photos",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    if (_photos.isNotEmpty)
                      const SizedBox(
                        height: 18,
                      ),
                    if (_photos.isNotEmpty)
                      Container(
                        height: 175,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                        ),
                        padding: const EdgeInsets.all(24),
                        child: NoScrollbar(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: _photos,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
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
                initialIndicatorColor: _colorThemeController.colorTheme.color5,
              ),
            ),
        ],
      ),
    );

    final ResponsiveUI responsiveUI = ResponsiveUI(
      mobileUI: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(45.0),
          topRight: Radius.circular(45.0),
        ),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: mainComponent,
          ),
        ),
      ),
      webUI: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(45.0),
                    topRight: Radius.circular(45.0),
                  ),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: mainComponent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );

    return responsiveUI.build(context);
  }
}
