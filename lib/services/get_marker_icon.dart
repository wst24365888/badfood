import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<BitmapDescriptor> getMarkerIcon(
  BuildContext context,
  String assetName,
) async {
  // debugPrint("Loading Pin Svg");

  // Read SVG file as String
  final String svgString =
      await DefaultAssetBundle.of(context).loadString(assetName);
  // Create DrawableRoot from SVG String
  final DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, null);

  // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
  const double width = kIsWeb ? 32 : 96;
  const double height = kIsWeb ? 32 : 96;

  // Convert to ui.Picture
  final ui.Picture picture =
      svgDrawableRoot.toPicture(size: const Size(width, height));

  // Convert to ui.Image. toImage() takes width and height as parameters
  // you need to find the best size to suit your needs and take into account the
  // screen DPI
  final ui.Image image = await picture.toImage(width.toInt(), height.toInt());
  final ByteData bytes = await image.toByteData(format: ui.ImageByteFormat.png);

  // debugPrint("Pin Svg Loaded");

  return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
}
