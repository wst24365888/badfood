import 'package:flutter/material.dart';

class ResponsiveUI {
  Widget mobileUI;
  Widget webUI;

  ResponsiveUI({this.mobileUI, this.webUI});

  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 960) {
      return mobileUI;
    } else {
      return webUI;
    }
  }
}
