
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:app_oficina/app/models/servico_model.dart';

import '../models/servico_dono_carro_model.dart';

class ServicoRepository {

  final URL = '192.168.0.105:4000';
  final URN = 'api/servicos';

  Future<List<ServicoModel>> get() async {
    final response = await http.get(Uri.http(URL, URN));
    List<ServicoModel> donos = (jsonDecode(response.body)['data'] as List).map((json) => ServicoModel.fromJson(json)).toList();
    return donos;
  }

  Future<List<ServicoDonoCarroModel>> getWithDonosCarros() async {
    final response = await http.get(Uri.http(URL, URN, { 'query_type': 'with_donos_carros' }));
    List<ServicoDonoCarroModel> donos = (jsonDecode(response.body)['data'] as List).map((json) => ServicoDonoCarroModel.fromJson(json)).toList();
    return donos;
  }

  Future<void> post(ServicoModel dono) async {
    var body = dono.toJson();
    body.remove('id');
    await http.post(
      Uri.http(URL, URN),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, Map>{
        'dono': body
        }
      )
    );
  }

  Future<void> put(ServicoModel dono) async {
    var body = dono.toJson();
    body.remove('id');
    await http.put(
      Uri.http(URL, '$URN/${dono.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, Map>{
        'dono': body
        }
      )
    );
  }

  Future<void> delete(int id) async {
    await http.delete(Uri.http(URL, '$URN/$id'));
  }
}