import 'dart:math' as math;
import 'package:badfood/controllers/map_page_controller.dart';
import 'package:badfood/controllers/main_screen_controller.dart';
import 'package:badfood/controllers/report_form_controller.dart';
import 'package:badfood/models/reported_stores.dart';
import 'package:badfood/services/get_county_names.dart';
import 'package:badfood/services/get_area_stores.dart';
import 'package:badfood/widgets/responsive_ui.dart';
import 'package:badfood/widgets/wave_widget.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:badfood/controllers/color_theme_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icon.dart';

class StoresPage extends StatefulWidget {
  const StoresPage({Key key}) : super(key: key);

  @override
  StoresPageState createState() => StoresPageState();
}

class StoresPageState extends State<StoresPage> {
  final ColorThemeController _colorThemeController =
      Get.find<ColorThemeController>();
  final MainScreenController _mainScreenController =
      Get.find<MainScreenController>();

  final List<DropdownMenuItem> _countyNameList = [];
  ReportedStores _reportedStores = ReportedStores();

  final ScrollController _scrollController = ScrollController();

  String _cityName;

  @override
  void initState() {
    super.initState();

    getCountyNames().then((countyNameList) {
      setState(() {
        for (final String countyName in countyNameList) {
          _countyNameList.add(
            DropdownMenuItem(
              value: countyName,
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Text(
                  countyName,
                  style: const TextStyle(
                    fontSize: 48,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget mainComponent = Obx(
      () => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
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
                      375,
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
                      375,
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
                      375,
                    ),
                    yOffset: 130,
                    waveHeight: 15.0,
                    color: _colorThemeController.colorTheme.color4,
                    speed: 7892,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fixed Spacer
                  const SizedBox(
                    height: 24,
                  ),

                  // Title
                  Container(
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 25,
                      top: 45,
                      bottom: 5,
                    ),
                    child: const Text(
                      "Stores At",
                      style: TextStyle(
                        fontSize: 50,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: DropdownButton(
                      value: _cityName,
                      onChanged: (cityName) async {
                        _mainScreenController.isLoading = true;

                        setState(() {
                          _cityName = cityName.toString();
                        });

                        getAreaStores(cityName: _cityName)
                            .then((ReportedStores reportedStores) {
                          setState(() {
                            _reportedStores = reportedStores;
                          });
                        });

                        _mainScreenController.isLoading = false;
                      },
                      hint: const Text(
                        "County",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 50,
                          height: 1.2,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                      itemHeight: 60,
                      dropdownColor: _colorThemeController.colorTheme.color5,
                      underline: Container(
                        height: 0.0,
                      ),
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: LineIcon.arrowCircleDown(
                          color: Colors.grey,
                        ),
                      ),
                      iconSize: 24,
                      items: _countyNameList,
                      selectedItemBuilder: (context) =>
                          _countyNameList.map((countyName) {
                        return Text(
                          countyName.value.toString(),
                          style: TextStyle(
                            fontSize: 50,
                            height: 1.2,
                            fontWeight: FontWeight.w700,
                            color: _colorThemeController.colorTheme.color2,
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // Fixed Spacing
                  const SizedBox(
                    height: 85,
                  ),

                  // Reported Store List
                  if (_reportedStores.data == null ||
                      _reportedStores.data.isEmpty)
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 450,
                      child: const Center(
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
                      children: _reportedStores.data.map((StoreData storeData) {
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
                                  barrierColor: Colors.black.withOpacity(0.5),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(45.0),
                                      topRight: Radius.circular(45.0),
                                    ),
                                  ),
                                  isScrollControlled:
                                      true, // won't scroll when keyboard came out if isScrollControlled is set to false
                                  context: context,
                                  builder: (context) => SingleChildScrollView(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xff2394b0),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(45.0),
                                          topRight: Radius.circular(45.0),
                                        ),
                                      ),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 72,
                                              color: const Color(0xff2394b0),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  final MainScreenController
                                                      mainScreenController =
                                                      Get.find<
                                                          MainScreenController>();

                                                  mainScreenController
                                                      .isLoading = true;

                                                  final MapPageController
                                                      mapPageController =
                                                      Get.find<
                                                          MapPageController>();
                                                  await mapPageController
                                                      .locate(
                                                    location: LatLng(
                                                      storeData.location.lat,
                                                      storeData.location.lng,
                                                    ),
                                                    zoom: 20,
                                                  );

                                                  mainScreenController
                                                      .currentPage = 2;

                                                  Navigator.pop(context);

                                                  mainScreenController
                                                      .isLoading = false;
                                                },
                                                child: const Center(
                                                  child: Text(
                                                    "CLICK HERE TO LOCATE",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 72,
                                              color: _colorThemeController
                                                  .colorTheme.color4,
                                              child: GestureDetector(
                                                onTap: () {
                                                  final ReportFormController
                                                      reportFormController =
                                                      Get.find<
                                                          ReportFormController>();
                                                  reportFormController
                                                          .reportForm
                                                          .placeText =
                                                      storeData.name;
                                                  reportFormController
                                                          .reportForm.placeID =
                                                      storeData.placeId;
                                                  reportFormController
                                                      .placeController
                                                      .text = storeData.name;

                                                  _mainScreenController
                                                      .currentPage = 0;

                                                  Navigator.pop(context);
                                                },
                                                child: const Center(
                                                  child: Text(
                                                    "CLICK HERE TO REPORT THE STORE",
                                                    style: TextStyle(
                                                      color: Colors.white,
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
                                      image: AssetImage("assets/food.gif"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                leading: Icon(
                                  Icons.warning_rounded,
                                  size: 64,
                                  color: storeData.reportsCount > 5
                                      ? Colors.red
                                      : Colors.orange,
                                ),
                                title: Container(
                                  margin:
                                      const EdgeInsets.only(left: 12, top: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        storeData.name,
                                        overflow: TextOverflow.ellipsis,
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
                                        "Has been reported ${storeData.reportsCount} times.",
                                        overflow: TextOverflow.ellipsis,
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
                                    ] +
                                    storeData.reports
                                        .map((StoreReport report) {
                                          return Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.white
                                                  .withOpacity(0.75),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                            ),
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 4,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 8,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 24),
                                                    child: Text(
                                                      report.happenedAt,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 36,
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 24),
                                                    child: Text(
                                                      report.title,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        })
                                        .toList()
                                        .sublist(
                                          0,
                                          storeData.reports.length >= 3
                                              ? 3
                                              : storeData.reports.length,
                                        ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                  // Fixed Spacing
                  const SizedBox(
                    height: 84,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    final ResponsiveUI responsiveUI = ResponsiveUI(
      mobileUI: Scrollbar(
        thickness: 7.5,
        isAlwaysShown: true,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: mainComponent,
        ),
      ),
      webUI: Scrollbar(
        thickness: 7.5,
        isAlwaysShown: true,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              const Spacer(),
              Expanded(
                flex: 4,
                child: mainComponent,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );

    return responsiveUI.build(context);
  }
}
