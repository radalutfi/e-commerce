import 'package:flutter/material.dart';
import 'package:project_mobile/dashboard.dart';
import 'package:status_alert/status_alert.dart';

class DetailProduk extends StatefulWidget {
  final Produk produk;

  const DetailProduk({super.key, required this.produk});

  @override
  _DetailProdukState createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {
  String selectedButton = 'Detail';
  String selectWeight = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffD9D9D9),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.produk.gambar),
                    fit: BoxFit.cover,
                  ),
                  color: const Color(0xffD9D9D9),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.produk.nama,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 35),
                    ),
                    Text(
                      "Rp${widget.produk.harga}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: Color(0xff180161)),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Pilih Berat",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    weightOption('1kg'),
                    weightOption('2kg'),
                    weightOption('3kg'),
                    weightOption('5kg'),
                    weightOption('10kg'),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    buttonOption('Detail'),
                    const SizedBox(
                      width: 10,
                    ),
                    buttonOption('Review'),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Detail Produk",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit sed doLorem ipsum dolor sit amet, consectetur adipiscing elit sed do",
                    style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(
                    bottom: 25, top: 10, right: 20, left: 20),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Colors.black.withOpacity(0.2),
                        width: 1,
                      ),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Total"),
                        Text(
                          "Rp${widget.produk.harga}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (selectWeight.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Pilih berat barang terlebih dahulu"),
                          ));
                        } else {
                          StatusAlert.show(context,
                              duration: const Duration(seconds: 3),
                              backgroundColor: Colors.black87,
                              subtitle:
                                  'Barang berhasil dimasukan ke keranjang',
                              configuration: const IconConfiguration(
                                  icon: Icons.check_box_outlined,
                                  color: Colors.white),
                              maxWidth: 230,
                              subtitleOptions: StatusAlertTextConfiguration(
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal)));
                        }
                      },
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Keranjang",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff180161),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 35)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonOption(String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedButton = label;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          color:
              selectedButton == label ? Color(0xff180161) : Color(0xffD9D9D9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selectedButton == label ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget weightOption(String weight) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectWeight = weight;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 60,
        decoration: BoxDecoration(
          color: selectWeight == weight ? Color(0xff180161) : Color(0xffD9D9D9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          weight,
          style: TextStyle(
            color: selectWeight == weight ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
