import 'package:dm_flutter/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  saveLogin(String coreId, String password, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    prefs.setString('token', token);
    prefs.setString('coreId', coreId);
    prefs.setString('passoword', password);
    prefs.setString('basicAuth', "Basic $token");
    prefs.setBool('login', true);
  }

  clearLogin(String coreId, String password, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    prefs.setString('token', '');
    prefs.setString('coreId', '');
    prefs.setString('passoword', '');
    prefs.setString('basicAuth', "");
    prefs.setBool('login', false);
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token;

    token = prefs.getString('token') ?? '';
    return token;
  }

 Future<String> getBasicAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token;

    token = prefs.getString('basicAuth') ?? '';
    return token;
  }

  Future<bool> verificaLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = prefs.getBool('login') ?? false;

    return result;
  }

  Future<UserModel> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel userModel = UserModel();
    userModel.token = prefs.getString('tokenBearer') ?? '';
    userModel.username = prefs.getString('username') ?? '';

    return userModel;
  }

  setDownloadDefaultFolder(String defaultFolder) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('downloadDefaultFolder', defaultFolder);
  }

  Future<String> getDownloadDefaultFolder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? defaultFolder;

    defaultFolder = prefs.getString('downloadDefaultFolder') ?? '';
    return defaultFolder;
  }

}
