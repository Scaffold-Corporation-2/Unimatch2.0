import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_match/constants/constants.dart';

class RegistrationRepository{


  final _firestore = FirebaseFirestore.instance;
  
  Future<bool> verificarAtletica(String id)async{
    return await _firestore.collection(C_ATHLETIC).doc(id).get().then((value) => value.exists);
  }
  
}