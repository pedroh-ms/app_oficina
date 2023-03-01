class DonoModel {
  int? id;
  String? nome;
  String? numeroCelular;

  DonoModel({this.id, this.nome, this.numeroCelular});

  DonoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    numeroCelular = json['numero_celular'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['numero_celular'] = this.numeroCelular;
    return data;
  }
}