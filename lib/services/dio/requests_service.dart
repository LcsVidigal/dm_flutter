import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dm_flutter/models/api_response_model.dart';
import 'package:dm_flutter/services/preferences.dart';
import 'package:dm_flutter/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;

class RequestsService {
  Future connectArtifactory(token) async {
    String uri;
    try {
      uri =
          'https://artifacts.mot.com/artifactory/pnangn/13/T1TPNS33.58-94-1/pnangn_g/';

      String basicAuth = 'Basic $token';

      var response = await Dio().get(uri,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: basicAuth
          }));
      if (response.statusCode == 200) {
        print(response.statusCode);
        return true;
      }
    } on DioException catch (e) {
      debugPrint(e.message.toString());
      return false;
    }
    return [];
  }

  Future<ApiResponseModel> getAndroidVersionForProduct(product) async {
    String uri;
    try {
      uri = 'https://artifacts.mot.com/artifactory/$product/';
      print(uri);

      Preferences pref = Preferences();
      String basicAuth = await pref.getBasicAuth();
      print(basicAuth);

      var response = await Dio().get(uri,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: basicAuth
          }));
      if (response.statusCode == 200) {
        print(response.statusCode);
        List<String> listaVersoesAndroid =
            ArtifactoryFunctions().getVersoesAndroid(response.data);
        return ApiResponseModel(
            successfulConnection: true, data: listaVersoesAndroid);
      }
    } on DioException catch (e) {
      debugPrint(e.message.toString());
      return ApiResponseModel(successfulConnection: false);
    }
    return ApiResponseModel(successfulConnection: false);
  }

  Future<ApiResponseModel> getBuildsForProduct(product, version) async {
    String uri;
    try {
      uri = 'https://artifacts.mot.com/artifactory/$product/$version';
      print(uri);

      Preferences pref = Preferences();
      String basicAuth = await pref.getBasicAuth();
      print(basicAuth);

      var response = await Dio().get(uri,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: basicAuth
          }));
      if (response.statusCode == 200) {
        print(response.statusCode);
        List<String> listaDeBuilds =
            ArtifactoryFunctions().getBuilds(response.data);
        print(listaDeBuilds);
        return ApiResponseModel(successfulConnection: true, data: listaDeBuilds);
      }
    } on DioException catch (e) {
      debugPrint(e.message.toString());
      return ApiResponseModel(successfulConnection: false);
    }
    return ApiResponseModel(successfulConnection: false);
  }


  Future<ApiResponseModel> getBuildNameForProduct(product, version, build) async {
    String uri;
    try {
      uri = 'https://artifacts.mot.com/artifactory/$product/$version/$build';
      print(uri);

      Preferences pref = Preferences();
      String basicAuth = await pref.getBasicAuth();
      print(basicAuth);

      var response = await Dio().get(uri,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: basicAuth
          }));
      if (response.statusCode == 200) {
        print(response.statusCode);
        List<String> listaDeBuildNames =
            ArtifactoryFunctions().getBuildName(response.data);
        print(listaDeBuildNames);
        return ApiResponseModel(successfulConnection: true, data: listaDeBuildNames);
      }
    } on DioException catch (e) {
      debugPrint(e.message.toString());
      return ApiResponseModel(successfulConnection: false);
    }
    return ApiResponseModel(successfulConnection: false);
  }


  Future<ApiResponseModel> getTypeUser(product, version, buildVersion, buildName) async {
    String uri;
    try {
      uri = 'https://artifacts.mot.com/artifactory/$product/$version/$buildVersion/$buildName';
      print(uri);

      Preferences pref = Preferences();
      String basicAuth = await pref.getBasicAuth();
      print(basicAuth);

      var response = await Dio().get(uri,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: basicAuth
          }));
      if (response.statusCode == 200) {
        print(response.statusCode);
        List<String> listaDeTypeUser =
            ArtifactoryFunctions().getTypeUser(response.data);
        print(listaDeTypeUser);
        return ApiResponseModel(successfulConnection: true, data: listaDeTypeUser);
      }
    } on DioException catch (e) {
      debugPrint(e.message.toString());
      return ApiResponseModel(successfulConnection: false);
    }
    return ApiResponseModel(successfulConnection: false);
  }


  Future<ApiResponseModel> getReleaseCid(product, version, buildVersion, buildName, user) async {
    String uri;
    try {
      uri = 'https://artifacts.mot.com/artifactory/$product/$version/$buildVersion/$buildName/$user';
      print(uri);

      Preferences pref = Preferences();
      String basicAuth = await pref.getBasicAuth();
      print(basicAuth);

      var response = await Dio().get(uri,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: basicAuth
          }));
      if (response.statusCode == 200) {
        print(response.statusCode);
        List<String> listaDeReleaseCid =
            ArtifactoryFunctions().getReleaseCid(response.data);
        print(listaDeReleaseCid);
        return ApiResponseModel(successfulConnection: true, data: listaDeReleaseCid);
      }
    } on DioException catch (e) {
      debugPrint(e.message.toString());
      return ApiResponseModel(successfulConnection: false);
    }
    return ApiResponseModel(successfulConnection: false);
  }

  Future<ApiResponseModel> getFastbootFile(product, version, buildVersion, buildName, user) async {
    String uri;
    try {
      uri = 'https://artifacts.mot.com/artifactory/$product/$version/$buildVersion/$buildName/$user';
      print(uri);

      Preferences pref = Preferences();
      String basicAuth = await pref.getBasicAuth();
      print(basicAuth);

      var response = await Dio().get(uri,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: basicAuth
          }));
      if (response.statusCode == 200) {
        print(response.statusCode);
        List<String> listaDeReleaseCid =
            ArtifactoryFunctions().getReleaseCid(response.data);
        print(listaDeReleaseCid);
        return ApiResponseModel(successfulConnection: true, data: listaDeReleaseCid);
      }
    } on DioException catch (e) {
      debugPrint(e.message.toString());
      return ApiResponseModel(successfulConnection: false);
    }
    return ApiResponseModel(successfulConnection: false);
  }

  // Future<void> downloadFile(String url, String filename) async {
  //   // Obtendo o diretório onde salvar o arquivo
  //   Directory dir = await getApplicationDocumentsDirectory();
  //   String filePath = '${dir.path}/$filename';

  //   // Fazendo a requisição HTTP para obter o arquivo
  //   http.Response response = await http.get(Uri.parse(url));

  //   // Verificando se a requisição foi bem sucedida
  //   if (response.statusCode == 200) {
  //     // Criando o arquivo no diretório especificado e escrevendo os dados
  //     File file = File(filePath);
  //     await file.writeAsBytes(response.bodyBytes);
  //     print('Arquivo salvo em $filePath');
  //   } else {
  //     throw Exception('Falha ao baixar o arquivo: ${response.statusCode}');
  //   }
  // }
}
