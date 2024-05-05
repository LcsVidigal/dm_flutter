import 'package:dm_flutter/utils.dart';

class TelaScriptsController {
  erase(List selectedDevices) {
    // só pra coloar um exemplo
    callCommand('fastboot getvar all', null);
    print(selectedDevices[0].barcode);
  }
}
