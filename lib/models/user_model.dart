import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  String lastName;
  String firstName;
  String confrimPassword;
  String password;

  UserModel(
      {required this.uid,
      required this.email,
      required this.lastName,
      required this.password,
      required this.confrimPassword,
      required this.firstName});

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'uid': uid,
        'password': password,
        'email': email,
        'lastName': lastName,
        'confrimPassword': confrimPassword
      };

  ///
  static UserModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return UserModel(
      firstName: snapshot['firstName'],
      uid: snapshot['uid'],
      password: snapshot['password'],
      email: snapshot['email'],
      confrimPassword: snapshot['confrimPassword'],
      lastName: snapshot['lastName'],
    );
  }
}
