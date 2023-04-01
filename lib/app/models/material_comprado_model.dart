class MaterialCompradoModel {
  String? dia;
  int? id;
  String? nome;
  String? preco;

  MaterialCompradoModel({this.dia, this.id, this.nome, this.preco});

  MaterialCompradoModel.fromJson(Map<String, dynamic> json) {
    dia = json['dia'];
    id = json['id'];
    nome = json['nome'];
    preco = json['preco'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dia'] = this.dia;
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['preco'] = this.preco;
    return data;
  }
}
