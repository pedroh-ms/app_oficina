
import 'dart:convert';
import 'package:app_oficina/app/globals.dart';
import 'package:app_oficina/app/toast.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:app_oficina/app/models/material_comprado_model.dart';


class MaterialCompradoRepository {
  final _url = GetIt.I<Globals>().url;
  final token = GetIt.I<Globals>().token;
  final _urn = 'api/material_comprados';

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

  Future<List<MaterialCompradoModel>> get() async {
    final response = await http.get(
      Uri.http(_url, _urn),
      headers: {
        'Authorization': 'Bearer $token'
      }
    );
    if (response.statusCode == 200) {
      List<MaterialCompradoModel> donos = (jsonDecode(response.body)['data'] as List).map((json) => MaterialCompradoModel.fromJson(json)).toList();
      return donos;
    } else {
      _errorToast(code: response.statusCode);
      return [];
    }
  }

  Future<void> post(MaterialCompradoModel dono) async {
    var body = dono.toJson();
    body.remove('id');
    final response = await http.post(
      Uri.http(_url, _urn),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, Map>{
        'material_comprado': body
        }
      )
    );
    if (response.statusCode == 201) {
      toast('Material comprado inserido!');
    } else {
      _errorToast(code: response.statusCode);
    }
  }

  Future<void> put(MaterialCompradoModel dono) async {
    var body = dono.toJson();
    body.remove('id');
    final response = await http.put(
      Uri.http(_url, '$_urn/${dono.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, Map>{
        'material_comprado': body
        }
      )
    );
    if (response.statusCode == 200) {
      toast('Material comprado alterado!');
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
      toast('Material comprado removido!');
    } else {
      _errorToast(code: response.statusCode);
    }
  }
}