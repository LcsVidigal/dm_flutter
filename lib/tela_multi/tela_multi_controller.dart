import 'package:dm_flutter/models/api_response_model.dart';
import 'package:dm_flutter/services/dio/requests_service.dart';
import 'package:dm_flutter/services/preferences.dart';
import 'package:dm_flutter/utils.dart';
import 'package:flutter/foundation.dart';

class TelaMultiController {
  List<String> listAndroidVersion = [];
  List<String> listBuilds = [];
  List<String> listBuildName = [];
  List<String> listTypeUser = [];
  List<String> listReleaseCid = [];
  String fastbootFileName = '';
  bool fastbootExists = false;

  RequestsService requestsService = RequestsService();

  Future getListAndroidVersions(String produto) async {
    ApiResponseModel response =
        await requestsService.getAndroidVersionForProduct(produto);
    if (response.successfulConnection == true) {
      listAndroidVersion = response.data;
    }
  }

  Future getListOfBuilds(String produto, String versao) async {
    ApiResponseModel response =
        await requestsService.getBuildsForProduct(produto, versao);
    if (response.successfulConnection == true) {
      listBuilds = response.data;
    }
  }

  Future getListOfBuildName(String produto, String versao, String build) async {
    ApiResponseModel response =
        await requestsService.getBuildNameForProduct(produto, versao, build);
    if (response.successfulConnection == true) {
      listBuildName = response.data;
    }
  }

  Future getListOfTypeUser(String produto, String versao, String buildVersion,
      String buildName) async {
    ApiResponseModel response = await requestsService.getTypeUser(
        produto, versao, buildVersion, buildName);
    if (response.successfulConnection == true) {
      listTypeUser = response.data;
    }
  }

  Future getListOfReleaseCid(String produto, String versao, String buildVersion,
      String buildName, String userType) async {
    ApiResponseModel response = await requestsService.getReleaseCid(
        produto, versao, buildVersion, buildName, userType);
    if (response.successfulConnection == true) {
      listReleaseCid = response.data;
    }
  }

  Future getFastbootFileName(String produto, String versao, String buildVersion,
      String buildName, String userType, String releaseCid) async {
    ApiResponseModel response = await requestsService.getFastbootFile(
        produto, versao, buildVersion, buildName, userType, releaseCid);
    if (response.successfulConnection == true) {
      fastbootFileName = response.data;
      fastbootExists = true;
    }
  }

  Future<void> downloadFile(String produto, String versao, String buildVersion,
      String buildName, String userType, String releaseCid) async {
    ApiResponseModel response = await requestsService.downloadFile(
        produto,
        versao,
        buildVersion,
        buildName,
        userType,
        releaseCid,
        fastbootFileName);
    if (response.successfulConnection == true) {
      listTypeUser = response.data;
    }
  }

  Future extractBuild() async {
    try {
      Preferences pref = Preferences();
      String directory = await pref.getDownloadDefaultFolder();

      await callCommand('tar -xvzf $fastbootFileName', directory);
      debugPrint('finalizou extração da build');

      return true;
    } catch (e) {
      debugPrint('erro ao extrair');
      return false;
    }
  }

  Future flashDevices(List listaDevices) async {
    try {
      Preferences pref = Preferences();
      String directory = await pref.getDownloadDefaultFolder();
      String build = fastbootFileName
          .replaceAll("fastboot_", "")
          .replaceAll(".tar", "")
          .replaceAll(".gz", "");
      directory = '$directory\\$build';

      print(directory);

      listaDevices.forEach((element) {
        callCommand('flashall.bat /d ${element.barcode}', directory);
        // print(element.barcode);
      });
      return true;
    } catch (e) {
      debugPrint('erro ao extrair');
      return false;
    }
  }

  Future<void> baixarExtrairFlashar(
      String produto,
      String versao,
      String buildVersion,
      String buildName,
      String userType,
      String releaseCid,
      List listaDevices) async {
    await downloadFile(
        produto, versao, buildVersion, buildName, userType, releaseCid);
    await extractBuild();
    await flashDevices(listaDevices);

    print('concluído');
  }
}
