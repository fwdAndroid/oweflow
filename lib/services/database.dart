import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:oweflow/models/goal_model.dart';
import 'package:uuid/uuid.dart';

class Database {
  var uuid = Uuid().v4();
  //Register User with Add User
  Future<String> addGoal(
      {required String name,
      required String notes,
      required var amount,
      required String date}) async {
    String res = 'Some error occured';
    try {
      //Add User to the database with modal
      GoalModel userModel = GoalModel(
          amount: amount,
          uid: FirebaseAuth.instance.currentUser!.uid,
          name: name,
          uuid: uuid,
          date: date,
          notes: notes);
      await FirebaseFirestore.instance
          .collection('goals')
          .doc(uuid)
          .set(userModel.toJson());
      res = 'sucess';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
