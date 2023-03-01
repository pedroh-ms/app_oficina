import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/dono_model.dart';

class DonoRepository {

  final URL = 'ed6f-177-221-248-246.ngrok.io';
  final URN = 'api/donos';

  Future<List<DonoModel>> get() async {
    final response = await http.get(Uri.http(URL, URN));
    List<DonoModel> donos = (jsonDecode(response.body)['data'] as List).map((json) => DonoModel.fromJson(json)).toList();
    return donos;
  }

  Future<void> post(DonoModel dono) async {
    await http.post(
      Uri.http(URL, URN),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, Map>{
        'dono': <String, String>{
          'nome': dono.nome as String,
          'numero_celular': dono.numeroCelular as String
          }
        }
      )
    );
  }

  Future<void> put(DonoModel dono) async {
    await http.put(
      Uri.http(URL, '$URN/${dono.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, Map>{
        'dono': <String, String>{
          'nome': dono.nome as String,
          'numero_celular': dono.numeroCelular as String
          }
        }
      )
    );
  }

  Future<void> delete(int id) async {
    await http.delete(Uri.http(URL, '$URN/$id'));
  }
}