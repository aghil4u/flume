class Equipment {
  final int id;
  final String EquipmentNumber;
  final String AssetNumber;
  final String AcquisitionDate;
  final bool PendingUpdate;
  final double AcquisitionValue;
  final String BookValue;
  final String AssetDescription;
  final String EquipmentDescription;
  final String OperationId;
  final String SubType;
  final String Weight;
  final String WeightUnit;
  final String Dimensions;
  final String Tag;
  final String Type;
  final String Connection;
  final String Length;
  final String ModelNumber;
  final String SerialNumber;
  final String AssetLocation;
  final String AssetLocationText;
  final String EquipmentLocation;

  Equipment({
    this.id,
    this.EquipmentNumber,
    this.AssetNumber,
    this.AcquisitionDate,
    this.PendingUpdate,
    this.AcquisitionValue,
    this.BookValue,
    this.AssetDescription,
    this.EquipmentDescription,
    this.OperationId,
    this.SubType,
    this.Weight,
    this.WeightUnit,
    this.Dimensions,
    this.Tag,
    this.Type,
    this.Connection,
    this.Length,
    this.ModelNumber,
    this.AssetLocation,
    this.AssetLocationText,
    this.EquipmentLocation,
    this.SerialNumber,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json['id'],
      EquipmentNumber: json['equipmentNumber'],
      AssetNumber: json['assetNumber'],
      AcquisitionDate: json['acquisitionDate'],
      PendingUpdate: json['pendingUpdate'],
      AcquisitionValue: json['acquisitionValue'],
      BookValue: json['bookValue'],
      AssetDescription: json['assetDescription'],
      EquipmentDescription: json['equipmentDescription'],
      OperationId: json['operationId'],
      SubType: json['subType'],
      Weight: json['weight'],
      WeightUnit: json['weightUnit'],
      Dimensions: json['dimensions'],
      Tag: json['tag'],
      Type: json['type'],
      Connection: json['connection'],
      Length: json['length'],
      ModelNumber: json['modelNumber'],
      SerialNumber: json['serialNumber'],
      AssetLocation: json['assetLocation'],
      AssetLocationText: json['assetLocationText'],
      EquipmentLocation: json['equipmentLocation'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'equipmentNumber': EquipmentNumber,
        'assetNumber': AssetNumber,
        'acquisitionDate': AcquisitionDate,
        'pendingUpdate': PendingUpdate,
        'acquisitionValue': AcquisitionValue,
        'bookValue': BookValue,
        'assetDescription': AssetDescription,
        'equipmentDescription': EquipmentDescription,
        'operationId': OperationId,
        'subType': SubType,
        'weight': Weight,
        'weightUnit': WeightUnit,
        'dimensions': Dimensions,
        'tag': Tag,
        'type': Type,
        'connection': Connection,
        'length': Length,
        'modelNumber': ModelNumber,
        'serialNumber': SerialNumber,
        'assetLocation': AssetLocation,
        'assetLocationText': AssetLocationText,
        'equipmentLocation': EquipmentLocation,
      };
}
