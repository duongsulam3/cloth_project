class UserModel {
  final String? userID;
  final String? firstName;
  final String? lastName;
  final String? address;
  final String? city;
  final String? email;
  final String? password;
  final String? phone;
  final List? favCloths;
  final bool? isAdmin;

  UserModel({
    this.userID,
    this.firstName,
    this.lastName,
    this.address,
    this.city,
    this.email,
    this.password,
    this.phone,
    this.favCloths,
    this.isAdmin,
  });

  Map<String, dynamic> toJson() => {
        "userID": userID,
        "firstName": firstName,
        "lastName": lastName,
        "address": address,
        "city": city,
        "email": email,
        "password": password,
        "phoneNumber": phone,
        "favoriteCloth": favCloths,
        "isAdmin": isAdmin,
      };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        userID: json['userID'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        address: json['address'],
        city: json['city'],
        email: json['email'],
        password: json['password'],
        phone: json['phoneNumber'],
        isAdmin: json['isAdmin'],
        favCloths: json['favoriteCloth'],
      );
}
