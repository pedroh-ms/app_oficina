import 'package:app_oficina/app/controllers/servicos_page_controller.dart';
import 'package:app_oficina/app/models/carro_model.dart';
import 'package:app_oficina/app/models/dono_model.dart';
import 'package:app_oficina/app/models/servico_dono_carro_model.dart';
import 'package:app_oficina/app/views/gerenciar_servico_page_view.dart';
import 'package:app_oficina/app/views/inserir_servico_page_view.dart';
import 'package:flutter/material.dart';

class ServicosPage extends StatefulWidget {
  const ServicosPage({super.key});

  @override
  ServicosPageState createState() {
    return ServicosPageState();
  }
}

class ServicosPageState extends State<ServicosPage> {

  final _controller = ServicosPageController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _manage(ServicoDonoCarroModel servico) async {
    Future.wait([_controller.getDonos(), _controller.getCarros()]).then(
      (value) {
        final donos = value[0].map((e) => e as DonoModel).toList();
        final carros = value[1].map((e) => e as CarroModel).toList();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GerenciarServicoPage(
              servico: servico,
              carros: carros,
              donos: donos
            )
          )
        );   
      }
    );
  }

  Future<void> _add() async {
    Future.wait([_controller.getDonos(), _controller.getCarros()]).then(
      (value) {
        final donos = value[0].map((e) => e as DonoModel).toList();
        final carros = value[1].map((e) => e as CarroModel).toList();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => InserirServicoPage(
              donos: donos, 
              carros: carros
            )
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicos'),
        actions: [
          IconButton(
            onPressed: () {
              _controller.start();
            }, 
            icon: const Icon(Icons.refresh_outlined)
          )
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller.servicos,
        builder: (context, child) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 1000,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  DataTable(
                    columns: const [
                      DataColumn(
                        label: Text('Id')
                      ),
                      DataColumn(
                        label: Text('Data da entrega')
                      ),
                      DataColumn(
                        label: Text('Preço')
                      ),
                      DataColumn(
                        label: Text('Observação')
                      ),
                      DataColumn(
                        label: Text('Dono')
                      ),
                      DataColumn(
                        label: Text('Carro')
                      )
                    ], 
                    rows: (_controller.servicos.value.reversed).map(
                      (servico) => DataRow(
                        cells: [
                          DataCell(
                            Text(servico.id.toString())
                          ),
                          DataCell(
                            Text(servico.dataEntrega.toString())
                          ),
                          DataCell(
                            Text(servico.preco.toString())
                          ),
                          DataCell(
                            Text(servico.observacao.toString())
                          ),
                          DataCell(
                            Text(servico.dono!.nome.toString())
                          ),
                          DataCell(
                            Text(servico.carro!.nome.toString())
                          )
                        ],
                        onSelectChanged: (_) async => await _manage(servico)
                      )
                    ).toList(),
                    showCheckboxColumn: false,
                  )
                ],
              )
            )
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await _add(),
        child: const Icon(Icons.add),
      ),
    );
  }
}