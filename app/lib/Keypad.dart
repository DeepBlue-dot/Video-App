import 'package:flutter/material.dart';

class Keypad extends StatefulWidget {
  const Keypad({super.key});

  @override
  State<Keypad> createState() => _KeypadState();
}

class _KeypadState extends State<Keypad> {
  String _input = "";

  void _onKeyPressed(String value) {
    setState(() {
      _input += value;
    });
  }

  void _onDialPressed() {
    if (_input.isNotEmpty) {
      // Simulate dialing the number
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Dialing: $_input'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a number to dial'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Display the dialed input
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Text(
            _input,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        // Dial keypad
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 7,
            crossAxisSpacing: 7,
            padding: const EdgeInsets.all(40),
            children: [
              ..._buildKeypadButtons(),
            ],
          ),
        ),
        Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 40.0),
                child: ElevatedButton.icon(
                  onPressed: _onDialPressed,
                  icon: const Icon(Icons.phone, color: Color.fromARGB(255, 0, 170, 23)),
                  label: const SizedBox.shrink(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                )))
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              key['label']!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (key['letters']!.isNotEmpty)
              Text(
                key['letters']!,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
          ],
        ),
      );
    }).toList();
  }
}

  // Helper function to build keypad buttons

