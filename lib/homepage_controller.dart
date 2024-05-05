import 'package:dm_flutter/models/device_model.dart';
import 'package:dm_flutter/utils.dart';
import 'package:mobx/mobx.dart';

part 'homepage_controller.g.dart';

class HomepageController = HomepageControllerBase with _$HomepageController;

abstract class HomepageControllerBase with Store {
  List<DeviceModel> listOfDevices = List<DeviceModel>.empty(growable: true);
  List<DeviceModel> listOfSelectedDevices =
      List<DeviceModel>.empty(growable: true);

  int indexTelas = 0;

  @observable
  String teste = 'lucas';

  Future getDevices() async {
    listOfDevices.clear();
    listOfDevices = await DeviceFunctions().getAllDevicesInFastboot();
  }

  popularListaDeDevicesSelecionados() {
    listOfSelectedDevices =
        listOfDevices.where((device) => device.deviceSelecionado).toList();
  }

  clearListDevicesSelecionados() {
    listOfSelectedDevices.clear();
  }
}
