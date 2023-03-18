import 'package:app_oficina/app/repositories/carro_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  final carroRepository = CarroRepository();

  test('deve trazer uma lista de DonoModel', () async {
    final carros = await carroRepository.getComDonos();
    for(var i = 0; i < carros.length; i++){
      print(carros[i].toJson());
    }
  });
}