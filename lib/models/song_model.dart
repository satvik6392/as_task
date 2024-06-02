class AudioModel {
  int id;
  String name;
  String assetPath;
  String image;
  String type;

  AudioModel({
    required this.id,
    required this.name,
    required this.assetPath,
    required this.image,
    required this.type,
  });

  // Factory constructor to create an AudioModel instance from JSON
  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      id: json['id'],
      name: json['name'],
      assetPath: json['assetPath'],
      image: json['image'],
      type: json['type'],
    );
  }

  // Method to convert an AudioModel instance to JSON
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
