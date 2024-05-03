class DeviceModel {
  String? product;
  String? board;
  String? secure;
  String? hwrev;
  String? radio;
  String? ram;
  String? barcode;
  String? cid;
  String? channelId;
  String? secureState;
  String? factoryModes;
  String? isWarrantyVoid;
  String? imei;
  String? imei2;
  String? sku;
  String? battId;
  String? buildFingerprint;
  String? buildVersionMtk;
  String? versionBaseband;
  String? kernelVersion;
  String? frpState;
  String? roCarrier;
  String? slotCount;
  String? buildVersion;

  DeviceModel({
    this.product,
    this.board,
    this.secure,
    this.hwrev,
    this.radio,
    this.ram,
    this.barcode,
    this.cid,
    this.channelId,
    this.secureState,
    this.factoryModes,
    this.isWarrantyVoid,
    this.imei,
    this.imei2,
    this.sku,
    this.battId,
    this.buildFingerprint,
    this.buildVersionMtk,
    this.versionBaseband,
    this.kernelVersion,
    this.frpState,
    this.roCarrier,
    this.slotCount,
  });

  String? get build => DeviceModel().getBuildVersion(buildFingerprint ?? '');

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      product: json['product'],
      board: json['board'],
      secure: json['secure'],
      hwrev: json['hwrev'],
      radio: json['radio'],
      ram: json['ram'],
      barcode: json['serialno'],
      cid: json['cid'],
      channelId: json['channelid'],
      secureState: json['securestate'],
      factoryModes: json['factory-modes'],
      isWarrantyVoid: json['iswarrantyvoid'],
      imei: json['imei'],
      imei2: json['imei2'],
      sku: json['sku'],
      battId: json['battid'],
      buildFingerprint: DeviceModel().getBuidFingerprintAsString(
          json['ro.build.fingerprint[0]'],
          json['ro.build.fingerprint[1]'],
          json['ro.build.fingerprint[2]']),
      buildVersionMtk: json['ro.build.version.mtk'],
      versionBaseband: json['version-baseband'],
      kernelVersion: DeviceModel().getKernelVersionAsString(
        json['kernel.version[0]'] ?? '',
        json['kernel.version[1]'] ?? '',
        json['kernel.version[2]'] ?? '',
        json['kernel.version[3]'] ?? '',
        json['kernel.version[4]'] ?? '',
        json['kernel.version[5]'] ?? '',
        json['kernel.version[6]'] ?? '',
        json['kernel.version[7]'] ?? '',
        json['kernel.version[8]'] ?? '',
      ),
      frpState: json['frp-state'],
      roCarrier: json['ro.carrier'],
      slotCount: json['slot-count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'board': board,
      'secure': secure,
      'hwrev': hwrev,
      'radio': radio,
      'ram': ram,
      'serialno': barcode,
      'cid': cid,
      'channelid': channelId,
      'securestate': secureState,
      'factory-modes': factoryModes,
      'iswarrantyvoid': isWarrantyVoid,
      'imei': imei,
      'imei2': imei2,
      'battid': battId,
      'ro.build.fingerprint[0]': buildFingerprint?[0],
      'ro.build.fingerprint[1]': buildFingerprint?[1],
      'ro.build.fingerprint[2]': buildFingerprint?[2],
      'ro.build.version.mtk': buildVersionMtk,
      'version-baseband': versionBaseband,
      'kernel.version[0]': kernelVersion?[0],
      'kernel.version[1]': kernelVersion?[1],
      'kernel.version[2]': kernelVersion?[2],
      'kernel.version[3]': kernelVersion?[3],
      'kernel.version[4]': kernelVersion?[4],
      'kernel.version[5]': kernelVersion?[5],
      'kernel.version[6]': kernelVersion?[6],
      'kernel.version[7]': kernelVersion?[7],
      'kernel.version[8]': kernelVersion?[8],
      'frp-state': frpState,
      'ro.carrier': roCarrier,
      'slot-count': slotCount,
    };
  }

  String getBuidFingerprintAsString(
      String parte1, String parte2, String parte3) {
    String buildFingerprint =
        parte1.replaceAll('ro.build.fingerprint[0]: ', '') +
            parte2.replaceAll('ro.build.fingerprint[1]: ', '') +
            parte3.replaceAll('ro.build.fingerprint[2]: ', '');

    buildFingerprint = buildFingerprint.replaceAll(RegExp(r'\s+'), '');
    // print(buildFingerprint);

    return buildFingerprint;
  }

  String getKernelVersionAsString(
    String parte0,
    String parte1,
    String parte2,
    String parte3,
    String parte4,
    String parte5,
    String parte6,
    String parte7,
    String parte8,
  ) {
    String kernelVersion = parte0.replaceAll('kernel.version[0]: ', '').trim() +
        parte1.replaceAll('kernel.version[1]: ', '').trim() +
        parte2.replaceAll('kernel.version[2]: ', '').trim() +
        parte3.replaceAll('kernel.version[3]: ', '').trim() +
        parte4.replaceAll('kernel.version[4]: ', '').trim() +
        parte5.replaceAll('kernel.version[5]: ', '').trim() +
        parte6.replaceAll('kernel.version[6]: ', '').trim() +
        parte7.replaceAll('kernel.version[7]: ', '').trim() +
        parte8.replaceAll('kernel.version[8]: ', '').trim();

    // kernelVersion = kernelVersion.replaceAll(RegExp(r'\s+'), '');
    return kernelVersion;
  }

  String getBuildVersion(String buildFingerprint) {
    String build = buildFingerprint.split('/').elementAt(3);
    return build;
  }

  @override
  String toString() {
    return 'DeviceModel{\n'
        '  product: $product,\n'
        '  board: $board,\n'
        '  secure: $secure,\n'
        '  hwrev: $hwrev,\n'
        '  radio: $radio,\n'
        '  ram: $ram,\n'
        '  barcode: $barcode,\n'
        '  cid: $cid,\n'
        '  channelId: $channelId,\n'
        '  secureState: $secureState,\n'
        '  factoryModes: $factoryModes,\n'
        '  isWarrantyVoid: $isWarrantyVoid,\n'
        '  imei: $imei,\n'
        '  imei2: $imei2,\n'
        '  battId: $battId,\n'
        '  buildFingerprint: $buildFingerprint,\n'
        '  buildVersionMtk: $buildVersionMtk,\n'
        '  versionBaseband: $versionBaseband,\n'
        '  kernelVersion: $kernelVersion,\n'
        '  frpState: $frpState,\n'
        '  roCarrier: $roCarrier,\n'
        '  slotCount: $slotCount\n'
        '}';
  }
}
