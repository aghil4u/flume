class Verification {
  final int id;

  final String ImageUrl;
  final String Date;
  final String Type;
  final String Location;
  final String User;
  final String AssetNumber;
  final String EquipmentNumber;
  final String AssetDescription;

  Verification({
    this.id,
    this.ImageUrl,
    this.Date,
    this.Type,
    this.Location,
    this.User,
    this.AssetNumber,
    this.EquipmentNumber,
    this.AssetDescription,
  });

  factory Verification.fromJson(Map<String, dynamic> json) {
    return Verification(
      id: json['id'],
      ImageUrl: json['imageUrl'],
      Date: json['date'],
      Type: json['type'],
      Location: json['location'],
      User: json['user'],
      AssetNumber: json['assetNumber'],
      EquipmentNumber: json['equipmentNumber'],
      AssetDescription: json['assetDescription'],
    );
  }

  Map<String, dynamic> toJson() => {
        // 'id': id,
        'imageUrl': ImageUrl,
        'date': Date,
        'type': Type,
        'location': Location,
        'user': User,
        'assetNumber': AssetNumber,
        'equipmentNumber': EquipmentNumber,
        'assetDescription': AssetDescription,
      };
}
