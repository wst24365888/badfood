import 'dart:io';
import 'dart:math' as math;
import 'package:badfood/controllers/main_screen_controller.dart';
import 'package:badfood/controllers/user_info_controller.dart';
import 'package:badfood/models/predicted_place.dart';
import 'package:badfood/services/get_predict_place.dart';
import 'package:badfood/services/submit_new_report.dart';
import 'package:badfood/widgets/responsive_ui.dart';
import 'package:badfood/widgets/text_snack_bar.dart';
import 'package:badfood/widgets/wave_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:badfood/controllers/report_form_controller.dart';
import 'package:badfood/widgets/no_scrollbar.dart';
import 'package:badfood/controllers/color_theme_controller.dart';
import 'package:get/get.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key key}) : super(key: key);

  @override
  ReportPageState createState() => ReportPageState();
}

class ReportPageState extends State<ReportPage> {
  final ColorThemeController _colorThemeController =
      Get.find<ColorThemeController>();
  final ReportFormController _reportFormController =
      Get.put(ReportFormController());
  final MainScreenController _mainScreenController =
      Get.find<MainScreenController>();

  final _scrollController = ScrollController();

  String _titleHint = "Enter title here...";
  String _placeHint = "Enter occur place here...";
  String _symptomHint = "Enter your symptom here...";
  String _noteHint = "Enter occur place here...";

  final FocusNode _focusNodeOfTitle = FocusNode();
  final FocusNode _focusNodeOfPlace = FocusNode();
  final FocusNode _focusNodeOfSymptom = FocusNode();
  final FocusNode _focusNodeOfNote = FocusNode();

  PredictedPlace _predictions = PredictedPlace();

  final _imagePicker = ImagePicker();

  List<Widget> _photos;

  BoxDecoration _formBoxDecoration;

  void initPhotos() {
    _photos = [
      GestureDetector(
        onTap: () async {
          _mainScreenController.isLoading = true;

          final _pickedPhoto =
              await _imagePicker.getImage(source: ImageSource.gallery);

          setState(() {
            if (_pickedPhoto != null) {
              _reportFormController.addPhotoPath(_pickedPhoto.path);
              if (kIsWeb) {
                _photos.insert(
                    _photos.length - 1, Image.network(_pickedPhoto.path));
              } else {
                _photos.insert(
                    _photos.length - 1, Image.file(File(_pickedPhoto.path)));
              }
            }
          });

          _mainScreenController.isLoading = false;
        },
        child: Container(
          height: 80,
          width: 80,
          color: _colorThemeController.colorTheme.color4,
          child: const Icon(
            LineIcons.plus,
            color: Colors.white,
          ),
        ),
      ),
    ];
  }

  void reset() {
    _reportFormController.titleController.text = "";
    _reportFormController.placeController.text = "";
    _reportFormController.symptonController.text = "";
    _reportFormController.noteController.text = "";

    initPhotos();
  }

  @override
  void initState() {
    super.initState();

    _focusNodeOfTitle.addListener(() {
      setState(() {
        _titleHint = _focusNodeOfTitle.hasFocus ? "" : "Enter title here...";
      });
    });

    _focusNodeOfPlace.addListener(() {
      setState(() {
        _placeHint =
            _focusNodeOfPlace.hasFocus ? "" : "Enter occur place here...";
      });

      if (!_focusNodeOfPlace.hasFocus) {
        setState(() {
          _predictions = PredictedPlace();
        });
      }
    });

    _focusNodeOfSymptom.addListener(() {
      setState(() {
        _symptomHint =
            _focusNodeOfSymptom.hasFocus ? "" : "Enter your symptom here...";
      });
    });

    _focusNodeOfNote.addListener(() {
      setState(() {
        _noteHint = _focusNodeOfNote.hasFocus ? "" : "Any other note...";
      });
    });

    _formBoxDecoration = BoxDecoration(
      color: _colorThemeController.colorTheme.color3,
      border: Border.all(
        color: _colorThemeController.colorTheme.color3.withOpacity(0.5),
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
      borderRadius: BorderRadius.circular(10),
    );

    initPhotos();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    _focusNodeOfTitle.dispose();
    _focusNodeOfPlace.dispose();
    _focusNodeOfSymptom.dispose();
    _focusNodeOfNote.dispose();

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
                      padding: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                        bottom: 5,
                        top: 45,
                      ),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Submit New",
                        style: TextStyle(
                          fontSize: 50,
                          height: 1.2,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
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
                        "Report",
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
                      height: 50,
                    ),

                    // Enter Title Section
                    Row(
                      children: [
                        // Flex Spacer
                        const Spacer(),

                        Expanded(
                          flex: 21,
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              _focusNodeOfTitle.requestFocus();
                            },
                            child: Container(
                              height:
                                  _reportFormController.titleError ? 100 : 75,
                              padding: const EdgeInsets.all(12),
                              decoration: _formBoxDecoration,
                              child: Column(
                                children: [
                                  // Title
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Title*",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: _colorThemeController
                                            .colorTheme.color4,
                                      ),
                                    ),
                                  ),

                                  // Flex Spacer
                                  const Spacer(),

                                  // Enter Title
                                  TextFormField(
                                    controller:
                                        _reportFormController.titleController,
                                    onChanged:
                                        _reportFormController.onChangeTitle,
                                    focusNode: _focusNodeOfTitle,
                                    cursorColor: Colors.grey,
                                    decoration: _reportFormController.titleError
                                        ? InputDecoration(
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    bottom: 4),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            hintText: _titleHint,
                                            hintStyle: const TextStyle(
                                              color: Colors.black,
                                            ),
                                            errorText: "Please fill the title.",
                                          )
                                        : InputDecoration.collapsed(
                                            hintText: _titleHint,
                                            hintStyle: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),

                                  if (kIsWeb)
                                    const SizedBox(
                                      height: 4,
                                    )
                                  else
                                    Container(),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Flex Spacer
                        const Spacer(),
                      ],
                    ),

                    // Fixed Spacer
                    const SizedBox(
                      height: 24,
                    ),

                    Row(
                      children: [
                        // Flex Spacer
                        const Spacer(),

                        // Select Date
                        Expanded(
                          flex: 10,
                          child: GestureDetector(
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());

                              final _now = DateTime.now();

                              final _date = await showDatePicker(
                                context: context,
                                firstDate: DateTime(
                                    _now.year, _now.month, _now.day - 3),
                                initialDate: DateTime.now(),
                                lastDate: DateTime.now(),
                                builder: (BuildContext context, Widget child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme:
                                          const ColorScheme.light().copyWith(
                                        primary: _colorThemeController
                                            .colorTheme.color4,
                                      ),
                                    ),
                                    child: child,
                                  );
                                },
                              );

                              if (_date != null) {
                                _reportFormController.onCahngeDate(
                                    DateFormat('yyyy-MM-dd').format(_date));
                              }
                            },
                            child: Container(
                              height: 75,
                              padding: const EdgeInsets.all(12),
                              decoration: _formBoxDecoration,
                              child: Column(
                                children: [
                                  // Title
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Occur Date*",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: _colorThemeController
                                            .colorTheme.color4,
                                      ),
                                    ),
                                  ),

                                  // Flex Spacer
                                  const Spacer(),

                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _reportFormController
                                              .reportForm.dateText.isEmpty
                                          ? "Select Occur Date"
                                          : _reportFormController
                                              .reportForm.dateText,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),

                                  if (kIsWeb)
                                    const SizedBox(
                                      height: 4,
                                    )
                                  else
                                    const SizedBox(
                                      height: 2,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Flex Spacer
                        const Spacer(),

                        // Select Time
                        Expanded(
                          flex: 10,
                          child: GestureDetector(
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());

                              final _time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                builder: (BuildContext context, Widget child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme:
                                          const ColorScheme.light().copyWith(
                                        primary: _colorThemeController
                                            .colorTheme.color4,
                                      ),
                                    ),
                                    child: child,
                                  );
                                },
                              );

                              if (_time != null) {
                                _reportFormController.onChangeTime(
                                  DateFormat("HH:mm:ss").format(
                                    DateFormat.jm().parse(
                                      _time.format(context),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              height: 75,
                              padding: const EdgeInsets.all(12),
                              decoration: _formBoxDecoration,
                              child: Column(
                                children: [
                                  // Title
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Occur Time*",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: _colorThemeController
                                            .colorTheme.color4,
                                      ),
                                    ),
                                  ),

                                  // Flex Spacer
                                  const Spacer(),

                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _reportFormController
                                              .reportForm.timeText.isEmpty
                                          ? "Select Occur Time"
                                          : _reportFormController
                                              .reportForm.timeText,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),

                                  if (kIsWeb)
                                    const SizedBox(
                                      height: 4,
                                    )
                                  else
                                    const SizedBox(
                                      height: 2,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Flex Spacer
                        const Spacer(),
                      ],
                    ),

                    // Fixed Spacer
                    const SizedBox(
                      height: 24,
                    ),

                    Stack(
                      children: [
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Flex Spacer
                                const Spacer(),

                                // Select Place
                                Expanded(
                                  flex: 21,
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      _focusNodeOfPlace.requestFocus();
                                    },
                                    child: Container(
                                      height: _reportFormController.placeError
                                          ? 100
                                          : 75,
                                      padding: const EdgeInsets.all(12),
                                      decoration: _formBoxDecoration,
                                      child: Column(
                                        children: [
                                          // Place
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Occur Place*",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: _colorThemeController
                                                    .colorTheme.color4,
                                              ),
                                            ),
                                          ),

                                          // Flex Spacer
                                          const Spacer(),

                                          // Enter Place
                                          TextFormField(
                                            controller: _reportFormController
                                                .placeController,
                                            onChanged: (String s) {
                                              _reportFormController
                                                  .onChangePlace(s);

                                              if (s.length >= 2) {
                                                // debugPrint("Search: $s");
                                                getPredictPlace(s).then((p) {
                                                  setState(() {
                                                    _predictions = p;
                                                  });
                                                });
                                              }
                                            },
                                            focusNode: _focusNodeOfPlace,
                                            decoration: _reportFormController
                                                    .placeError
                                                ? InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            bottom: 4),
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                    hintText: _placeHint,
                                                    hintStyle: const TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                    errorText:
                                                        "At least 2 characters, and must select one of the place below.",
                                                  )
                                                : InputDecoration.collapsed(
                                                    hintText: _placeHint,
                                                    hintStyle: const TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),

                                          if (kIsWeb)
                                            const SizedBox(
                                              height: 4,
                                            )
                                          else
                                            Container(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // Flex Spacer
                                const Spacer(),
                              ],
                            ),

                            // Fixed Spacer
                            const SizedBox(
                              height: 24,
                            ),

                            // Enter Symptom Section
                            Row(
                              children: [
                                // Flex Spacer
                                const Spacer(),

                                Expanded(
                                  flex: 21,
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      _focusNodeOfSymptom.requestFocus();
                                    },
                                    child: Container(
                                      height: _reportFormController.symptomError
                                          ? 200
                                          : 176,
                                      padding: const EdgeInsets.all(12),
                                      decoration: _formBoxDecoration,
                                      child: Column(
                                        children: [
                                          // Title
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Symptom*",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: _colorThemeController
                                                    .colorTheme.color4,
                                              ),
                                            ),
                                          ),

                                          if (kIsWeb)
                                            const SizedBox(
                                              height: 14,
                                            )
                                          else
                                            const SizedBox(
                                              height: 13,
                                            ),

                                          // Enter Symptom
                                          NoScrollbar(
                                            child: TextFormField(
                                              controller: _reportFormController
                                                  .symptonController,
                                              onChanged: _reportFormController
                                                  .onChangeSymptom,
                                              maxLines: 5,
                                              focusNode: _focusNodeOfSymptom,
                                              cursorColor: Colors.grey,
                                              decoration: _reportFormController
                                                      .symptomError
                                                  ? InputDecoration(
                                                      isDense: true,
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                              bottom: 4),
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      hintText: _symptomHint,
                                                      hintStyle:
                                                          const TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                      errorText:
                                                          "At least 15 characters.",
                                                    )
                                                  : InputDecoration.collapsed(
                                                      hintText: _symptomHint,
                                                      hintStyle:
                                                          const TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),

                                          if (kIsWeb)
                                            const SizedBox(
                                              height: 4,
                                            )
                                          else
                                            Container(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // Flex Spacer
                                const Spacer(),
                              ],
                            ),

                            // Fixed Spacer
                            const SizedBox(
                              height: 24,
                            ),
                          ],
                        ),
                        if (_predictions.predictions == null ||
                            _predictions.predictions.isEmpty)
                          Container(
                            height: 10,
                          )
                        else
                          SizedBox(
                            height: 295,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                    Container(
                                      height: 70,
                                    )
                                  ] +
                                  _predictions.predictions
                                      .map((Predictions predictedPlace) {
                                    return Row(
                                      children: [
                                        const Spacer(),
                                        Expanded(
                                          flex: 16,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                Get.focusScope.unfocus();
                                                _reportFormController
                                                    .onChangePlace(
                                                  "${predictedPlace.structuredFormatting.mainText} - ${predictedPlace.structuredFormatting.secondaryText}",
                                                );
                                                _reportFormController
                                                    .setPlaceID(
                                                  predictedPlace.placeId,
                                                );
                                                _reportFormController
                                                        .placeController.text =
                                                    "${predictedPlace.structuredFormatting.mainText} - ${predictedPlace.structuredFormatting.secondaryText}";
                                                _predictions = PredictedPlace();
                                              });
                                            },
                                            child: Container(
                                              height: 45,
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                  "${predictedPlace.structuredFormatting.mainText} - ${predictedPlace.structuredFormatting.secondaryText}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    );
                                  }).toList(),
                            ),
                          )
                      ],
                    ),

                    // Upload Photo Section
                    Row(
                      children: [
                        // Flex Spacer
                        const Spacer(),

                        Expanded(
                          flex: 21,
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            child: Container(
                              height: 145,
                              padding: const EdgeInsets.all(12),
                              decoration: _formBoxDecoration,
                              child: Column(
                                children: [
                                  // Upload Food Photos
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Upload Food Photos",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: _colorThemeController
                                            .colorTheme.color4,
                                      ),
                                    ),
                                  ),

                                  // Fixed Spacer
                                  const SizedBox(
                                    height: 14,
                                  ),

                                  // Photos
                                  SizedBox(
                                    height: 80,
                                    child: NoScrollbar(
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _photos.length,
                                        itemBuilder: (context, index) {
                                          return _photos[index];
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const SizedBox(
                                            width: 7.5,
                                          );
                                        },
                                        physics: const BouncingScrollPhysics(),
                                      ),
                                    ),
                                  ),

                                  // Fixed Spacer
                                  const SizedBox(
                                    height: 4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Flex Spacer
                        const Spacer(),
                      ],
                    ),

                    // Fixed Spacer
                    const SizedBox(
                      height: 24,
                    ),

                    // Enter Note Section
                    Row(
                      children: [
                        // Flex Spacer
                        const Spacer(),

                        Expanded(
                          flex: 21,
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              _focusNodeOfNote.requestFocus();
                            },
                            child: Container(
                              height: 75,
                              padding: const EdgeInsets.all(12),
                              decoration: _formBoxDecoration,
                              child: Column(
                                children: [
                                  // Title
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Note",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: _colorThemeController
                                            .colorTheme.color4,
                                      ),
                                    ),
                                  ),

                                  // Flex Spacer
                                  const Spacer(),

                                  // Enter Note
                                  TextFormField(
                                    controller:
                                        _reportFormController.noteController,
                                    onChanged:
                                        _reportFormController.onChangeNote,
                                    focusNode: _focusNodeOfNote,
                                    cursorColor: Colors.grey,
                                    decoration: InputDecoration.collapsed(
                                      hintText: _noteHint,
                                      hintStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),

                                  if (kIsWeb)
                                    const SizedBox(
                                      height: 4,
                                    )
                                  else
                                    const SizedBox(
                                      height: 2,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Flex Spacer
                        const Spacer(),
                      ],
                    ),

                    // Fixed Spacer
                    const SizedBox(
                      height: 24,
                    ),

                    Row(
                      children: [
                        // Flex Spacer
                        const Spacer(),

                        Expanded(
                          flex: 21,
                          child: Container(
                            decoration: _formBoxDecoration,
                            height: 60,
                            child: TextButton(
                              style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                    const EdgeInsets.symmetric(vertical: 16)),
                                backgroundColor: MaterialStateProperty.all<
                                        Color>(
                                    _colorThemeController.colorTheme.color4),
                              ),
                              onPressed: () async {
                                _mainScreenController.isLoading = true;

                                if (_reportFormController.titleError ||
                                    _reportFormController
                                        .reportForm.titleText.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    textSnackBar(
                                      context,
                                      "Please complete the title field.",
                                    ),
                                  );

                                  _mainScreenController.isLoading = false;

                                  return;
                                } else if (_reportFormController
                                    .reportForm.dateText.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    textSnackBar(
                                      context,
                                      "Please complete the occur date.",
                                    ),
                                  );

                                  _mainScreenController.isLoading = false;

                                  return;
                                } else if (_reportFormController
                                    .reportForm.timeText.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    textSnackBar(
                                      context,
                                      "Please complete the occur time.",
                                    ),
                                  );

                                  _mainScreenController.isLoading = false;

                                  return;
                                } else if (_reportFormController.placeError ||
                                    _reportFormController
                                        .reportForm.placeText.isEmpty ||
                                    _reportFormController
                                        .reportForm.placeID.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    textSnackBar(
                                      context,
                                      "Please complete the occur place.",
                                    ),
                                  );

                                  _mainScreenController.isLoading = false;

                                  return;
                                } else if (_reportFormController.symptomError ||
                                    _reportFormController
                                        .reportForm.symptomText.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    textSnackBar(
                                      context,
                                      "Please complete the symptom field.",
                                    ),
                                  );

                                  _mainScreenController.isLoading = false;

                                  return;
                                }

                                final String submitLog =
                                    await submitNewReport();

                                if (submitLog == "success") {
                                  final UserInfoController userInfoController =
                                      Get.find<UserInfoController>();
                                  userInfoController.reportCount =
                                      userInfoController.reportCount + 1;

                                  setState(() {
                                    reset();
                                    _reportFormController.reset();
                                  });

                                  Get.focusScope.unfocus();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    textSnackBar(
                                      context,
                                      "Thanks for your report.",
                                    ),
                                  );

                                  _mainScreenController.isLoading = false;
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    textSnackBar(
                                      context,
                                      // ignore: avoid_escaping_inner_quotes
                                      "Submit failed due to \"$submitLog \".",
                                    ),
                                  );

                                  _mainScreenController.isLoading = false;

                                  return;
                                }
                              },
                              child: const Text(
                                "SUBMIT",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  letterSpacing: 1.05,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Flex Spacer
                        const Spacer(),
                      ],
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
