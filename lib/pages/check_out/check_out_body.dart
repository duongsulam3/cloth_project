import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intern_project/controller/clothing_controller.dart';
import 'package:intern_project/dimensions.dart';
import 'package:intern_project/model/user_model.dart';
import 'package:intern_project/pages/check_out/cart_confirm/cart_confirm.dart';
import 'package:intern_project/pages/sign_in/text_form_widget.dart';

class CheckOutBody extends StatefulWidget {
  const CheckOutBody({super.key});

  @override
  State<CheckOutBody> createState() => _CheckOutBodyState();
}

class _CheckOutBodyState extends State<CheckOutBody> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return FutureBuilder(
        future: readUser(user!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error to loading data!! Please try again later."),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!.data();
            final userData = UserModel.fromJson(data!);
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(Dimensions.height8),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextFormWidget(
                        hint: 'First Name',
                        label: userData.firstName.toString(),
                        icon: const Icon(Icons.person_outline),
                        password: false,
                        controller: _firstName,
                      ),
                      TextFormWidget(
                        hint: 'Last Name',
                        label: userData.lastName.toString(),
                        icon: const Icon(Icons.person_outline),
                        password: false,
                        controller: _lastName,
                      ),
                      TextFormWidget(
                        hint: 'Address',
                        label: userData.address.toString(),
                        icon: const Icon(Icons.house_outlined),
                        password: false,
                        controller: _address,
                      ),
                      TextFormWidget(
                        hint: 'City',
                        label: userData.city.toString(),
                        icon: const Icon(Icons.location_city_outlined),
                        password: false,
                        controller: _city,
                      ),
                      TextFormWidget(
                        hint: 'Phone',
                        label: userData.phone.toString(),
                        icon: const Icon(Icons.phone_android_outlined),
                        password: false,
                        controller: _phone,
                      ),
                      TextFormWidget(
                        hint: 'Email',
                        label: userData.email.toString(),
                        icon: const Icon(Icons.mail_outline),
                        password: false,
                        controller: _email,
                      ),
                      SizedBox(height: Dimensions.height20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[100],
                        ),
                        onPressed: () {
                          final dataUser = {
                            "userID": userData.userID,
                            "firstName": _firstName.value.text.isEmpty
                                ? userData.firstName
                                : _firstName.value.text,
                            "lastName": _lastName.value.text.isEmpty
                                ? userData.lastName
                                : _lastName.value.text,
                            "address": _address.value.text.isEmpty
                                ? userData.address
                                : _address.value.text,
                            "city": _city.value.text.isEmpty
                                ? userData.city
                                : _city.value.text,
                            "phone": _phone.value.text.isEmpty
                                ? userData.phone
                                : _phone.value.text,
                            "email": _email.value.text.isEmpty
                                ? userData.email
                                : _email.value.text,
                          };
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  CartConfirmPage(userData: dataUser),
                            ),
                          );
                        },
                        child: Text(
                          "Tiếp tục",
                          style: TextStyle(
                            fontSize: Dimensions.font16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
