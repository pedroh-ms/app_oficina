import 'dart:convert';
import 'package:app_oficina/app/globals.dart';
import 'package:app_oficina/app/models/carro_dono_model.dart';
import 'package:app_oficina/app/toast.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:app_oficina/app/models/carro_model.dart';


class CarroRepository {

  final _url = GetIt.I<Globals>().url;
  final token = GetIt.I<Globals>().token;
  final _urn = 'api/carros';

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

  Future<List<CarroModel>> get() async {
    final response = await http.get(
      Uri.http(_url, _urn),
      headers: {
        'Authorization': 'Bearer $token',
      }
    );
    if (response.statusCode == 200) {
      List<CarroModel> carros = (jsonDecode(response.body)['data'] as List).map((json) => CarroModel.fromJson(json)).toList();
      return carros;
    } else {
      _errorToast(code: response.statusCode);
      return [];
    }
  }

  Future<List<CarroDonoModel>> getWithDonos() async {
    final response = await http.get(
      Uri.http(_url, _urn, {'query_type': 'with_donos'}),
      headers: {
        'Authorization': 'Bearer $token'
      }
    );
    if (response.statusCode == 200) {
      List<CarroDonoModel> carros = (jsonDecode(response.body)['data'] as List).map((json) => CarroDonoModel.fromJson(json)).toList();
      return carros;
    } else {
      _errorToast(code: response.statusCode);
      return [];
    }
  }

  Future<void> post(CarroModel carro) async {
    final body = carro.toJson();
    body.remove('id');
    final response = await http.post(
      Uri.http(_url, _urn),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, Map>{
        'carro': body
        }
      )
    );
    if (response.statusCode == 201) {
      toast('Carro inserido!');
    } else {
      _errorToast(code: response.statusCode);
    }
  }

  Future<void> put(CarroModel carro) async {
    final body = carro.toJson();
    body.remove('id');
    final response = await http.put(
      Uri.http(_url, '$_urn/${carro.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, Map>{
        'carro': body
        }
      )
    );
    if (response.statusCode == 200) {
      toast('Carro alterado!');
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
      toast('Carro removido!');
    } else {
      _errorToast(code: response.statusCode);
    }
  }
}