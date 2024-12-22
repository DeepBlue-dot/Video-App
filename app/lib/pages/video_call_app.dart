import 'package:app/pages/call/incoming_call.dart';
import 'package:app/services/service.dart';
import 'package:flutter/material.dart';
import 'home/keypad.dart';
import 'home/contacts.dart';
import 'home/recents.dart';

// StatefulWidget for VideoCallApp
class VideoCallApp extends StatefulWidget {
  const VideoCallApp({super.key});

  @override
  State<VideoCallApp> createState() => _VideoCallAppState();
}

class _VideoCallAppState extends State<VideoCallApp> {
  final ServiceManager _serviceManager = ServiceManager();

  @override
  Widget build(BuildContext context) {
    if (_serviceManager.incomingCall && _serviceManager.callerInfo != null) {
      return IncomingCallScreen(
          phoneNumber: _serviceManager.callerInfo!.callerId,
          callerName: _serviceManager.callerInfo!.name);
    }

    return MaterialApp(
      title: 'Video Call App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DefaultTabController(
        length: 3, // Number of tabs
        child: Scaffold(
          appBar: AppBar(title: Text(""),),
          body: const TabBarView(
            children: [
              Keypad(),
              Recents(),
              Contacts(),
            ],
          ),
          bottomNavigationBar: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.dialpad), text: "Keypad"),
              Tab(icon: Icon(Icons.history), text: "Recents"),
              Tab(icon: Icon(Icons.contacts), text: "Contacts"),
            ],
          ),
        ),
      ),
    );
  }
}
