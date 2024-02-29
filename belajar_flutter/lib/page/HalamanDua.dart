import 'package:flutter/material.dart';

class HalamanDua extends StatelessWidget {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 129, 120),
        title: Text("Detailing mobil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nama Mobil',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                print('Text changed: $text');
                
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              
              onPressed: () {
                String enteredText = _controller.text;
                print('Entered text: $enteredText');
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 255, 129, 120),
                onPrimary: Colors.black,
              ),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}