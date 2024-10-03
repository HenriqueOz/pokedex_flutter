class UserModel {
  final String name;
  final String region;
  final String? blobImage;

  UserModel({
    required this.name,
    required this.region,
    required this.blobImage,
  });

  UserModel copyWith({
    String? name,
    String? region,
    String? blobImage,
  }) {
    return UserModel(
      name: name ?? this.name,
      region: region ?? this.region,
      blobImage: blobImage ?? this.blobImage,
    );
  }

  factory UserModel.empty() {
    return UserModel(name: '', region: '', blobImage: null);
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['username'] as String,
      region: map['region'] as String,
      blobImage: map['avatar'] as String?,
    );
  }
}
