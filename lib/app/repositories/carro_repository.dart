import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:app_oficina/app/models/carro_model.dart';

import '../models/carro_dono_model.dart';

class CarroRepository {

  final _url = '192.168.0.105:4000';
  final _urn = 'api/carros';

  Future<List<CarroModel>> get() async {
    final response = await http.get(Uri.http(_url, _urn));
    List<CarroModel> carros = (jsonDecode(response.body)['data'] as List).map((json) => CarroModel.fromJson(json)).toList();
    return carros;
  }

  Future<List<CarroDonoModel>> getWithDonos() async {
    final response = await http.get(Uri.http(_url, _urn, {'query_type': 'with_donos'}));
    List<CarroDonoModel> carros = (jsonDecode(response.body)['data'] as List).map((json) => CarroDonoModel.fromJson(json)).toList();
    return carros;
  }

  Future<void> post(CarroModel carro) async {
    final body = carro.toJson();
    body.remove('id');
    await http.post(
      Uri.http(_url, _urn),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, Map>{
        'carro': body
        }
      )
    );
  }

  Future<void> put(CarroModel carro) async {
    final body = carro.toJson();
    body.remove('id');
    await http.put(
      Uri.http(_url, '$_urn/${carro.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, Map>{
        'carro': body
        }
      )
    );
  }

  Future<void> delete(int id) async {
    await http.delete(Uri.http(_url, '$_urn/$id'));
  }
}