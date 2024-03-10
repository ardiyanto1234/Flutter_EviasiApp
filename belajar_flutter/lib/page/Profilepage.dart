import 'package:flutter/material.dart';

void main() {
  runApp(ProfilePage());
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( 
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('img/gambar ilham.jpg'),
              ),
              Positioned(
                bottom: 0,
                right: 4,
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('Nama'),
                subtitle: Text('ilham Pugruk'),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              ListTile(
                title: Text('Email'),
                subtitle: Text('ArdiXgaming9.7@gmail.com'),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              ListTile(
                title: Text('No. Telepon'),
                subtitle: Text('085855348099'),
              ),
              Divider(
                color: Colors.black,
                thickness: 1, 
              ),
              ListTile(
                title: Text('Alamat'),
                subtitle: Text('Pugruk'),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    // Fungsi untuk mengedit profil
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow,
                    onPrimary: Colors.black,
                  ),
                  child: Text('Edit Profil'),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    // Fungsi untuk logout
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 255, 17, 0), 
                    onPrimary: Colors.black,
                  ),
                  child: Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
