import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/constants/constants.dart';
part 'party_store.g.dart';

class PartyStore = _PartyStore with _$PartyStore;

abstract class _PartyStore with Store{

  final AppController i18n = Modular.get();
  final _firestore = FirebaseFirestore.instance;
  /// Get stream notifications for current user

  Stream<QuerySnapshot> getParties() {
    /// Build query
    return _firestore
        .collection(C_PARTY)
        .orderBy(DATE_PARTY, descending: false)
        .snapshots();
  }

}
