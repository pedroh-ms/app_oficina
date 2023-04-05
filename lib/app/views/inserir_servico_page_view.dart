import 'package:app_oficina/app/controllers/inserir_servico_page_controller.dart';
import 'package:app_oficina/app/enums/servico_dono_carro_event_enum.dart';
import 'package:app_oficina/app/models/carro_model.dart';
import 'package:app_oficina/app/models/dono_model.dart';
import 'package:app_oficina/app/models/servico_model.dart';
import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:searchfield/searchfield.dart';

class InserirServicoPage extends StatefulWidget {

  final List<DonoModel>? donos;
  final List<CarroModel>? carros;

  const InserirServicoPage({super.key, this.donos, this.carros});

  @override
  InserirServicoPageState createState() => InserirServicoPageState(donos, carros);
}

class InserirServicoPageState extends State<InserirServicoPage> {
  
  final servico = ServicoModel();
  List<CarroModel>? carros;
  List<CarroModel>? carrosSF;
  List<DonoModel>? donos;
  List<DonoModel>? donosSF;

  final _inserirServicoPageController = InserirServicoPageController();
  final _dataEntregaController = TextEditingController();
  final _donoSearchFieldController = TextEditingController();
  final _carroSearchFieldController = TextEditingController();
  final _precoController = CurrencyTextFieldController(currencySymbol: 'R\$', decimalSymbol: ',', thousandSymbol: '.');

  InserirServicoPageState(this.donos, this.carros) {
    carrosSF = carros;
    donosSF = donos;
  }

  Future<void> _showDataEntregaDatePicker() async {
    showDatePicker(
      context: context,
      initialDate: servico.dataEntrega != '' && servico.dataEntrega != null ? DateTime.parse(servico.dataEntrega!) : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101)
    ).then(
      (pickedDate) {
        if (pickedDate == null) return;
        servico.dataEntrega = DateFormat('yyyy-MM-dd').format(pickedDate);
        _dataEntregaController.text = servico.dataEntrega!;
      }
    );
  }

  void _servicoDonoEvent(ServicoDonoCarroEventEnum eventEnum, DonoModel? dono) {
    switch (eventEnum) {
      case ServicoDonoCarroEventEnum.onPressed: {
        _donoSearchFieldController.clear();
        servico.donoId = null;
        setState(() {
          carrosSF = carros;
        });
        break;
      }
      case ServicoDonoCarroEventEnum.onSuggestionTap: {
        servico.donoId = dono!.id;
        setState(() {
          carrosSF = carros!.where((e) => e.donoId == dono.id).toList();
        });
        _donoSearchFieldController.text = dono.nome!;
        break;      
      }
    }
  }

  void _servicoCarroEvent(ServicoDonoCarroEventEnum eventEnum, CarroModel? carro) {
    switch (eventEnum) {
      case ServicoDonoCarroEventEnum.onPressed: {
        _carroSearchFieldController.clear();
        servico.carroId = null;
        setState(() {
          donosSF = donos;
        });
        break;
      }
      case ServicoDonoCarroEventEnum.onSuggestionTap: {
        servico.carroId = carro!.id;
        setState(() {
          donosSF = donos!.where((e) => e.id == carro.donoId).toList();
        });
        _carroSearchFieldController.text = carro.nome!;
      }
    }
  }

  Future<void> _insert() async {
    await _inserirServicoPageController.inserir(servico.toJson());
  }

  @override
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
                controller: _dataEntregaController,
                onChanged: (text) => servico.dataEntrega = text,
                decoration: const InputDecoration(
                  labelText: 'Data da entrega',
                  border: OutlineInputBorder()
                ),
                readOnly: true,
                onTap: () async => await _showDataEntregaDatePicker()
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _precoController,
                maxLength: 11,
                onChanged: (text) => servico.preco = text.replaceAll(RegExp(r'[R$\s.]'), '').replaceFirst(',', '.'),
                decoration: const InputDecoration(
                  labelText: 'Preço',
                  border: OutlineInputBorder(),
                  counterText: ''
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                onChanged: (text) => servico.observacao = text,
                decoration: const InputDecoration(
                  labelText: 'Observação',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
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
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => _servicoDonoEvent(ServicoDonoCarroEventEnum.onPressed, null),
                  )
                ),
                onSuggestionTap: (e) => _servicoDonoEvent(ServicoDonoCarroEventEnum.onSuggestionTap, e.item),
              ),
              const SizedBox(
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
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => _servicoCarroEvent(ServicoDonoCarroEventEnum.onPressed, null)
                  )
                ),
                onSuggestionTap: (e) => _servicoCarroEvent(ServicoDonoCarroEventEnum.onSuggestionTap, e.item),
              ),
              const SizedBox(
                height: 5
              ),
              ElevatedButton(
                onPressed: () async => await _insert(),
                child: const Text('Inserir')
              )
            ],
          )
        )
      )
    );
  }
}