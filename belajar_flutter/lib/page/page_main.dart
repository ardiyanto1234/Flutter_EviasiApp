import 'package:flutter/material.dart';
import 'package:belajar_flutter/src/CustomColors.dart';
class PageMain extends StatelessWidget {
  const PageMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eviasi"),
        backgroundColor: CustomColors.primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton(context, "Layout Satu", LayoutOne()),
            const SizedBox(height: 20),
            buildButton(context, "Layout Dua", LayoutTwo()),
            const SizedBox(height: 20),
            buildButton(context, "Flutter Layout Example", FlutterLayoutExample()),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildButton(BuildContext context, String buttonText, Widget route) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => route,
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.secondaryColor,
      ),
      child: Text(buttonText),
    );
  }
}




class LayoutOne extends StatelessWidget {
  const LayoutOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Layout Satu"),
        backgroundColor: CustomColors.primaryColor,
      ),
      body: const Center(
        child: Text(
          "Ini adalah layout satu",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class LayoutTwo extends StatelessWidget {
  const LayoutTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Layout Dua"),
        backgroundColor: CustomColors.primaryColor,
      ),
      body: const Center(
        child: Text(
          "Ini adalah layout dua",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}





class FlutterLayoutExample extends StatelessWidget {
  const FlutterLayoutExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contoh Layout Flutter'),
      ),
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.access_alarm),
              title: const Text('List Tile 1'),
              subtitle: const Text('Ini adalah contoh list tile pertama'),
              onTap: () {
                // Aksi saat list tile ditekan
              },
            ),
          ),
          Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text('List Tile 2'),
              subtitle: const Text('Ini adalah contoh list tile kedua'),
              onTap: () {
                // Aksi saat list tile ditekan
              },
            ),
          ),
          Card(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.network(
                  'https://via.placeholder.com/150',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Judul Card',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Deskripsi singkat dari card ini.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
          // Tambahkan widget lainnya di sini sesuai kebutuhan
        ],
      ),
    );
  }
}