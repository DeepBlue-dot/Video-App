import 'package:app/pages/call/incoming_call.dart';
import 'package:flutter/material.dart';

class Keypad extends StatefulWidget {
  const Keypad({super.key});

  @override
  State<Keypad> createState() => _KeypadState();
}

class _KeypadState extends State<Keypad> {
  String _input = "";

  static const int _maxInputLength = 15;

  void _onKeyPressed(String value) {
    if (_input.length < _maxInputLength) {
      setState(() {
        _input += value;
      });
    }
  }

  void _onDeletePressed() {
    setState(() {
      if (_input.isNotEmpty) {
        _input = _input.substring(0, _input.length - 1);
      }
    });
  }

  void _onClearPressed() {
    setState(() {
      _input = "";
    });
  }

  void _onDialPressed() {
// Example usage:
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const IncomingCallScreen(
          phoneNumber: '+1 234 567 8900',
          callerName: 'John Doe',
          isVideo: true, // Set to false for voice calls
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Display the dialed input
        Container(
          margin: const EdgeInsets.symmetric(vertical: 50),
          child: Text(
            _input,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
        // Dial keypad
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            children: [
              ..._buildKeypadButtons(),
              _buildActionButton(
                icon: Icons.clear,
                color: Colors.transparent,
                onPressed: _onClearPressed,
              ),
              _buildActionButton(
                icon: Icons.phone,
                color: const Color.fromARGB(255, 0, 170, 23),
                onPressed: _onDialPressed,
              ),
              _buildActionButton(
                icon: Icons.backspace,
                color: Colors.transparent,
                onPressed: _onDeletePressed,
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildKeypadButtons() {
    final keys = [
      {'label': '1', 'letters': ''},
      {'label': '2', 'letters': 'ABC'},
      {'label': '3', 'letters': 'DEF'},
      {'label': '4', 'letters': 'GHI'},
      {'label': '5', 'letters': 'JKL'},
      {'label': '6', 'letters': 'MNO'},
      {'label': '7', 'letters': 'PQRS'},
      {'label': '8', 'letters': 'TUV'},
      {'label': '9', 'letters': 'WXYZ'},
      {'label': '*', 'letters': ''},
      {'label': '0', 'letters': '+'},
      {'label': '#', 'letters': ''},
    ];

    return keys.map((key) {
      return GestureDetector(
        onTap: () => _onKeyPressed(key['label']!),
        child: Container(
          margin: const EdgeInsets.all(2), // Space between buttons
          decoration: BoxDecoration(
            color: Colors.transparent, // Button background color
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  key['label']!,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (key['letters']!.isNotEmpty)
                  Text(
                    key['letters']!,
                    style: const TextStyle(fontSize: 10, color: Colors.black54),
                  ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.all(15),
          backgroundColor: color, // Button background color
        ),
        child: Icon(icon, size: 28, color: const Color.fromARGB(255, 0, 0, 0)),
      ),
    );
  }
}
