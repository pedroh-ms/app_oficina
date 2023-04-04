import 'package:app_oficina/app/models/carro_model.dart';

import 'dono_model.dart';

class CarroDonoModel {
  String? cor;
  DonoModel? dono;
  int? id;
  String? nome;

  CarroDonoModel({this.cor, this.dono, this.id, this.nome});

  CarroDonoModel.fromJson(Map<String, dynamic> json) {
    cor = json['cor'];
    dono = json['dono'] != null ? DonoModel.fromJson(json['dono']) : null;
    id = json['id'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cor'] = this.cor;
    if (this.dono != null) {
      data['dono'] = this.dono!.toJson();
    }
    data['id'] = this.id;
    data['nome'] = this.nome;
    return data;
  }

  CarroModel toCarroModel() => CarroModel.fromJson({
    'id': id,
    'nome': nome,
    'cor': cor,
    'dono_id': dono!.id
  });
}