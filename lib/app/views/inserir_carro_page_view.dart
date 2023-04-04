import 'package:app_oficina/app/controllers/inserir_carro_page_controller.dart';
import 'package:app_oficina/app/models/carro_model.dart';
import 'package:app_oficina/app/models/dono_model.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';


class InserirCarroPage extends StatefulWidget {
  
  final List<DonoModel>? donos;

  const InserirCarroPage({super.key, this.donos});

  @override
  InserirCarroPageState createState() => InserirCarroPageState(donos: donos);
}

class InserirCarroPageState extends State<InserirCarroPage> {
  
  final carro = CarroModel();
  List<DonoModel>? donos;

  final _inserirCarroPageController = InserirCarroPageController();

  InserirCarroPageState({this.donos});

  Future<void> _insert() async {
    await _inserirCarroPageController.insert(carro.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inserir carro')
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (text) => carro.nome = text,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                onChanged: (text) => carro.cor = text,
                decoration: const InputDecoration(
                  labelText: 'Cor',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SearchField<DonoModel>(
                suggestions: (donos!)
                  .map(
                    (e) => SearchFieldListItem<DonoModel>(
                      e.nome as String,
                      item: e,
                      child: Text(e.nome as String)
                    )
                  ).toList(),
                searchInputDecoration: const InputDecoration(
                  labelText: 'Dono',
                  border: OutlineInputBorder()
                ),
                onSuggestionTap: (e) => carro.donoId = e.item!.id,
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () async => await _insert(),
                child: const Text('Inserir')
              )
            ],
          ),
        )
      )
    );
  }
}