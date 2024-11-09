import 'package:cloud_firestore/cloud_firestore.dart';

class GoalModel {
  String uid;
  String name;
  String notes;
  var amount;
  String date;
  String uuid;

  GoalModel(
      {required this.uid,
      required this.name,
      required this.notes,
      required this.uuid,
      required this.date,
      required this.amount});

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'amount': amount,
        'uid': uid,
        'uuid': uuid,
        'name': name,
        'notes': notes,
        'date': date
      };

  ///
  static GoalModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return GoalModel(
      amount: snapshot['amount'],
      uid: snapshot['uid'],
      uuid: snapshot['uuid'],
      name: snapshot['name'],
      date: snapshot['date'],
      notes: snapshot['notes'],
    );
  }
}
