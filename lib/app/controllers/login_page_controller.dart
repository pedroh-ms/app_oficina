import 'dart:convert';

import 'package:app_oficina/app/globals.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class LoginPageController {

  String? usuario;
  String? senha;
  
  Future<bool> permitirLogin() async {
    try {
      final response = await http.post(
        Uri.http(GetIt.I<Globals>().url, 'api/session/new'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String?>{
          'nick_name': usuario,
          'password': senha
          }
        )
      );
      if (response.statusCode == 201) {
        GetIt.I<Globals>().token = jsonDecode(response.body)['access_token'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
    // return (usuario == 'pedrohms' && senha == '1234');
  }
}