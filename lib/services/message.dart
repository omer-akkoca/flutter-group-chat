import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Message {
  late FirebaseFirestore _firestore;

  Message() {
    _firestore = FirebaseFirestore.instance;
  }

  Future sendMessage({String text = "", String sender = ""}) {
    return _firestore
        .collection("messages")
        .add({"text": text, "sender": sender, "created_at": DateTime.now()});
  }

  Stream<QuerySnapshot> getMessageSnapshot() =>_firestore.collection('messages').orderBy('created_at', descending: true).snapshots();
}
