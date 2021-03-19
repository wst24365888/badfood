// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:xml/xml.dart';

Future<List<String>> getCountyNames() async {
  final List<String> countyNames = [
    "臺北市",
    "臺中市",
    "基隆市",
    "臺南市",
    "高雄市",
    "新北市",
    "宜蘭縣",
    "桃園市",
    "嘉義市",
    "新竹縣",
    "苗栗縣",
    "南投縣",
    "彰化縣",
    "新竹市",
    "雲林縣",
    "嘉義縣",
    "屏東縣",
    "花蓮縣",
    "臺東縣",
    "金門縣",
    "澎湖縣",
    "連江縣",
  ];

  // final http.Response response = await http.get(
  //   Uri.https(
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
