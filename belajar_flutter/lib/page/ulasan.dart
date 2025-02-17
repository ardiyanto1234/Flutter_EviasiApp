import 'package:flutter/material.dart';
import 'package:belajar_flutter/page/Dashboard.dart';
import 'package:belajar_flutter/services/ReviewService.dart';


class ulasan extends StatelessWidget {
  const ulasan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kirim Ulasan',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: SendReviewPage(),
    );
  }
}

class SendReviewPage extends StatefulWidget {
  const SendReviewPage({super.key});

  @override
  _SendReviewPageState createState() => _SendReviewPageState();
}

class _SendReviewPageState extends State<SendReviewPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reviewController = TextEditingController();
  final ReviewService _reviewService = ReviewService();

  final int _userId = 1; // Replace with the actual user ID

  Future<void> _submitReview() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await _reviewService.sendReview(_userId, _reviewController.text);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response['message'])));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to submit review: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 129, 120),
        title: const Text('Kirim Ulasan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tulis ulasan Anda:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _reviewController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Masukkan ulasan Anda di sini',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Silakan masukkan ulasan Anda';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  onPressed: _submitReview,
                  child: const Text('Kirim'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 