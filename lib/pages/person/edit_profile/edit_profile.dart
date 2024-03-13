import 'package:flutter/material.dart';
import 'package:intern_project/pages/person/edit_profile/edit_profile_body.dart';

import '../../../dimensions.dart';

class EditProfile extends StatelessWidget {
  final dynamic personProfile;

  const EditProfile({
    super.key,
    this.personProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: Dimensions.font26,
          ),
        ),
      ),
      body: EditProfileBody(personProfile: personProfile),
    );
  }
}
