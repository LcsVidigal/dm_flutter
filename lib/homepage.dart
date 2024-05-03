import 'package:dm_flutter/components/card_device.dart';
import 'package:dm_flutter/homepage_controller.dart';
import 'package:dm_flutter/tela_multi/tela_multi_view.dart';
import 'package:dm_flutter/utils.dart';
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
                          color: Colors.white)))
            ]),
          ),
          Expanded(
            child: TelaMulti(homeController: _homepageController,)
          ),
          Container(
            color: const Color.fromARGB(255, 225, 226, 228),
            width: 250,
            height: double.infinity,
            child: devicesDisponiveis(),
          ),
        ],
      ),
    );
  }

  Widget devicesDisponiveis() {
    return Column(
      children: [
        const Text('Devices disponíveis'),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () => loadDevices(),
          child: const Icon(Icons.refresh),
        ),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(6.0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _homepageController
                  .listOfDevices.length, // Número total de itens na lista
              itemBuilder: (BuildContext context, int index) {
                // Retorna um widget para cada item da lista
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _homepageController.deviceSelected =
                          _homepageController.listOfDevices[index];
                      
                    });
                  },
                  child: CardDevice(
                    device: _homepageController.listOfDevices[index],
                    homeController: _homepageController,
                  ),
                );
              }),
        ),
        Text(_homepageController.deviceSelected.barcode ?? 'sem device'),
        GestureDetector(
          onTap: () {
            print(_homepageController.deviceSelected.barcode);
          },
          child: const Icon(Icons.circle),
        ),
      ],
    );
  }
}
