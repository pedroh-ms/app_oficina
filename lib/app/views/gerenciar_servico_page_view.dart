import 'package:app_oficina/app/controllers/gerenciar_servico_page_controller.dart';
import 'package:app_oficina/app/models/carro_model.dart';
import 'package:app_oficina/app/models/dono_model.dart';
import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:searchfield/searchfield.dart';

class GerenciarServicoPage extends StatefulWidget {

  final int? id;
  final String? dataEntrega;
  final String? preco;
  final String? observacao;
  final CarroModel? carro;
  final DonoModel? dono;
  final List<CarroModel>? carros;
  final List<DonoModel>? donos;

  GerenciarServicoPage({this.id, this.dataEntrega, this.preco, this.observacao, this.carro, this.dono, this.carros, this.donos});

  @override
  GerenciarServicoPageState createState() => GerenciarServicoPageState(id, dataEntrega, preco, observacao, carro, dono, carros, donos);
}

class GerenciarServicoPageState extends State<GerenciarServicoPage> {

  final _gerenciarServicoPageController = GerenciarServicoPageController();
  
  final _dateController = TextEditingController();
  final _precoController = CurrencyTextFieldController(currencySymbol: 'R\$', decimalSymbol: ',', thousandSymbol: '.');
  final _observacaoController = TextEditingController();
  final _donoSearchFieldController = TextEditingController();
  final _carroSearchFieldController = TextEditingController();

  int? id;
  String dataEntrega = '';
  String preco = '';
  String observacao = '';
  late CarroModel carro;
  List<CarroModel>? carros;
  List<CarroModel>? carrosSF;
  late DonoModel dono;
  List<DonoModel>? donos;
  List<DonoModel>? donosSF;

  GerenciarServicoPageState(int? id, String? dataEntrega, String? preco, String? observacao, CarroModel? carro, DonoModel? dono, List<CarroModel>? carros, List<DonoModel>? donos) {
    this.id = id;
    this.dataEntrega = dataEntrega ?? '';
    this.preco = preco ?? '';
    this.observacao = observacao ?? '';
    _dateController.text = this.dataEntrega;
    _precoController.text = this.preco;
    _observacaoController.text = this.observacao;
    this.carro = carro as CarroModel;
    this.dono = dono as DonoModel;
    this.carros = carros;
    this.donos = donos;

    carrosSF = carros!.where((e) => e.donoId == dono.id).toList();
    donosSF = donos!.where((e) => e.id == carro.donoId).toList();
  }

  @override
  void initState() {
    super.initState();
    
    Future.delayed(Duration.zero, () {
      _carroSearchFieldController.text = carro.nome as String;
      _donoSearchFieldController.text = dono.nome as String;
      print("Hello");
    });
  }

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
                controller: _observacaoController,
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
                initialValue: SearchFieldListItem<DonoModel>(
                  '${dono.id}|${dono.nome}',
                  item: dono,
                  child: Text(dono.nome as String)
                ),
                controller: _donoSearchFieldController,
                //comparator: ,
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
                initialValue: SearchFieldListItem<CarroModel>(
                  '${carro.id}|${carro.nome}',
                  item: carro,
                  child: Text(dono.nome as String)
                ),
                controller: _carroSearchFieldController,
                suggestions: (carrosSF!)
                  .map(
                    (e) => SearchFieldListItem<CarroModel>(
                      '${e.id}|${e.nome}',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final ret = await _gerenciarServicoPageController.salvar({
                        'id': id,
                        'data_entrega': dataEntrega,
                        'preco': preco,
                        'observacao': observacao,
                        'dono_id': dono.id,
                        'carro_id': carro.id
                      });
                    },
                    child: Text('Salvar')
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final ret = await _gerenciarServicoPageController.deletar(id as int);
                    },
                    child: Text('Deletar')
                  )
                ],
              )
            ],
          )
        )
      )
    );
  }
}