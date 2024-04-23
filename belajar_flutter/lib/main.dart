import 'package:belajar_flutter/services/google_signin_services.dart';
import 'package:belajar_flutter/spalshscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:belajar_flutter/firebase_options.dart';
import 'package:provider/provider.dart';


void main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  // // await Firebase.initializeApp(
  //   // options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(Fresh_Harvest());
}

class Fresh_Harvest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleSignService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(), //Class yang pertama di eksekusi ketika aplikasi di jalankan
       },
    ),
    );
}
}