import 'package:dm_flutter/services/dio/requests_service.dart';

class LoginController {
  final RequestsService requestsService = RequestsService();

  login(token) async {
    var result = requestsService.connectArtifactory(token);
    return result;
  }
}
