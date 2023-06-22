class UserModel {
  String id;
  num rewardpoints;
  String email;
  String firstName;
  String lastName;

  UserModel({
    required this.id,
    required this.rewardpoints,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      rewardpoints: json['reward_points'] ?? 0,
      email: json['email'] ?? "",
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id.toString();
    data['reward_points'] = rewardpoints;
    data['email'] = email.toString();
    data['first_name'] = firstName.toString();
    data['last_name'] = lastName.toString();

    return data;
  }
}
