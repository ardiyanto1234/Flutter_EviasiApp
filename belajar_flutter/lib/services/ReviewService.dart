import 'dart:convert';
import 'package:http/http.dart' as http;

class ReviewService {
  final String apiUrl = 'http://efiasi.tifnganjuk.com/api/apieviasi/kirimulasan'; // Replace with your actual API URL

  Future<Map<String, dynamic>> sendReview(int userId, String? review) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'user_id': userId,
        'ulasan': review,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create review');
    }
  }
}
