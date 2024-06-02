class SoundEffectModel {
  int id;
  String name;
  String assetPath;
  String image;
  String type;

  SoundEffectModel({
    required this.id,
    required this.name,
    required this.assetPath,
    required this.image,
    required this.type,
  });

  // Factory constructor to create a Sound instance from JSON
  factory SoundEffectModel.fromJson(Map<String, dynamic> json) {
    return SoundEffectModel(
      id: json['id'],
      name: json['name'],
      assetPath: json['assetPath'],
      image: json['image'],
      type: json['type'],
    );
  }

  // Method to convert a Sound instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'assetPath': assetPath,
      'image': image,
      'type': type,
    };
  }
}
