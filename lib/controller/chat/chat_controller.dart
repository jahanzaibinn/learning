import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webtutorial/model/chat_model.dart';

class ChatController extends GetxController {
  TextEditingController messageController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  validate(String receiverID){
    if(messageController.text.trim().isEmpty){

    }else{
      sendMessage(receiverID);
    }
  }

  sendMessage(String receiverID) async {
    String currentUserID = firebaseAuth.currentUser!.uid;
    String currentUserEmail = firebaseAuth.currentUser!.email.toString();
    String currentUserName = firebaseAuth.currentUser!.displayName.toString();
    Timestamp timestamp = Timestamp.now();
    MessageModel newMessage = MessageModel(
        senderID: currentUserID,
        senderEmail : currentUserEmail,
        senderName : currentUserName,
        receiverID :receiverID,
        message:messageController.text.trim(),
        timestamp:timestamp
    );
    List<String> ids = [currentUserID,receiverID];
    ids.sort();
    String chatRoomID = ids.join("_");
    await firestore.collection('chat_rooms').doc(chatRoomID).collection('messages').add(newMessage.toMap()).then((value) => messageController.clear());
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId){
    List<String> ids = [userId,otherUserId];
    ids.sort();
    String chatRoomID = ids.join("_");
    return firestore.collection('chat_rooms').doc(chatRoomID).collection('messages').orderBy('timestamp',descending: false).snapshots();

  }

}