import 'package:flutter/material.dart';

void main() {
  runApp(ulasan());
}

class ulasan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kirim Ulasan',
      theme: ThemeData(
      ),
      debugShowCheckedModeBanner: false,
      home: SendReviewPage(),
    );
  }
}

class SendReviewPage extends StatefulWidget {
  @override
  _SendReviewPageState createState() => _SendReviewPageState();
}

class _SendReviewPageState extends State<SendReviewPage> {
  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Color.fromARGB(255, 255, 129, 120), 
        title: Text('Kirim Ulasan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tulis ulasan Anda:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: reviewController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Masukkan ulasan Anda di sini',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Fungsi untuk mengirim ulasan
                  sendReview(reviewController.text);
                },
                child: Text('Kirim'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendReview(String review) {
    // Kode untuk mengirim ulasan
    print('Mengirim ulasan: $review');
    // Di sini Anda dapat menambahkan logika pengiriman ulasan ke server
  }
}
