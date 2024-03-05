import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        
        body: ProfileBody(),
      ),
    );
  }
}

class ProfileBody extends StatefulWidget {
  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('img/gambar ilham.jpg'),
          ),
          SizedBox(height: 20),
          Text(
            'Nama Pengguna: Ilham pugruk',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Alamat Pengguna: Desa pugruk kecamatan Brebek',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            'Nomor Telepon: tidak di ketahui',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // Tambahkan logika untuk mengedit profil di sini
              // Misalnya, Navigasi ke halaman edit profil
            },
            child: Text('Edit Profil'),
          ),
        ],
      ),
    );
  }
}
