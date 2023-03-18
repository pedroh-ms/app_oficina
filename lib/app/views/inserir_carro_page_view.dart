import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:searchfield/searchfield.dart';

import '../controllers/inserir_carro_page_controller.dart';
import '../models/dono_model.dart';

class InserirCarroPage extends StatefulWidget {
  
  final List<DonoModel>? donos;

  InserirCarroPage({this.donos});

  @override
  InserirCarroPageState createState() => InserirCarroPageState(donos: donos);
}

class InserirCarroPageState extends State<InserirCarroPage> {
  
  String nome = '';
  String cor = '';
  late DonoModel dono;
  List<DonoModel>? donos;

  InserirCarroPageState({this.donos});

  final _inserirCarroPageController = InserirCarroPageController();

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
                onChanged: (text) {
                  nome = text;
                },
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                onChanged: (text) {
                  cor = text;
                },
                decoration: InputDecoration(
                  labelText: 'Cor',
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(
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
                searchInputDecoration: InputDecoration(
                  labelText: 'Dono',
                  border: OutlineInputBorder()
                ),
                onSuggestionTap: (e) {
                  dono = e.item as DonoModel;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  final ret = await _inserirCarroPageController.inserir({
                    'nome': nome,
                    'cor': cor,
                    'dono': dono.id
                  });
                },
                child: Text('Inserir')
              )
            ],
          ),
        )
      )
    );
  }
}