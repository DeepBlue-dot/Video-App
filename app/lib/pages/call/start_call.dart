import 'package:flutter/material.dart';

class StartCall extends StatefulWidget {
  final String phoneNumber;

  const StartCall({super.key, required this.phoneNumber});

  @override
  State<StartCall> createState() => _StartCallState();
}

class _StartCallState extends State<StartCall>
    with SingleTickerProviderStateMixin {
  String callStatus = "Calling...";
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animations
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Simulate call connecting after 3 seconds
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
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Column(
          children: [
            // Top section with time and signal indicators
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.wifi, color: Colors.white, size: 16),
                        SizedBox(width: 8),
                        Text(
                          'HD Video',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Avatar and call info
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: callStatus == "Calling..."
                          ? _scaleAnimation.value
                          : 1.0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              spreadRadius: 10,
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              const AssetImage('assets/placeholder.png'),
                          backgroundColor: Colors.grey[800],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                Text(
                  widget.phoneNumber,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  callStatus,
                  style: TextStyle(
                    fontSize: 20,
                    color: callStatus == "Connected"
                        ? Colors.greenAccent
                        : Colors.grey[400],
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Bottom controls
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCircularButton(
                    Icons.volume_up,
                    Colors.grey[800]!,
                    () {},
                  ),
                  _buildCircularButton(
                    Icons.call_end,
                    Colors.red,
                    () => Navigator.pop(context),
                  ),
                  _buildCircularButton(
                    Icons.mic,
                    Colors.grey[800]!,
                    () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: icon == Icons.call_end ? _pulseAnimation.value : 1.0,
            child: Container(
              width: icon == Icons.call_end ? 70 : 60,
              height: icon == Icons.call_end ? 70 : 60,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: icon == Icons.call_end ? 30 : 25,
              ),
            ),
          );
        },
      ),
    );
  }
}
