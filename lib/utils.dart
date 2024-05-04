import 'dart:io';

import 'package:dm_flutter/models/device_model.dart';

Future<String> callCommand(String command, String? directory) async {
  ProcessResult resultado = await Process.run('$command 2>&1', [],
      runInShell: true, workingDirectory: directory);

  return resultado.stdout;
}

class DeviceFunctions {
  Future<List<DeviceModel>> getAllDevicesInFastboot() async {
    String response = await callCommand('fastboot devices', null);
    List<String> listAux = response.split("\n");
    listAux.removeLast();

    List<String> listBarcodes = listAux
        .map((value) => value.replaceAll('fastboot', '').trim())
        .toList();

    List<DeviceModel> listDevices = List<DeviceModel>.empty(growable: true);

    DeviceModel device;
    await Future.forEach<String>(listBarcodes, (item) async {
      device = await DeviceFunctions().getDeviceInfo(item);
      listDevices.add(device);
    });

    return listDevices;
  }

  // Executa um getvar all no barcode enviado e retorna um objeto DeviceModel
  Future<DeviceModel> getDeviceInfo(barcode) async {
    String response =
        await callCommand('fastboot getvar all -s $barcode', null);
    String aux = response.replaceAll('(bootloader) ', '');
    List<String> listAux = aux.split("\n");
    listAux.removeWhere((element) => !element.contains(':'));
    listAux.removeLast();

    Map<String, dynamic> mapa = {};

    for (String item in listAux) {
      List<String> partes = item.split(':');
      if (partes.length >= 2) {
        mapa[partes[0]] = partes.sublist(1).join().trim();
      }
    }

    DeviceModel deviceInfo = DeviceModel.fromJson(mapa);

    return deviceInfo;
  }
}

class ArtifactoryFunctions {
  List<String> getVersoesAndroid(String texto) {
    List<String> links = [];

    RegExp regex = RegExp(r'<a href="([^"]+)">');
    Iterable<Match> matches = regex.allMatches(texto);

    for (Match match in matches) {
      if (match.groupCount >= 1) {
        links.add(match.group(1)!);
      }
    }
    return links;
  }

  List<String> getBuilds(String texto) {
    List<String> links = [];

    RegExp regex = RegExp(r'<a href="([^"]+)">([^<]+)</a>');
    Iterable<Match> matches = regex.allMatches(texto);

    for (Match match in matches) {
      if (match.groupCount >= 1) {
        links.add(match.group(1)!);
      }
    }

    links.removeAt(0);

    return links;
  }

  List<String> getBuildName(String texto) {
    // Criando uma expressão regular para encontrar os nomes dos diretórios
    RegExp regExp = RegExp(r'<a href="([^"]+)">([^<]+)</a>');
    // Encontrar todas as correspondências na string HTML fornecida
    Iterable<RegExpMatch> matches = regExp.allMatches(texto);

    // Extrair os nomes dos diretórios das correspondências
    List<String> directoryNames = [];
    for (final match in matches) {
      directoryNames.add(match.group(1) ?? "");
    }

    directoryNames.removeAt(0);

    return directoryNames;
  }

  List<String> getTypeUser(String texto) {
    // Criando uma expressão regular para encontrar os nomes dos diretórios
    RegExp regExp = RegExp(r'<a href="([^"]+)">([^<]+)</a>');
    // Encontrar todas as correspondências na string HTML fornecida
    Iterable<RegExpMatch> matches = regExp.allMatches(texto);

    // Extrair os nomes dos diretórios das correspondências
    List<String> directoryNames = [];
    for (final match in matches) {
      String dirName = match.group(1) ?? "";
      if (dirName != "..") {
        // Ignora o diretório pai "../"
        directoryNames.add(dirName);
      }
    }

    return directoryNames;
  }

  List<String> getReleaseCid(String texto) {
    // Criando uma expressão regular para encontrar os nomes dos diretórios
    RegExp regExp = RegExp(r'<a href="([^"]+)">([^<]+)</a>');
    // Encontrar todas as correspondências na string HTML fornecida
    Iterable<RegExpMatch> matches = regExp.allMatches(texto);

    // Extrair os nomes dos diretórios das correspondências
    List<String> directoryNames = [];
    for (final match in matches) {
      String dirName = match.group(1) ?? "";
      if (dirName != "..") {
        // Ignora o diretório pai "../"
        directoryNames.add(dirName);
      }
    }

    return directoryNames;
  }

  String? getFastbootFile(String htmlContent) {
    // Criando uma expressão regular para encontrar links que começam com "fastboot"
    RegExp regExp = RegExp(r'<a href="fastboot([^"]+)">');
    // Encontrar a primeira correspondência na string HTML fornecida
    RegExpMatch? match = regExp.firstMatch(htmlContent);

    // Verificar se encontrou uma correspondência e retornar o nome completo do arquivo
    if (match != null) {
      return 'fastboot${match.group(1)!}'; // Constrói o nome completo do arquivo
    }

    return null; // Retorna null se nenhum arquivo "fastboot" for encontrado
  }
}
