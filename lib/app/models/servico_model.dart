class ServicoModel {
  int? carroId;
  String? dataEntrega;
  int? donoId;
  int? id;
  String? observacao;
  String? preco;

  ServicoModel(
      {this.carroId,
      this.dataEntrega,
      this.donoId,
      this.id,
      this.observacao,
      this.preco});

  ServicoModel.fromJson(Map<String, dynamic> json) {
    carroId = json['carro_id'];
    dataEntrega = json['data_entrega'];
    donoId = json['dono_id'];
    id = json['id'];
    observacao = json['observacao'];
    preco = json['preco'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carro_id'] = this.carroId;
    data['data_entrega'] = this.dataEntrega;
    data['dono_id'] = this.donoId;
    data['id'] = this.id;
    data['observacao'] = this.observacao;
    data['preco'] = this.preco;
    return data;
  }
}
