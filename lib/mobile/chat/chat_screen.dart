import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webtutorial/controller/chat/chat_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatController chatController = Get.put(ChatController());
  var args = Get.arguments;
  var receiverID ,receiverName;
  bool isOnline = false;

  @override
  void initState() {
    // TODO: implement initState
    receiverID = args['receiverID'];
    receiverName = args['receiverName'];
    isOnline = args['isOnline'];
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      chatController.scrollController.jumpTo(chatController.scrollController.position.maxScrollExtent);
    });
    super.initState();
  }



  // String formatTimestamp(Timestamp timestamp) {
  //   DateTime dateTime = timestamp.toDate();
  //   Duration difference = DateTime.now().difference(dateTime);
  //
  //   if (difference.inMinutes < 1) {
  //     return 'Just now';
  //   } else if (difference.inMinutes < 60) {
  //     return '${difference.inMinutes} min ago';
  //   } else if (difference.inHours < 24) {
  //     return '${difference.inHours} hours ago';
  //   } else {
  //     return '${difference.inDays} days ago';
  //   }
  // }
  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();

    // Extract the hour and minute from the DateTime
    int hour = dateTime.hour;
    int minute = dateTime.minute;

    // Determine if it's AM or PM
    String amPm = hour < 12 ? 'am' : 'pm';

    // Convert the hour to 12-hour format
    if (hour > 12) {
      hour -= 12;
    }

    // Format the time string as "hh:mm am/pm"
    String formattedTime = '$hour:${minute.toString().padLeft(2, '0')} $amPm';

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(receiverName),
            Text(isOnline ? 'Online' : 'Offline',style: TextStyle(fontSize: 11,color: Colors.grey),),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: chatController.getMessages(chatController.firebaseAuth.currentUser!.uid, receiverID),
              builder: (context, snapshot) {
                if(snapshot.hasError){
                  return Text('Error');
                }
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Text('Loading');
                }
                return ListView(
                  shrinkWrap: true,
                  controller: chatController.scrollController,
                  children: snapshot.data!.docs.map((e) {
                    Map<String,dynamic> data = e.data() as Map<String,dynamic>;
                    var alignment = (data['senderID'] == chatController.firebaseAuth.currentUser!.uid) ? Alignment.centerRight : Alignment.centerLeft;

                    return Container(
                      alignment: alignment,
                      // width: double.infinity,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: alignment == Alignment.centerLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                              children: [
                                Text(data["senderName"] ?? data["senderEmail"]),
                                Padding(
                                  padding: alignment == Alignment.centerLeft ? EdgeInsets.only(left: 20) :EdgeInsets.only(right: 20),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: alignment == Alignment.centerLeft ? BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)) : BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)) ,
                                        color: Colors.amber
                                    ),
                                    child: Column(
                                      crossAxisAlignment: alignment == Alignment.centerLeft ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                      children: [
                                        Text(data["message"],style: TextStyle(fontSize: 17)),
                                        Text(formatTimestamp(data["timestamp"]),style: TextStyle(fontSize: 8),),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0,right: 15, bottom: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: chatController.messageController,
                    decoration: const InputDecoration(
                      hintText: "Enter message"
                    ),
                  ),
                ),
                IconButton(
                  onPressed: (){
                    setState(() {

                    });
                    chatController.validate(receiverID);
                  },
                  icon: Icon(Icons.send,color: Colors.white,)
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
