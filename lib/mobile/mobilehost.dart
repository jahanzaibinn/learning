import 'dart:math';

import 'package:flutter/material.dart';
import 'package:webtutorial/mobile/bgremover.dart';
import 'package:webtutorial/utils/jitsi.dart';

class MobileHost extends StatefulWidget {
  const MobileHost({super.key});

  @override
  State<MobileHost> createState() => _MobileHostState();
}

class _MobileHostState extends State<MobileHost> {
  late TextEditingController meetingID;
  late TextEditingController userName;
  JitsiMeetMethod jitsiMeetMethod = JitsiMeetMethod();

  @override
  void initState() {
    // TODO: implement initState
    meetingID = TextEditingController();
    userName = TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    meetingID.dispose();
    userName.dispose();
  }

  joinMeeting(){
    jitsiMeetMethod.joinMeeting(roomName: meetingID.text,userName: userName.text);
  }

  @override
  Widget build(BuildContext context) {
    var random = Random();
    String roomName = (random.nextInt(10000) + 10000).toString();
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white10,
            title: const Text(
              'Whatsapp',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(onPressed: (){
                JitsiMeetMethod().createNewMeeting(roomName: roomName);
              }, icon: Icon(Icons.camera_alt_outlined,color: Colors.white,)),
              IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.white,)),
              IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Colors.white,)),
            ],
            bottom: const TabBar(
              indicatorWeight: 4,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.teal,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(icon: Icon(Icons.group)),
                Tab(text: "Meetings",),
                Tab(text: "Status",),
                Tab(text: "Calls",),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Name'),
                    subtitle: Text('Message'),
                    leading: CircleAvatar(
                      child: Image.network('https://protocoderspoint.com/wp-content/uploads/2019/10/mypic-300x300.jpg'),
                    ),
                    trailing: Text("${DateTime.now()}"),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 25),
                child: Column(
                  children: [
                    TextField(
                      controller: meetingID,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Meeting ID',
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0)
                      ),
                    ),
                    TextField(
                      controller: userName,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: 'User Name',
                          contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0)
                      ),
                    ),
                    TextButton(
                      onPressed: joinMeeting,
                      child: Text('Join')
                    )
                  ],
                ),
              ),
              RemoveBackgroundScreen()
            ],
          ),
        ));
  }
}
