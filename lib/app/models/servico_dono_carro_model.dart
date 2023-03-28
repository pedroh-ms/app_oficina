import 'carro_model.dart';
import 'dono_model.dart';

class ServicoDonoCarroModel {
  CarroModel? carro;
  String? dataEntrega;
  DonoModel? dono;
  int? id;
  String? observacao;
  String? preco;

  ServicoDonoCarroModel(
      {this.carro,
      this.dataEntrega,
      this.dono,
      this.id,
      this.observacao,
      this.preco});

  ServicoDonoCarroModel.fromJson(Map<String, dynamic> json) {
    carro = json['carro'] != null ? CarroModel.fromJson(json['carro']) : null;
    dataEntrega = json['data_entrega'];
    dono = json['dono'] != null ? DonoModel.fromJson(json['dono']) : null;
    id = json['id'];
    observacao = json['observacao'];
    preco = json['preco'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.carro != null) {
      data['carro'] = this.carro!.toJson();
    }
    data['data_entrega'] = this.dataEntrega;
    if (this.dono != null) {
      data['dono'] = this.dono!.toJson();
    }
    data['id'] = this.id;
    data['observacao'] = this.observacao;
    data['preco'] = this.preco;
    return data;
  }
}