import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../dimensions.dart';
import '../../home/home_page.dart';
import '../../sign_in/text_form_widget.dart';

class EditProfileBody extends StatefulWidget {
  final dynamic personProfile;
  const EditProfileBody({super.key, this.personProfile});

  @override
  State<EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<EditProfileBody> {
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DocumentReference user = FirebaseFirestore.instance
        .collection("users")
        .doc(widget.personProfile.userID.toString());

    final lastName = _lastNameController.value.text;
    final firstName = _firstNameController.value.text;
    final address = _addressController.value.text;
    final city = _cityController.value.text;
    final phone = _phoneNumberController.value.text;

    onSave() {
      if (lastName.isEmpty &&
          firstName.isEmpty &&
          address.isEmpty &&
          city.isEmpty &&
          phone.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Fill at least one input to make a change"),
        ));
        Navigator.pop(context);
        return null;
      } else {
        final data = {
          "firstName": firstName.isEmpty
              ? widget.personProfile.firstName.toString()
              : firstName,
          "lastName": lastName.isEmpty
              ? widget.personProfile.lastName.toString()
              : lastName,
          "address": address.isEmpty
              ? widget.personProfile.address.toString()
              : address,
          "city": city.isEmpty ? widget.personProfile.city.toString() : city,
          "phoneNumber":
              phone.isEmpty ? widget.personProfile.phone.toString() : phone,
        };
        user
            .update(data)
            .then((value) => {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("User profile has updated successfully"),
                  )),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  )
                })
            .catchError((error) => print("Failed to update user: $error"));
      }
    }

    return Padding(
      padding: EdgeInsets.all(Dimensions.height8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "EMAIL ADDRESS",
            style: TextStyle(
              fontSize: Dimensions.font26,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(widget.personProfile.email.toString()),
          // SizedBox(height: Dimensions.height20),
          TextFormWidget(
            hint: "Enter your first name",
            label: widget.personProfile.firstName.toString(),
            icon: const Icon(Icons.person),
            password: false,
            controller: _firstNameController,
          ),
          TextFormWidget(
            hint: "Enter your last name",
            label: widget.personProfile.lastName.toString(),
            icon: const Icon(Icons.person),
            password: false,
            controller: _lastNameController,
          ),
          TextFormWidget(
            hint: "Enter your address",
            label: widget.personProfile.address.toString(),
            icon: const Icon(Icons.place),
            password: false,
            controller: _addressController,
          ),
          TextFormWidget(
            hint: "Enter your city",
            label: widget.personProfile.city.toString(),
            icon: const Icon(Icons.place_outlined),
            password: false,
            controller: _cityController,
          ),
          TextFormWidget(
            hint: "Enter your phone number",
            label: widget.personProfile.phone.toString(),
            icon: const Icon(Icons.phone),
            password: false,
            controller: _phoneNumberController,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Update profile"),
                              content: const Text(
                                  "Your profile data will be remove permanently"),
                              actions: [
                                TextButton(
                                  onPressed: onSave,
                                  child: const Text("OK"),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Cancel"),
                                )
                              ],
                            ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text("Save"),
                ),
                SizedBox(width: Dimensions.width10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text("Cancel"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
