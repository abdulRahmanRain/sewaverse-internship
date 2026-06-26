class JobModel {
  final String name;
  final String tag;
  final String description;
  final String profileImage;
  final String imageUrl;

  JobModel({
    required this.name,
    required this.tag,
    required this.description,
    required this.profileImage,
    required this.imageUrl,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      name: json['providerName'] ?? '',
      tag: json['tag'] ?? '',
      description: json['description'] ?? '',
      profileImage: json['providerImageUrl'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'providerName': name,
      'tag': tag,
      'description': description,
      'providerImageUrl': profileImage,
      'imageUrl': imageUrl,
    };
  }
}