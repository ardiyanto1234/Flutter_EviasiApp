import 'package:belajar_flutter/spalshscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Fresh_Harvest());
}

class Fresh_Harvest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(), //Class yang pertama di eksekusi ketika aplikasi di jalankan
     },
);
}
}