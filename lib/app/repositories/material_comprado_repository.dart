
import 'dart:convert';
import 'package:app_oficina/app/globals.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:app_oficina/app/models/material_comprado_model.dart';


class MaterialCompradoRepository {

  final _url = GetIt.I<Globals>().url;
  final _urn = 'api/material_comprados';

  Future<List<MaterialCompradoModel>> get() async {
    final response = await http.get(Uri.http(_url, _urn));
    List<MaterialCompradoModel> donos = (jsonDecode(response.body)['data'] as List).map((json) => MaterialCompradoModel.fromJson(json)).toList();
    return donos;
  }

  Future<void> post(MaterialCompradoModel dono) async {
    var body = dono.toJson();
    body.remove('id');
    await http.post(
      Uri.http(_url, _urn),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, Map>{
        'material_comprado': body
        }
      )
    );
  }

  Future<void> put(MaterialCompradoModel dono) async {
    var body = dono.toJson();
    body.remove('id');
    await http.put(
      Uri.http(_url, '$_urn/${dono.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, Map>{
        'material_comprado': body
        }
      )
    );
  }

  Future<void> delete(int id) async {
    await http.delete(Uri.http(_url, '$_urn/$id'));
  }
}