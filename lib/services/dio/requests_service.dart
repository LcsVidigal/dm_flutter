import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dm_flutter/models/api_response_model.dart';
import 'package:dm_flutter/services/preferences.dart';
import 'package:dm_flutter/utils.dart';
import 'package:flutter/foundation.dart';


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

      Preferences pref = Preferences();
      String basicAuth = await pref.getBasicAuth();

      var response = await Dio().get(uri,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: basicAuth
          }));
      if (response.statusCode == 200) {
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

      Preferences pref = Preferences();
      String basicAuth = await pref.getBasicAuth();

      var response = await Dio().get(uri,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: basicAuth
          }));
      if (response.statusCode == 200) {
        List<String> listaDeBuilds =
            ArtifactoryFunctions().getBuilds(response.data);
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

      Preferences pref = Preferences();
      String basicAuth = await pref.getBasicAuth();

      var response = await Dio().get(uri,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: basicAuth
          }));
      if (response.statusCode == 200) {
        List<String> listaDeBuildNames =
            ArtifactoryFunctions().getBuildName(response.data);
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

      Preferences pref = Preferences();
      String basicAuth = await pref.getBasicAuth();

      var response = await Dio().get(uri,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: basicAuth
          }));
      if (response.statusCode == 200) {
        List<String> listaDeTypeUser =
            ArtifactoryFunctions().getTypeUser(response.data);
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

      Preferences pref = Preferences();
      String basicAuth = await pref.getBasicAuth();

      var response = await Dio().get(uri,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: basicAuth
          }));
      if (response.statusCode == 200) {
        List<String> listaDeReleaseCid =
            ArtifactoryFunctions().getReleaseCid(response.data);
        return ApiResponseModel(successfulConnection: true, data: listaDeReleaseCid);
      }
    } on DioException catch (e) {
      debugPrint(e.message.toString());
      return ApiResponseModel(successfulConnection: false);
    }
    return ApiResponseModel(successfulConnection: false);
  }

  Future<ApiResponseModel> getFastbootFile(product, version, buildVersion, buildName, user, releaseCid) async {
    String uri;
    try {
      uri = 'https://artifacts.mot.com/artifactory/$product/$version/$buildVersion/$buildName/$user/$releaseCid';

      Preferences pref = Preferences();
      String basicAuth = await pref.getBasicAuth();

      var response = await Dio().get(uri,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: basicAuth
          }));
      if (response.statusCode == 200) {
        String? fastbootFile =
            ArtifactoryFunctions().getFastbootFile(response.data);
        return ApiResponseModel(successfulConnection: true, data: fastbootFile);
      }
    } on DioException catch (e) {
      debugPrint(e.message.toString());
      return ApiResponseModel(successfulConnection: false);
    }
    return ApiResponseModel(successfulConnection: false);
  }

  Future<ApiResponseModel> downloadFile(product, version, buildVersion, buildName, user, releaseCid, fileName) async {
    String uri;
    Preferences pref = Preferences();
    String selectedDirectory = await pref.getDownloadDefaultFolder();

    // Construa o caminho do arquivo local.
    String filePath = '$selectedDirectory/$fileName';

    String basicAuth = await pref.getBasicAuth();

    // Inicie o download
    try{
      uri = 'https://artifacts.mot.com/artifactory/$product/$version/$buildVersion/$buildName/$user/$releaseCid/$fileName';

      var response = await Dio().download(
        uri, 
        filePath,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: basicAuth
        }),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            // Você pode usar este callback para mostrar a porcentagem de download.
            // print((received / total * 100).toStringAsFixed(0) + "%");
          }
        },
      );
      debugPrint("Download completed: $filePath");

    } on DioException catch (e) {
      debugPrint(e.message.toString());
      return ApiResponseModel(successfulConnection: false);
    }
    return ApiResponseModel(successfulConnection: false);
      

  }
}
