import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:searchfield/searchfield.dart';

import '../controllers/inserir_servico_page_controller.dart';
import '../models/carro_model.dart';
import '../models/dono_model.dart';

class InserirServicoPage extends StatefulWidget {

  final List<DonoModel>? donos;
  final List<CarroModel>? carros;

  InserirServicoPage({this.donos, this.carros});

  @override
  InserirServicoPageState createState() => InserirServicoPageState(donos, carros);
}

class InserirServicoPageState extends State<InserirServicoPage> {
  
  String dataEntrega = '';
  String preco = '';
  String observacao = '';
  late CarroModel carro;
  List<CarroModel>? carros;
  List<CarroModel>? carrosSF;
  late DonoModel dono;
  List<DonoModel>? donos;
  List<DonoModel>? donosSF;

  InserirServicoPageState(List<DonoModel>? donos, List<CarroModel>? carros) {
    this.carros = carros;
    this.donos = donos;
    carrosSF = carros;
    donosSF = donos;
  }

  final _inserirServicoPageController = InserirServicoPageController();
  final _dateController = TextEditingController();
  final _donoSearchFieldController = TextEditingController();
  final _carroSearchFieldController = TextEditingController();
  final _precoController = CurrencyTextFieldController(currencySymbol: 'R\$', decimalSymbol: ',', thousandSymbol: '.');

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inserir servico')
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _dateController,
                onChanged: (text) {
                  dataEntrega = text;
                },
                decoration: InputDecoration(
                  labelText: 'Data da entrega',
                  border: OutlineInputBorder()
                ),
                readOnly: true,
                onTap: () {
                  showDatePicker(
                    context: context, 
                    initialDate: dataEntrega == '' ? DateTime.now() : DateTime.parse(dataEntrega),
                     firstDate: DateTime(2000), 
                     lastDate: DateTime(2101)
                  ).then((pickedDate) {
                    if (pickedDate == null) return;
                    dataEntrega = DateFormat('yyyy-MM-dd').format(pickedDate);
                    _dateController.text = dataEntrega;
                  });
                }
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: _precoController,
                maxLength: 11,
                onChanged: (value) {
                  preco = value
                    .replaceAll(RegExp(r'[R$\s.]'), '')
                    .replaceFirst(',', '.');
                },
                decoration: InputDecoration(
                  labelText: 'Preço',
                  border: OutlineInputBorder(),
                  counterText: ''
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                onChanged: (value) {
                  observacao = value;
                },
                decoration: InputDecoration(
                  labelText: 'Observação',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SearchField<DonoModel>(
                controller: _donoSearchFieldController,
                suggestions: (donosSF!)
                  .map(
                    (e) => SearchFieldListItem<DonoModel>(
                      '${e.id.toString()}|${e.nome}',
                      item: e,
                      child: Text(e.nome as String),
                    )
                  ).toList(),
                suggestionState: Suggestion.hidden,
                suggestionAction: SuggestionAction.unfocus,
                searchInputDecoration: InputDecoration(
                  labelText: 'Dono',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _donoSearchFieldController.clear();
                      setState(() {
                        carrosSF = carros;
                      });
                    },
                  )
                ),
                onSuggestionTap: (e) {
                  dono = e.item as DonoModel;
                  setState(() {
                    carrosSF = carros!.where((e) => e.donoId == dono.id).toList();
                  });
                  _donoSearchFieldController.text = dono.nome as String;
                },
              ),
              SizedBox(
                height: 5,
              ),
              SearchField<CarroModel>(
                controller: _carroSearchFieldController,
                suggestions: (carrosSF!)
                  .map(
                    (e) => SearchFieldListItem<CarroModel>(
                      '${e.id.toString()}|${e.nome}',
                      item: e,
                      child: Text(e.nome as String)
                    )
                  ).toList(),
                suggestionState: Suggestion.hidden,
                suggestionAction: SuggestionAction.unfocus,
                searchInputDecoration: InputDecoration(
                  labelText: 'Carro',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _carroSearchFieldController.clear();
                      setState(() {
                        donosSF = donos;
                      });
                    },
                  )
                ),
                onSuggestionTap: (e) {
                  carro = e.item as CarroModel;
                  setState(() {
                    donosSF = donos!.where((e) => e.id == carro.donoId).toList();
                  });
                  _carroSearchFieldController.text = carro.nome as String;
                },
              ),
              SizedBox(
                height: 5
              ),
              ElevatedButton(
                onPressed: () async {
                  final ret = await _inserirServicoPageController.inserir({
                    'id': null,
                    'data_entrega': dataEntrega,
                    'preco': preco,
                    'observacao': observacao,
                    'dono_id': dono.id,
                    'carro_id': carro.id
                  });
                },
                child: Text('Inserir')
              )
            ],
          )
        )
      )
    );
  }
}