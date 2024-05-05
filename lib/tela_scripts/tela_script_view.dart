import 'package:dm_flutter/homepage_controller.dart';
import 'package:dm_flutter/tela_scripts/tela_script_controller.dart';
import 'package:flutter/material.dart';

class TelaScripts extends StatefulWidget {
  final HomepageController homeController;
  const TelaScripts({Key? key, required this.homeController}) : super(key: key);

  @override
  State<TelaScripts> createState() => _TelaScriptsState();
}

class _TelaScriptsState extends State<TelaScripts> {
  TelaScriptsController telaScriptsController = TelaScriptsController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Execute script nos devices'),
              const SizedBox(
                height: 15,
              ),
              FilledButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  onPressed: () {
                    telaScriptsController.erase(widget.homeController.listOfSelectedDevices);
                  },
                  child: const Text('Erase'))
            ]));
  }
}
