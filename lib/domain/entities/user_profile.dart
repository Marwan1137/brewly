class UserProfile {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String? photoUrl;

  UserProfile({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.photoUrl,
  });

  String get fullName => '$firstName $lastName';

  UserProfile copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? photoUrl,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      photoUrl: json['photo_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'photo_url': photoUrl,
    };
  }
}
