import 'package:dm_flutter/homepage_controller.dart';
import 'package:dm_flutter/models/device_model.dart';
import 'package:flutter/material.dart';

class CardDevice extends StatefulWidget {
  final DeviceModel device;
  final HomepageController homeController;
  const CardDevice(
      {Key? key, required this.device, required this.homeController})
      : super(key: key);

  @override
  State<CardDevice> createState() => _CardDeviceState();
}

class _CardDeviceState extends State<CardDevice> {
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
                  Text(widget.device.product ?? ''),
                  Text(widget.device.barcode ?? ''),
                  Text(widget.device.roCarrier ?? ''),
                  Text(widget.device.isWarrantyVoid ?? ''),
                  Text(widget.device.build ?? ''),
                ],
              ),

              !widget.device.deviceSelecionado
                ? const Icon(Icons.check_box_outline_blank)
                : const Icon(Icons.check_box)
            ],
          )),
    );
  }
}
