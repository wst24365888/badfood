import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> signIn(String idToken) async {
  final http.Response response = await http.post(
    Uri.http('localhost:8080', 'v1/auth/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, String>{
        'firebase_token': idToken,
      },
    ),
  );

  final Map<String, dynamic> result =
      jsonDecode(response.body) as Map<String, dynamic>;

  return result["access_token"].toString();
}
