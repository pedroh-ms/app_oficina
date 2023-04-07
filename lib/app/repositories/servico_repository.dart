
import 'dart:convert';
import 'package:app_oficina/app/globals.dart';
import 'package:app_oficina/app/models/servico_dono_carro_model.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:app_oficina/app/models/servico_model.dart';


class ServicoRepository {

  final _url = GetIt.I<Globals>().url;
  final _urn = 'api/servicos';

  Future<List<ServicoModel>> get() async {
    final response = await http.get(Uri.http(_url, _urn));
    List<ServicoModel> donos = (jsonDecode(response.body)['data'] as List).map((json) => ServicoModel.fromJson(json)).toList();
    return donos;
  }

  Future<List<ServicoDonoCarroModel>> getWithDonosCarros() async {
    final response = await http.get(Uri.http(_url, _urn, { 'query_type': 'with_donos_carros' }));
    List<ServicoDonoCarroModel> donos = (jsonDecode(response.body)['data'] as List).map((json) => ServicoDonoCarroModel.fromJson(json)).toList();
    return donos;
  }

  Future<void> post(ServicoModel dono) async {
    var body = dono.toJson();
    body.remove('id');
    await http.post(
      Uri.http(_url, _urn),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, Map>{
        'servico': body
        }
      )
    );
  }

  Future<void> put(ServicoModel dono) async {
    var body = dono.toJson();
    body.remove('id');
    await http.put(
      Uri.http(_url, '$_urn/${dono.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, Map>{
        'servico': body
        }
      )
    );
  }

  Future<void> delete(int id) async {
    await http.delete(Uri.http(_url, '$_urn/$id'));
  }
}