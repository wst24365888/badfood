// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:xml/xml.dart';

Future<List<Map<String, String>>> getCountyNames() async {
  final List<Map<String, String>> countyNames = [
    {
      "display_name": "Taipei City",
      "county_name": "台北市",
    },
    {
      "display_name": "Taichung City",
      "county_name": "台中市",
    },
    {
      "display_name": "Keelung City",
      "county_name": "基隆市",
    },
    {
      "display_name": "Tainan City",
      "county_name": "台南市",
    },
    {
      "display_name": "Kaohsiung City",
      "county_name": "高雄市",
    },
    {
      "display_name": "New Taipei City",
      "county_name": "新北市",
    },
    {
      "display_name": "Yilan County",
      "county_name": "宜蘭縣",
    },
    {
      "display_name": "Taoyuan City",
      "county_name": "桃園市",
    },
    {
      "display_name": "Chiayi City",
      "county_name": "嘉義市",
    },
    {
      "display_name": "Hsinchu County",
      "county_name": "新竹縣",
    },
    {
      "display_name": "Miaoli County",
      "county_name": "苗栗縣",
    },
    {
      "display_name": "Nantou County",
      "county_name": "南投縣",
    },
    {
      "display_name": "Changhua County",
      "county_name": "彰化縣",
    },
    {
      "display_name": "Hsinchu City",
      "county_name": "新竹市",
    },
    {
      "display_name": "Yunlin County",
      "county_name": "雲林縣",
    },
    {
      "display_name": "Chiayi County",
      "county_name": "嘉義縣",
    },
    {
      "display_name": "Pingtung County",
      "county_name": "屏東縣",
    },
    {
      "display_name": "Hualien County",
      "county_name": "花蓮縣",
    },
    {
      "display_name": "Taitung County",
      "county_name": "台東縣",
    },
    {
      "display_name": "Kinmen County",
      "county_name": "金門縣",
    },
    {
      "display_name": "Penghu County",
      "county_name": "澎湖縣",
    },
    {
      "display_name": "Lianjiang County",
      "county_name": "連江縣",
    },
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
