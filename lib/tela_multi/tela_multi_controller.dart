import 'package:dm_flutter/models/api_response_model.dart';
import 'package:dm_flutter/services/dio/requests_service.dart';

class TelaMultiController {
  List<String> listAndroidVersion = [];
  List<String> listBuilds = [];
  List<String> listBuildName = [];
  List<String> listTypeUser = [];
  List<String> listReleaseCid = [];



  RequestsService requestsService = RequestsService();

  Future getListAndroidVersions(String produto) async {
    ApiResponseModel response =
        await requestsService.getAndroidVersionForProduct(produto);
    if (response.successfulConnection == true) {
      listAndroidVersion = response.data;
    }
    print('pesquisa versao');
  }

  Future getListOfBuilds(String produto, String versao) async {
    ApiResponseModel response =
        await requestsService.getBuildsForProduct(produto, versao);
    if (response.successfulConnection == true) {
      listBuilds = response.data;
    }
    print('pesquisa build');
  }

  Future getListOfBuildName(String produto, String versao, String build) async {
    ApiResponseModel response =
        await requestsService.getBuildNameForProduct(produto, versao, build);
    if (response.successfulConnection == true) {
      listBuildName = response.data;
    }
    print('pesquisa build name');
    print(listBuildName);
  }

  Future getListOfTypeUser(String produto, String versao, String buildVersion, String buildName) async {
    ApiResponseModel response =
        await requestsService.getTypeUser(produto, versao, buildVersion, buildName);
    if (response.successfulConnection == true) {
      listTypeUser = response.data;
    }
    print('pesquisa type suer');
    print(listTypeUser);
  }

  Future getListOfReleaseCid(String produto, String versao, String buildVersion, String buildName, String userType) async {
    ApiResponseModel response =
        await requestsService.getReleaseCid(produto, versao, buildVersion, buildName, userType);
    if (response.successfulConnection == true) {
      listReleaseCid = response.data;
    }
    print('pesquisa release cid');
    print(listReleaseCid);
  }
}
