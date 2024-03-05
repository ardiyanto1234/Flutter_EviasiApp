import 'package:belajar_flutter/page/HalamanDua.dart';
import 'package:belajar_flutter/src/CustomColors.dart';
import 'package:flutter/material.dart';
import 'Profilepage.dart';

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
      body: IndexedStack(
        index: _currentIndex,
        children: [
          DashboardHome(),
          HalamanDua(), // Halaman 1
          ProfilePage(), // Halaman 2
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: CustomColors.blackColor,
        fixedColor: CustomColors.whiteColor,
        backgroundColor: CustomColors.redEviasi,
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

class HalamanDua extends StatefulWidget {
  static const Map<String, Color> colors = {
    'https://upload.wikimedia.org/wikipedia/commons/b/b2/Ganjar_Pranowo%2C_Candidate_for_Indonesia%27s_President_in_2024.jpg':
        Colors.red,
    'https://upload.wikimedia.org/wikipedia/commons/d/da/Ganjar_Pranowo_Candidate_for_Indonesia%27s_President_in_2024.jpg':
        Colors.green,
    'https://asset.kompas.com/crops/2uLBdHmN-Cs_T5ZjknreMDNGL5I=/0x0:0x0/750x500/data/photo/2022/10/24/635674ac0e45c.jpg':
        Colors.blue,
    // Add more image URLs and colors as needed
  };

  @override
  State<HalamanDua> createState() => _HalamanDuaState();
}

class _HalamanDuaState extends State<HalamanDua> {
  int _selectedIndex = 0;

  final List<String> imageUrls = [
    'https://upload.wikimedia.org/wikipedia/commons/b/b2/Ganjar_Pranowo%2C_Candidate_for_Indonesia%27s_President_in_2024.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/d/da/Ganjar_Pranowo_Candidate_for_Indonesia%27s_President_in_2024.jpg',
    'https://asset.kompas.com/crops/2uLBdHmN-Cs_T5ZjknreMDNGL5I=/0x0:0x0/750x500/data/photo/2022/10/24/635674ac0e45c.jpg',
    // Add more image URLs as needed
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToHalamanDua(String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HalamanDuaPage(
          gambar: imageUrl,
          colors: HalamanDua.colors[imageUrl] ??
              Colors.black, // Warna sesuai dengan map colors
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.purpleAccent,
                  Colors.deepPurple,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 150, // Set the height as per your requirement
              child: ListView.builder(
                physics: BouncingScrollPhysics(), // Allows overscroll animation
                scrollDirection: Axis.horizontal,
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  final imageUrl = imageUrls[index];
                  final color = HalamanDua.colors[imageUrl] ??
                      Colors.black; // Default color if not found
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        _navigateToHalamanDua(imageUrl);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                color, // Warna border sesuai dengan warna di map colors
                            width: 2.0, // Lebar border
                          ),
                        ),
                        child: Image.network(imageUrl),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
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

class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        backgroundColor: Colors.white,
      
        body: Container(
            padding: EdgeInsets.all(18.0),
            child: Column(
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
            )));
  }
}
