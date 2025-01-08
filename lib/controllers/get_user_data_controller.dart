import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GetUserDataController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Object?>>> getUserData(String uId) async {
    QuerySnapshot querySnapshot =
        await firestore.collection('users').where('uId', isEqualTo: uId).get();
    return querySnapshot.docs;
  }
}
