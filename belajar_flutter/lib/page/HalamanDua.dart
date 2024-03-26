import 'package:flutter/material.dart';

class HalamanDuaPage extends StatefulWidget {
  const HalamanDuaPage({
    super.key,
    required this.gambar,
    required this.colors,
  });

  final String gambar;
  final Color colors;

  @override
  State<HalamanDuaPage> createState() => _HalamanDuaState();
}
class _HalamanDuaState extends State<HalamanDuaPage> {
  Color warna = Colors.grey;

  void _pilihannya(Pilihan pilihan) {
    setState(() {
      warna = pilihan.warna;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('BT21'),
        backgroundColor: Colors.purpleAccent,
        actions: [
          PopupMenuButton(
              onSelected: _pilihannya,
              itemBuilder: (BuildContext context) {
                return listPilihan.map((Pilihan x) {
                  return PopupMenuItem<Pilihan>(
                    child: Text(x.teks),
                    value: x,
                  );
                }).toList();
              })
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                  center: Alignment.center,
                  colors: [Colors.purple, warna, Colors.deepPurple]),
            ),
          ),
          Center(
            child: ClipOval(
                child: SizedBox(
              width: 200.0,
              height: 200.0,
              child: Material(
                child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Flexible(
                        flex: 1,
                        child: Container(
                          color: widget.colors,
                          child: Image.asset(
                            "lib/imgtugas/${widget.gambar}",
                            fit: BoxFit.cover,
                          ),
                        ))),
              ),
            )),
          )
        ],
      ),
    );
  }
}

class Pilihan {
  Pilihan({required this.teks, required this.warna});

  final String teks;
  final Color warna;
}

List<Pilihan> listPilihan = <Pilihan>[
  Pilihan(teks: "Red", warna: Colors.red),
  Pilihan(teks: "Green", warna: Colors.green),
  Pilihan(teks: "Blue", warna: Colors.blue),
];