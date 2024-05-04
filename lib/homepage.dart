import 'package:dm_flutter/components/card_device.dart';
import 'package:dm_flutter/homepage_controller.dart';
import 'package:dm_flutter/services/preferences.dart';
import 'package:dm_flutter/tela_multi/tela_multi_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomepageController _homepageController = HomepageController();

  @override
  void initState() {
    loadDevices();
    super.initState();
  }

  loadDevices() async {
    await _homepageController.getDevices();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 180,
            height: double.infinity,
            color: Colors.red,
            child: Column(children: [
              TextButton(
                  onPressed: () {},
                  child: const Text('MultiFlash',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white))),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    _homepageController.getDevices();
                  },
                  child: const Text('Scripts',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white))),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () async {
                    String? selectedDirectory =
                        await FilePicker.platform.getDirectoryPath();
                    if (selectedDirectory != null) {
                      Preferences().setDownloadDefaultFolder(selectedDirectory);
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Default folder',
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white)),
                      Icon(Icons.folder)
                    ],
                  ))
            ]),
          ),
          Expanded(
              child: TelaMulti(
            homeController: _homepageController,
          )),
          devicesDisponiveis(),
        ],
      ),
    );
  }

  Widget devicesDisponiveis() {
    return Container(
      color: const Color.fromARGB(255, 225, 226, 228),
      width: 320,
      height: double.infinity,
      child: Column(
        children: [
          const Text('Devices disponíveis'),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () => loadDevices(),
            child: const Icon(Icons.refresh),
          ),
          Text('Devices selecionados: ${_homepageController.listOfSelectedDevices.length}'),

          Expanded(
            child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _homepageController
                    .listOfDevices.length, // Número total de itens na lista
                itemBuilder: (BuildContext context, int index) {
                  // Retorna um widget para cada item da lista
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        // Muda o status do device para selecionado ou não-selecionado
                        _homepageController
                                .listOfDevices[index].deviceSelecionado =
                            !_homepageController
                                .listOfDevices[index].deviceSelecionado;

                        _homepageController.popularListaDeDevicesSelecionados();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: CardDevice(
                        device: _homepageController.listOfDevices[index],
                        homeController: _homepageController,
                      ),
                    ),
                  );
                }),
          ),

        ],
      ),
    );
  }
}
