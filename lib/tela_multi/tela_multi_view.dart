import 'package:dm_flutter/homepage_controller.dart';
import 'package:dm_flutter/tela_multi/tela_multi_controller.dart';
import 'package:flutter/material.dart';

class TelaMulti extends StatefulWidget {
  final HomepageController homeController;
  TelaMulti({Key? key, required this.homeController}) : super(key: key);

  final TextEditingController productController = TextEditingController();

  @override
  State<TelaMulti> createState() => _TelaMultiState();
}

class _TelaMultiState extends State<TelaMulti> {
  TelaMultiController telaMultiController = TelaMultiController();

  final GlobalKey<FormFieldState> _keyDropVersao = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _keyDropBuild = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _keyDropBuildName =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _keyDropTypeUser =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _keyDropReleaseCid =
      GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        SizedBox(
          width: 150,
          height: 40,
          child: TextField(
            onSubmitted: ((value) async {
              await telaMultiController.getListAndroidVersions(value);
              _keyDropVersao.currentState!.reset();
              setState(() {});
            }),
            controller: widget.productController,
            decoration: const InputDecoration(
              label: Text('Produto'),
              border: OutlineInputBorder(), // Borda quadrada
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 170,
          height: 40,
          child: DropdownButtonFormField<String>(
            key: _keyDropVersao,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration.collapsed(hintText: 'Versão'),
            hint: const Text('Versão'),
            isExpanded: true,
            items: telaMultiController.listAndroidVersion
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList(),
            onChanged: (androidVersao) async {
              _keyDropBuild.currentState!.reset();
              if (androidVersao != null) {
                await telaMultiController.getListOfBuilds(
                    widget.productController.text, androidVersao);
              }
              setState(() {});
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 170,
          height: 40,
          child: DropdownButtonFormField<String>(
            key: _keyDropBuild,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration.collapsed(hintText: 'Build'),
            hint: const Text('Build'),
            isExpanded: true,
            items: telaMultiController.listBuilds
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList(),
            onChanged: (buildVersion) async {
              _keyDropBuildName.currentState!.reset();
              await telaMultiController.getListOfBuildName(
                  widget.productController.text,
                  _keyDropVersao.currentState!.value,
                  buildVersion!);
              setState(() {});
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 170,
          height: 40,
          child: DropdownButtonFormField<String>(
            key: _keyDropBuildName,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration.collapsed(hintText: 'Build name'),
            hint: const Text('Build name'),
            isExpanded: true,
            items: telaMultiController.listBuildName
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList(),
            onChanged: (buildName) async {
              _keyDropTypeUser.currentState!.reset();
              await telaMultiController.getListOfTypeUser(
                  widget.productController.text,
                  _keyDropVersao.currentState!.value,
                  _keyDropBuild.currentState!.value,
                  buildName!);
              setState(() {});
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 170,
          height: 40,
          child: DropdownButtonFormField<String>(
            key: _keyDropTypeUser,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration.collapsed(hintText: 'Type user'),
            hint: const Text('Type user'),
            isExpanded: true,
            items: telaMultiController.listTypeUser
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList(),
            onChanged: (typeUser) async {
              _keyDropReleaseCid.currentState!.reset();
              await telaMultiController.getListOfReleaseCid(
                  widget.productController.text,
                  _keyDropVersao.currentState!.value,
                  _keyDropBuild.currentState!.value,
                  _keyDropBuildName.currentState!.value,
                  typeUser!);
              setState(() {});
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 170,
          height: 40,
          child: DropdownButtonFormField<String>(
            key: _keyDropReleaseCid,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration:
                const InputDecoration.collapsed(hintText: 'Release Cid'),
            hint: const Text('Release Cid'),
            isExpanded: true,
            items: telaMultiController.listReleaseCid
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList(),
            onChanged: (releaseCid) async {
              await telaMultiController.getFastbootFileName(
                  widget.productController.text,
                  _keyDropVersao.currentState!.value,
                  _keyDropBuild.currentState!.value,
                  _keyDropBuildName.currentState!.value,
                  _keyDropTypeUser.currentState!.value,
                  releaseCid!);
              setState(() {});
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(
            onPressed: !telaMultiController.fastbootExists
                ? null
                : () {
                    telaMultiController.downloadFile(
                      widget.productController.text,
                      _keyDropVersao.currentState!.value,
                      _keyDropBuild.currentState!.value,
                      _keyDropBuildName.currentState!.value,
                      _keyDropTypeUser.currentState!.value,
                      _keyDropReleaseCid.currentState!.value,
                    );
                  },
            child: const Text('Baixar build')),
        const SizedBox(
          height: 20,
        ),
        TextButton(
            onPressed: () {
              telaMultiController.extractBuild();
            },
            child: const Text('extrair build')),
        TextButton(
            onPressed: () {
              telaMultiController.flashDevices(widget.homeController.listOfSelectedDevices);
            },
            child: const Text('Flash devices selecionados')),
        TextButton(
            onPressed: () {
              telaMultiController.baixarExtrairFlashar(widget.productController.text,
                      _keyDropVersao.currentState!.value,
                      _keyDropBuild.currentState!.value,
                      _keyDropBuildName.currentState!.value,
                      _keyDropTypeUser.currentState!.value,
                      _keyDropReleaseCid.currentState!.value, widget.homeController.listOfSelectedDevices);
            },
            child: const Text('baixar flashar e extrair (todos os campos precisam estar preenchidos e válidos)')),
      ]),
    );
  }
}
