import 'dart:convert';
import 'package:app_oficina/app/globals.dart';
import 'package:app_oficina/app/toast.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class LoginPageController {
  String? usuario;
  String? senha;
  
  void _errorToast({int? code}) {
    String msg = 'Mensagem não definida para o código $code.';
    switch(code) {
      case 401: {
        msg = 'Usuário ou senha inválidos!';
      }
      break;
      case 500: {
        msg = 'Erro interno do servidor.';
      }
      break;
      case null: {
        msg = 'Erro não tratado.';
      }
      break;
      default: break;
    }
    errorToast(msg);
  }

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
        _errorToast(code: response.statusCode);
        return false;
      }
    } catch (e) {
      errorToast(e.toString());
      return false;
    }
    // return (usuario == 'pedrohms' && senha == '1234');
  }
}