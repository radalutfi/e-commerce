import 'package:flutter/material.dart';
import 'package:project_mobile/detail.dart';
import 'package:project_mobile/keranjang.dart';
import 'package:project_mobile/profil.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class ItemWidget extends StatefulWidget {
  const ItemWidget({super.key});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  final PageController pageController = PageController();
  int selectIndex = 0;

  final List<Produk> produkItem = const [
    Produk(
        gambar: "images/makanan-1.png",
        nama: "makanan 1",
        deskripsi: "makanan 1....",
        harga: "20.000",
        diskon: 20,
        rating: "4.9"),
    Produk(
        gambar: "images/makanan-2.png",
        nama: "makanan 2",
        deskripsi: "makanan 2....",
        harga: "30.000",
        diskon: 15,
        rating: "4.5"),
    Produk(
        gambar: "images/makanan-1.png",
        nama: "makanan 1",
        deskripsi: "makanan 1....",
        harga: "20.000",
        diskon: 20,
        rating: "4.9"),
    Produk(
        gambar: "images/makanan-2.png",
        nama: "makanan 2",
        deskripsi: "makanan 2....",
        harga: "30.000",
        diskon: 15,
        rating: "4.5"),
    Produk(
        gambar: "images/makanan-1.png",
        nama: "makanan 1",
        deskripsi: "makanan 1....",
        harga: "20.000",
        diskon: 20,
        rating: "4.9"),
    Produk(
        gambar: "images/makanan-2.png",
        nama: "makanan 2",
        deskripsi: "makanan 2....",
        harga: "30.000",
        diskon: 15,
        rating: "4.5"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Barang",
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Keranjang()),
                );
              }),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.68,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: produkItem.length,
        itemBuilder: (context, index) {
          final produk = produkItem[index];
          return ProdukCard(produk: produk);
        },
      ),
      bottomNavigationBar: WaterDropNavBar(
        backgroundColor: Colors.white,
        onItemSelected: (index) {
          setState(() {
            selectIndex = index;
          });
          if (index == 1) {
            Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const Keranjang(),
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
  final String gambar;
  final String nama;
  final String deskripsi;
  final String harga;
  final String rating;
  final int diskon;

  const Produk({
    required this.gambar,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.rating,
    required this.diskon,
  });
}

class ProdukCard extends StatelessWidget {
  final Produk produk;

  const ProdukCard({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffD9D9D9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xffE38E49),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "-${produk.diskon}%",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailProduk(produk: produk)),
              );
            },
            child: Image.asset(
              produk.gambar,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                produk.nama,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                produk.deskripsi,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rp${produk.harga}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 20,
                    ),
                    Text(produk.rating)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
