class DataUser {
  final String? userID;
  final String? firstName;
  final String? lastName;
  final String? address;
  final String? city;
  final String? email;

  final String? phone;

  DataUser({
    this.userID,
    this.firstName,
    this.lastName,
    this.address,
    this.city,
    this.email,
    this.phone,
  });

  Map<String, dynamic> toJson() => {
        "userID": userID,
        "firstName": firstName,
        "lastName": lastName,
        "address": address,
        "city": city,
        "email": email,
        "phoneNumber": phone,
      };

  static DataUser fromJson(Map<String, dynamic> json) => DataUser(
        userID: json['userID'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        address: json['address'],
        city: json['city'],
        email: json['email'],
        phone: json['phone'],
      );
}
