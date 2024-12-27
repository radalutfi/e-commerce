import 'package:flutter/material.dart';
import 'package:project_mobile/dashboard.dart';
import 'package:project_mobile/pemesanan.dart';
import 'package:project_mobile/profil.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class Keranjang extends StatefulWidget {
  const Keranjang({super.key});

  @override
  State<Keranjang> createState() => _KeranjangState();
}

class _KeranjangState extends State<Keranjang> {
  final PageController pageController = PageController();
  int selectIndex = 1;
  Set<int> selectedItemIndex = {};
  double get totalHarga {
    double total = 0;
    for (int index in selectedItemIndex) {
      final selectedItem = semuaProduk[index];
      total += selectedItem.jumlah *
          double.parse(
              selectedItem.harga.replaceAll('Rp', '').replaceAll('.', ''));
    }
    return total;
  }

  int get totalBarang {
    int total = 0;
    for (int index in selectedItemIndex) {
      total += semuaProduk[index].jumlah;
    }
    return total;
  }

  final List<Produk> semuaProduk = [
    Produk(
      nama: "Makanan 1",
      harga: "Rp20.000",
      gambar: 'images/makanan-1.png',
      jumlah: 1,
    ),
    Produk(
      nama: "Makanan 2",
      harga: "Rp20.000",
      gambar: 'images/makanan-2.png',
      jumlah: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Keranjang",
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: semuaProduk.length,
              itemBuilder: (context, index) {
                return Dismissible(
                    key: Key(semuaProduk[index].nama),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Color(0xffD9D9D9),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete_sharp, color: Colors.red),
                    ),
                    onDismissed: (direction) {
                      String namaProduk = semuaProduk[index].nama;
                      setState(() {
                        semuaProduk.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$namaProduk dihapus')),
                      );
                    },
                    child: ListTile(
                      leading: Checkbox(
                        value: selectedItemIndex.contains(index),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              selectedItemIndex.add(index);
                            } else {
                              selectedItemIndex.remove(index);
                            }
                          });
                        },
                      ),
                      title: Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Color(0xffd9d9d9),
                                  image: DecorationImage(
                                      image:
                                          AssetImage(semuaProduk[index].gambar),
                                      fit: BoxFit.cover)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    semuaProduk[index].nama,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    semuaProduk[index].harga,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      if (semuaProduk[index].jumlah > 1) {
                                        semuaProduk[index].jumlah--;
                                      }
                                    });
                                  },
                                ),
                                Text(
                                  '${semuaProduk[index].jumlah}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      semuaProduk[index].jumlah++;
                                    });
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ));
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: Offset(0, -1),
                blurRadius: 4,
              )
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total Barang : $totalBarang",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("Total Harga: Rp $totalHarga",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold))
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedItemIndex.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text("Pilih minimal 1 barang sebelum memesan!")));
                    } else {
                      List<Produk> selectedProduks = selectedItemIndex
                          .map((index) => semuaProduk[index])
                          .toList();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Pemesanan(
                                    produkList: selectedProduks,
                                  )));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff180161),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12)),
                  child: const Text(
                    "Pemesanan",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: WaterDropNavBar(
        backgroundColor: Colors.white,
        onItemSelected: (index) {
          setState(() {
            selectIndex = index;
          });
          if (index == 0) {
            Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const ItemWidget(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(-1, 0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                          position: offsetAnimation, child: child);
                    }));
          } else if (index == 2) {
            Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const ProfilePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1, 0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                          position: offsetAnimation, child: child);
                    }));
          }
          pageController.animateToPage(selectIndex,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuad);
        },
        selectedIndex: selectIndex,
        barItems: [
          BarItem(
            filledIcon: Icons.home,
            outlinedIcon: Icons.home_outlined,
          ),
          BarItem(
            filledIcon: Icons.shopping_cart,
            outlinedIcon: Icons.shopping_cart_outlined,
          ),
          BarItem(
            filledIcon: Icons.person,
            outlinedIcon: Icons.person_outline,
          ),
        ],
      ),
    );
  }
}

class Produk {
  final String nama;
  final String harga;
  final String gambar;
  int jumlah;

  Produk({
    required this.nama,
    required this.harga,
    required this.gambar,
    this.jumlah = 1,
  });
}
