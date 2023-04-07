import 'dart:convert';
import 'package:app_oficina/app/globals.dart';
import 'package:app_oficina/app/models/dono_model.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class DonoRepository {

  final _url = GetIt.I<Globals>().url;
  final _urn = 'api/donos';

  Future<List<DonoModel>> get() async {
    final response = await http.get(Uri.http(_url, _urn));
    List<DonoModel> donos = (jsonDecode(response.body)['data'] as List).map((json) => DonoModel.fromJson(json)).toList();
    return donos;
  }

  Future<void> post(DonoModel dono) async {
    final body = dono.toJson();
    body.remove('id');
    await http.post(
      Uri.http(_url, _urn),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, Map>{
        'dono': body
        }
      )
    );
  }

  Future<void> put(DonoModel dono) async {
    final body = dono.toJson();
    body.remove('id');
    await http.put(
      Uri.http(_url, '$_urn/${dono.id}'),
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
    await http.delete(Uri.http(_url, '$_urn/$id'));
  }
}