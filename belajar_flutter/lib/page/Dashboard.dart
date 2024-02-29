import 'package:belajar_flutter/src/CustomColors.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 129, 120),
        title: Text("EVIASI"),
        actions: <Widget>[
          Padding(
          padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications_active),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(18.0),
        child: _currentIndex == 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        HalamanDua(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                })); // Handle kategori 1
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 255, 129, 120),
                        onPrimary: Colors.white,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Detailing mobil',
                              style: TextStyle(fontSize: 18),
                            ),
                            Icon(Icons.car_repair,
                                size: 50.0,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ])),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Handle kategori 2
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 255, 129, 120),
                      onPrimary: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sparepart Variasi',
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(Icons.directions_car_sharp,
                            size: 50.0,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ],
                    ),
                  ),
                ],
              )
            : Center(
                child: Text(
                  'Halaman ${_currentIndex + 1}',
                  style: TextStyle(fontSize: 24),
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
      unselectedItemColor: CustomColors.blackColor,
        fixedColor: CustomColors.blackColor,
        backgroundColor: CustomColors.blackColor,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: CustomColors.redEviasi,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
             backgroundColor: CustomColors.redEviasi,
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem
          (
             backgroundColor: CustomColors.redEviasi,icon: Icon(Icons.reviews_outlined),
          label: 'Ulasan',
          ),
          BottomNavigationBarItem(
             backgroundColor: CustomColors.redEviasi,
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

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
                primary: Colors.red,
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

class HalamanTiga extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Sparepart Variasi"),
      ),
      body: Center(
        child: Text("Coming Soon"),
      ),
    );
  }
}
