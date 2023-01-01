class PublicUserData {
  final String name;
  final String publicId;
  final String profilePic;
  PublicUserData(
      {required this.name, required this.profilePic, required this.publicId});
}

class PersonalData extends PublicUserData {
  final String email;
  final String token;
  PersonalData(
      {required this.email,
      required this.token,
      required super.name,
      required super.publicId,
      required super.profilePic});

  factory PersonalData.fromJson(Map<String, String> json) {
    return PersonalData(
        email: json['email'] as String,
        token: json['token'] as String,
        name: json['username'] as String,
        publicId: json['publicId'] as String,
        profilePic: json['profilePic'] as String);
  }

  PublicUserData get getPublicData => this;
}
