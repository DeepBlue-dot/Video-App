import 'package:app/pages/call/call_ended.dart';
import 'package:flutter/material.dart';

class StartVideoCall extends StatefulWidget {
  final String phoneNumber;

  const StartVideoCall({super.key, required this.phoneNumber});

  @override
  State<StartVideoCall> createState() => _StartVideoCallState();
}

class _StartVideoCallState extends State<StartVideoCall>
    with SingleTickerProviderStateMixin {
  String callStatus = "Connecting...";
  bool isCameraOn = true;
  bool isMicOn = true;
  bool isSpeakerOn = true;
  bool isMinimized = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        callStatus = "Connected";
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Expanded(
          child: Stack(
            children: [
              // Main video view (remote user)
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey[900],
                child: const Center(
                  child: Icon(
                    Icons.person,
                    size: 120,
                    color: Colors.white54,
                  ),
                ),
              ),

              // Local video preview
              Positioned(
                top: 50,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isMinimized = !isMinimized;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: isMinimized ? 100 : 120,
                    height: isMinimized ? 150 : 180,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white24, width: 2),
                    ),
                    child: const Stack(
                      fit: StackFit.expand,
                      children: [
                        Center(
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Call status and timer
              Positioned(
                top: 50,
                left: 20,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: callStatus == "Connected"
                              ? Colors.greenAccent
                              : Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        callStatus,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom controls
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black87, Colors.transparent],
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.phoneNumber,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildControlButton(
                            icon: isMicOn ? Icons.mic : Icons.mic_off,
                            color: isMicOn ? Colors.white : Colors.red,
                            backgroundColor: Colors.grey[800]!,
                            onTap: () {
                              setState(() {
                                isMicOn = !isMicOn;
                              });
                            },
                          ),
                          _buildControlButton(
                            icon: isCameraOn
                                ? Icons.videocam
                                : Icons.videocam_off,
                            color: isCameraOn ? Colors.white : Colors.red,
                            backgroundColor: Colors.grey[800]!,
                            onTap: () {
                              setState(() {
                                isCameraOn = !isCameraOn;
                              });
                            },
                          ),
                          _buildControlButton(
                            icon: Icons.call_end,
                            color: Colors.white,
                            backgroundColor: Colors.red,
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CallEndedScreen(
                                          phoneNumber: '+1 234 567 8900',
                                          callerName: 'John Doe',
                                          callDuration: const Duration(
                                              minutes: 5, seconds: 32),
                                          wasVideoCall: false,
                                          wasCallAccepted: true,
                                        )),
                              )
                            },
                            size: 70,
                          ),
                          _buildControlButton(
                            icon: isSpeakerOn
                                ? Icons.volume_up
                                : Icons.volume_off,
                            color: isSpeakerOn ? Colors.white : Colors.red,
                            backgroundColor: Colors.grey[800]!,
                            onTap: () {
                              setState(() {
                                isSpeakerOn = !isSpeakerOn;
                              });
                            },
                          ),
                          _buildControlButton(
                            icon: Icons.switch_camera,
                            color: Colors.white,
                            backgroundColor: Colors.grey[800]!,
                            onTap: () {
                              // Implement camera switch functionality
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildControlButton({
    required IconData icon,
    required Color color,
    required Color backgroundColor,
    required VoidCallback onTap,
    double size = 60,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: color,
          size: size * 0.4,
        ),
      ),
    );
  }
}
