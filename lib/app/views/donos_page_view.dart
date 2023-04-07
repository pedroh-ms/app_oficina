import 'package:app_oficina/app/controllers/donos_page_controller.dart';
import 'package:app_oficina/app/views/gerenciar_dono_page_view.dart';
import 'package:app_oficina/app/views/inserir_dono_page_view.dart';
import 'package:flutter/material.dart';

class DonosPage extends StatefulWidget{
  const DonosPage({super.key});
  
  @override
  DonosPageState createState() => DonosPageState();
}

class DonosPageState extends State<DonosPage> {

  final _controller = DonosPageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donos'),
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
        animation: _controller.donos,
        builder: (context, child) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 700,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  DataTable(
                    columns: const [
                      DataColumn(
                        label: Text('Id')
                      ),
                      DataColumn(
                        label: Text('Nome')
                      ),
                      DataColumn(
                        label: Text('Número do celular')
                      )
                    ],
                    rows: (_controller.donos.value.reversed).map(
                      (dono) => DataRow(
                        cells: [
                          DataCell(
                            Text(dono.id.toString())
                          ),
                          DataCell(
                            Text(dono.nome.toString())
                          ),
                          DataCell(
                            Text(dono.numeroCelular.toString())
                          )
                        ],
                        onSelectChanged: (value) => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => GerenciarDonoPage(dono: dono)
                          )
                        )
                      )).toList(),
                      showCheckboxColumn: false
                    )
                  ],
                ) 
              ) 
            );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const InserirDonoPage()
          )
        ),
        child: const Icon(Icons.add)
      ),
    );
  }
}