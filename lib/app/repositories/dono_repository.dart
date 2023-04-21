import 'dart:convert';
import 'package:app_oficina/app/globals.dart';
import 'package:app_oficina/app/models/dono_model.dart';
import 'package:app_oficina/app/toast.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class DonoRepository {

  final _url = GetIt.I<Globals>().url;
  final token = GetIt.I<Globals>().token;
  final _urn = 'api/donos';

  void _errorToast({int? code}) {
    String msg = 'Mensagem não definida para o código $code.';
    switch(code) {
      case 401: {
        msg = 'Não autorizado!';
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

  Future<List<DonoModel>> get() async {
    final response = await http.get(
      Uri.http(_url, _urn),
      headers: {
        'Authorization': 'Bearer $token'
      }
    );
    if (response.statusCode == 200) {
      List<DonoModel> donos = (jsonDecode(response.body)['data'] as List).map((json) => DonoModel.fromJson(json)).toList();
      return donos;
    } else {
      _errorToast(code: response.statusCode);
      return [];
    }
  }

  Future<void> post(DonoModel dono) async {
    final body = dono.toJson();
    body.remove('id');
    final response = await http.post(
      Uri.http(_url, _urn),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, Map>{
        'dono': body
        }
      )
    );
    if (response.statusCode == 201) {
      toast('Dono inserido!');
    } else {
      _errorToast(code: response.statusCode);
    }
  }

  Future<void> put(DonoModel dono) async {
    final body = dono.toJson();
    body.remove('id');
    final response = await http.put(
      Uri.http(_url, '$_urn/${dono.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, Map>{
        'dono': body
        }
      )
    );
    if (response.statusCode == 200) {
      toast('Dono alterado!');
    } else {
      _errorToast(code: response.statusCode);
    }
  }

  Future<void> delete(int id) async {
    final response = await http.delete(
      Uri.http(_url, '$_urn/$id'),
      headers: {
        'Authorization': 'Bearer $token'
      }
    );
    if (response.statusCode == 204) {
      toast('Dono removido!');
    } else {
      _errorToast(code: response.statusCode);
    }
  }
}