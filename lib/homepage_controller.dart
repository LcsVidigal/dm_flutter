import 'package:dm_flutter/models/device_model.dart';
import 'package:dm_flutter/utils.dart';
import 'package:mobx/mobx.dart';

part 'homepage_controller.g.dart';

class HomepageController = HomepageControllerBase with _$HomepageController;

abstract class HomepageControllerBase with Store {
  List<DeviceModel> listOfDevices = List<DeviceModel>.empty(growable: true);

  DeviceModel deviceSelected = DeviceModel();

  @observable
  String teste = 'lucas';

  Future getDevices() async {
    listOfDevices.clear();
    listOfDevices = await DeviceFunctions().getAllDevicesInFastboot();
    print(listOfDevices.length);
  }
}
