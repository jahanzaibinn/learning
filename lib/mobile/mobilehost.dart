import 'package:flutter/material.dart';

class MobileHost extends StatefulWidget {
  const MobileHost({super.key});

  @override
  State<MobileHost> createState() => _MobileHostState();
}

class _MobileHostState extends State<MobileHost> {
  @override
  Widget build(BuildContext context) {
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
              IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt_outlined,color: Colors.white,)),
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
                Tab(text: "Chats",),
                Tab(text: "Status",),
                Tab(text: "Calls",),
              ],
            ),
          ),
          body: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Name'),
                  subtitle: Text('Message'),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage("https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.flaticon.com%2Ffree-icon%2Fuser-picture_21104&psig=AOvVaw06uxtgh8lUARUxQcuPbYXv&ust=1692878774178000&source=images&cd=vfe&opi=89978449&ved=0CA4QjRxqFwoTCNjLnpHf8oADFQAAAAAdAAAAABAT"),
                  ),
                  trailing: Text("${DateTime.now()}"),
                );
              },
          ),
        ));
  }
}
