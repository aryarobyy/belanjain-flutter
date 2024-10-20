import 'package:flutter/material.dart';
import 'package:tugas_dicoding/screen/login_screen.dart';
import 'main_screen.dart';

int halaman = 0;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Belanjain',
      'subtitle': 'Nikmati Diskon yang besar dari belanjain',
      'image': 'assets/images/shopping.png',
    },
    {
      'title': 'Belanjain',
      'subtitle': 'Banyak Barang Menarik',
      'image': 'assets/images/gia1.png',
    },
    {
      'title': 'Belanjain',
      'subtitle': 'Jangan Lewatkan Penawaran Terbaik',
      'image': 'assets/images/gia2.png',
    },
  ];

  void _nextPage() {
    setState(() {
      if (halaman < _pages.length - 1) {
        halaman += 1;
      } else if (halaman == _pages.length) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      }
    });
  }

  void _previousPage() {
    setState(() {
      if (halaman > 0) {
        halaman -= 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Belanjain')),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _pages[halaman]['title'],
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(_pages[halaman]['subtitle']),
              ),
              Flexible(
                child: SizedBox(
                  height: 600,
                  child: Image.asset(
                    _pages[halaman]['image'],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text('Halaman: ${halaman + 1}'),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child:SizedBox(
                            width: MediaQuery.of(context).size.width < 600
                                ? 130
                                : 200,
                            child: ElevatedButton(
                              onPressed: halaman > 0 ? _previousPage : null,
                              child: const Text('Kembali'),
                            ),
                          )
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width < 600
                                  ? 130
                                  : 200,
                            child: ElevatedButton(
                              onPressed: () {
                                if (halaman < _pages.length - 1)
                                {
                                  _nextPage();
                                } else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const MainScreen(),
                                    ),
                                  );
                                }
                              },
                              child: const Text('Lanjut'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
