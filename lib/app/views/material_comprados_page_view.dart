import 'package:app_oficina/app/controllers/material_comprados_page_controller.dart';
import 'package:app_oficina/app/views/inserir_material_comprado_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MaterialCompradosPage extends StatefulWidget {
  @override
  MaterialCompradosPageState createState() {
    return MaterialCompradosPageState();
  }
}

class MaterialCompradosPageState extends State<MaterialCompradosPage> {

  final _controller = MaterialCompradosPageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Materiais comprados'),
        actions: [
          IconButton(
            onPressed: () {
              _controller.start();
            },
            icon: const Icon(Icons.refresh_outlined)
          )
        ]
      ),
      body: AnimatedBuilder(
        animation: _controller.materialComprados,
        builder: (context, child) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 500,
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
                        label: Text('Dia')
                      ),
                      DataColumn(
                        label: Text('Preço')
                      )
                    ], 
                    rows: (_controller.materialComprados.value.reversed).map(
                      (materialComprado) => DataRow(
                        cells: [
                          DataCell(
                            Text(materialComprado.id.toString())
                          ),
                          DataCell(
                            Text(materialComprado.nome.toString())
                          ),
                          DataCell(
                            Text(materialComprado.dia.toString())
                          ),
                          DataCell(
                            Text(materialComprado.preco.toString())
                          )
                        ]
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
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => InserirMaterialCompradoPage()
          )
        ),
        child: const Icon(Icons.add)
      ),
    );
  }
}