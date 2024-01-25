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

  // Map<String, dynamic> toFirestore() {
  //   return {
  //     if (userID != null) "userID": userID,
  //     if (firstName != null) "firstName": firstName,
  //     if (lastName != null) "lastName": lastName,
  //     if (address != null) "address": address,
  //     if (city != null) "city": city,
  //     if (email != null) "email": email,
  //     if (password != null) "password": password,
  //     if (phone != null) "phoneNumber": phone,
  //     if (favCloths != null) "favoriteCloth": favCloths,
  //     if (isAdmin != null) "isAdmin": isAdmin,
  //   };
  // }

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

  // factory UserModel.fromFirestore(
  //     DocumentSnapshot<Map<String, dynamic>> snapshot,
  //     SnapshotOptions? options,
  //     ) {
  //   final data = snapshot.data();
  //   return UserModel(
  //     userID: data?['userID'],
  //     firstName: data?["firstName"],
  //     lastName: data?["lastName"],
  //     address: data?["address"],
  //     city: data?["city"],
  //     email: data?["email"],
  //     password: data?["password"],
  //     phone: data?['phoneNumber'],
  //     isAdmin: data?['isAdmin'],
  //     favCloths: data?['favoriteCloth'],
  //   );
  // }

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
