// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:xml/xml.dart';

Future<List<String>> getCountyNames() async {
  final List<String> countyNames = [
    "Taipei City",
    "Taichung City",
    "Keelung City",
    "Tainan City",
    "Kaohsiung City",
    "New Taipei City",
    "Yilan County",
    "Taoyuan City",
    "Chiayi City",
    "Hsinchu County",
    "Miaoli County",
    "Nantou County",
    "Changhua County",
    "Hsinchu City",
    "Yunlin County",
    "Chiayi County",
    "Pingtung County",
    "Hualien County",
    "Taitung County",
    "Kinmen County",
    "Penghu County",
    "Lianjiang County",
  ];

  // final http.Response response = await http.get(
  //   Uri.httpss(
  //     'api.nlsc.gov.tw',
  //     'other/ListCounty',
  //   ),
  //   headers: <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     'Accept': 'application/xml; charset=UTF-8',
  //   },
  // );

  // final XmlDocument result = XmlDocument.parse(response.body);
  // result.findAllElements('countyname').forEach((countyName) {
  //   debugPrint(countyName.toString());

  //   countyNames.add(countyName.toString());
  // });

  return countyNames;
}
