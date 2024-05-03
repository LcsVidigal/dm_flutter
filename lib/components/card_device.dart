import 'package:dm_flutter/homepage_controller.dart';
import 'package:dm_flutter/models/device_model.dart';
import 'package:flutter/material.dart';

class CardDevice extends StatelessWidget {
  final DeviceModel device;
  final HomepageController homeController;
  const CardDevice(
      {Key? key, required this.device, required this.homeController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
          width: 300,
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.phone_android,
                size: 50,
              ),
              Container(
                height: 60,
                width: 3,
                color: Colors.blue,
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(device.product ?? ''),
                  Text(device.barcode ?? ''),
                  Text(device.roCarrier ?? ''),
                  Text(device.isWarrantyVoid ?? ''),
                  Text(device.build ?? ''),
                ],
              )
            ],
          )),
    );
  }
}
