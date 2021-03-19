import 'dart:math' as math;
import 'package:badfood/controllers/map_page_controller.dart';
import 'package:badfood/controllers/main_screen_controller.dart';
import 'package:badfood/controllers/report_form_controller.dart';
import 'package:badfood/models/user_report_history.dart';
import 'package:badfood/services/get_all_reports_by_user.dart';
import 'package:badfood/widgets/wave_widget.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:badfood/controllers/color_theme_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReportHistoryPage extends StatefulWidget {
  const ReportHistoryPage({Key key}) : super(key: key);

  @override
  ReportHistoryPageState createState() => ReportHistoryPageState();
}

class ReportHistoryPageState extends State<ReportHistoryPage> {
  final _colorThemeController = Get.find<ColorThemeController>();

  UserReportHistory _userReportHistory = UserReportHistory();

  @override
  void initState() {
    super.initState();

    getAllReportsByUser().then((UserReportHistory userReportHistory) {
      setState(() {
        _userReportHistory = userReportHistory;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            "Report History",
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

                        // Reported Store List
                        if (_userReportHistory.data == null ||
                            _userReportHistory.data.isEmpty)
                          const SizedBox(
                            height: 600,
                            child: Center(
                              child: Text(
                                "No data available.",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          )
                        else
                          Column(
                            children: _userReportHistory.data
                                .map((StoreDataAndPlace storeDataAndPlace) {
                                  return Container(
                                    padding: const EdgeInsets.only(
                                      left: 24,
                                      right: 24,
                                      top: 24,
                                    ),
                                    child: Container(
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
                                      child: GestureDetector(
                                        onLongPress: () async {
                                          await showModalBottomSheet(
                                            elevation: 10.0,
                                            barrierColor:
                                                Colors.black.withOpacity(0.5),
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(45.0),
                                                topRight: Radius.circular(45.0),
                                              ),
                                            ),
                                            isScrollControlled:
                                                true, // won't scroll when keyboard came out if isScrollControlled is set to false
                                            context: context,
                                            builder: (context) =>
                                                SingleChildScrollView(
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Color(0xff2394b0),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(45.0),
                                                    topRight:
                                                        Radius.circular(45.0),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 72,
                                                        color: const Color(
                                                            0xff2394b0),
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            final MapPageController
                                                                mapPageController =
                                                                Get.find<
                                                                    MapPageController>();
                                                            await mapPageController
                                                                .locate(
                                                              location: LatLng(
                                                                storeDataAndPlace
                                                                    .place
                                                                    .location
                                                                    .lat,
                                                                storeDataAndPlace
                                                                    .place
                                                                    .location
                                                                    .lng,
                                                              ),
                                                            );

                                                            final MainScreenController
                                                                navigatorController =
                                                                Get.find<
                                                                    MainScreenController>();
                                                            navigatorController
                                                                .currentPage = 2;

                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Center(
                                                            child: Text(
                                                              "CLICK HERE LOCATE",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 72,
                                                        color:
                                                            _colorThemeController
                                                                .colorTheme
                                                                .color4,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            final ReportFormController
                                                                reportFormController =
                                                                Get.find<
                                                                    ReportFormController>();
                                                            reportFormController
                                                                    .reportForm
                                                                    .placeText =
                                                                storeDataAndPlace
                                                                    .place.name;
                                                            reportFormController
                                                                    .reportForm
                                                                    .placeID =
                                                                storeDataAndPlace
                                                                    .place
                                                                    .placeId;
                                                            reportFormController
                                                                    .placeController
                                                                    .text =
                                                                storeDataAndPlace
                                                                    .place.name;

                                                            final MainScreenController
                                                                navigatorController =
                                                                Get.find<
                                                                    MainScreenController>();
                                                            navigatorController
                                                                .currentPage = 0;

                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Center(
                                                            child: Text(
                                                              "CLICK HERE TO REPORT THE STORE",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: ExpansionCard(
                                          background: Container(
                                            height: 280,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/food.gif"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          leading: const Icon(
                                            Icons.warning_rounded,
                                            size: 64,
                                            color: Colors.orange,
                                          ),
                                          title: Container(
                                            margin: const EdgeInsets.only(
                                                left: 12, top: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  storeDataAndPlace.title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: _colorThemeController
                                                        .colorTheme.color1,
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                // Fixed Spacing
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Text(
                                                  storeDataAndPlace.happenedAt,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: _colorThemeController
                                                        .colorTheme.color1,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          children: <Widget>[
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                                "Place: ${storeDataAndPlace.place.name}"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })
                                .toList()
                                .reversed
                                .toList(),
                          ),

                        // Fixed Spacing
                        const SizedBox(
                          height: 84,
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
    );
  }
}
