class CarroModel {
  String? cor;
  int? donoId;
  int? id;
  String? nome;

  CarroModel({this.cor, this.donoId, this.id, this.nome});

  CarroModel.fromJson(Map<String, dynamic> json) {
    cor = json['cor'];
    donoId = json['dono_id'];
    id = json['id'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cor'] = this.cor;
    data['dono_id'] = this.donoId;
    data['id'] = this.id;
    data['nome'] = this.nome;
    return data;
  }
}
