import 'package:flutter/material.dart';

import 'artikel.dart';
import 'utama.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SkincarePage(),
    );
  }
}

class SkincarePage extends StatefulWidget {
  @override
  _SkincarePageState createState() => _SkincarePageState();
}

class _SkincarePageState extends State<SkincarePage> {
  List<Map<String, dynamic>> skincareList = [
    {
      "name": "Wardah Nature Daily Aloe Hydramild Moisturizer Cream",
      "image": "img/skin.jpg",
      "brand": "Wardah",
      "details": "Moisturizer dengan aloe vera untuk melembapkan kulit.",
      "price": 30000,
      "skinType": "Kering",
    },
    {
      "name": "Emina Sun Protection SPF 30",
      "image": "img/skin.jpg",
      "brand": "Emina",
      "details": "Tabir surya dengan SPF 30 untuk perlindungan harian.",
      "price": 35000,
      "skinType": "Normal",
    },
    {
      "name": "Nivea Soft Moisturizing Cream",
      "image": "img/skin.jpg",
      "brand": "Nivea",
      "details": "Krim pelembap serbaguna untuk wajah dan tubuh.",
      "price": 50000,
      "skinType": "Sensitif",
    },
    {
      "name": "Citra Pearly White UV Lotion",
      "image": "img/skin.jpg",
      "brand": "Citra",
      "details": "Lotion dengan perlindungan UV dan mencerahkan kulit.",
      "price": 10000,
      "skinType": "Berminyak",
    },
    {
      "name": "Himalaya Herbals Nourishing Skin Cream",
      "image": "img/skin.jpg",
      "brand": "Himalaya",
      "details": "Krim pelembap dengan bahan herbal untuk kulit kering.",
      "price": 20000,
      "skinType": "Kering",
    },
    {
      "name": "Mama's Choice Daily Protection Face Moisturizer",
      "image": "img/skin.jpg",
      "brand": "Mama's Choice",
      "details": "Pelembap harian untuk ibu hamil dengan perlindungan ekstra.",
      "price": 32000,
      "skinType": "Kering",
    },
    {
      "name": "Sensatia Botanicals Blossom Facial Dream Cream",
      "image": "img/skin.jpg",
      "brand": "Sensatia Botanicals",
      "details": "Krim wajah dengan bahan alami yang menenangkan kulit.",
      "price": 120000,
      "skinType": "Sensitif",
    }
  ];

  List<Map<String, dynamic>> favoriteList = [];
  List<Map<String, dynamic>> displayedList = [];

  @override
  void initState() {
    super.initState();
    displayedList = List.from(skincareList);
  }

  void filterSearch(String query) {
    setState(() {
      displayedList = skincareList
          .where((item) =>
              item["name"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void toggleFavorite(Map<String, dynamic> product) {
    setState(() {
      if (favoriteList.contains(product)) {
        favoriteList.remove(product);
      } else {
        favoriteList.add(product);
      }
    });
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      // Home
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PregnancyTracker()),
      );
    } else if (index == 1) {
      // Note (kosong untuk sekarang)
    } else if (index == 2) {
      // Article
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ArticleScreen()),
      );
    }
  }

  void applyAdvancedFilter({String? skinType, int? maxPrice}) {
    setState(() {
      displayedList = skincareList.where((item) {
        bool matchPrice = maxPrice == null || (item["price"] ?? 0) <= maxPrice;
        bool matchSkinType = skinType == null || item["skinType"] == skinType;
        return matchPrice && matchSkinType;
      }).toList();
    });
  }

  Widget buildFilterSheet() {
    String? selectedSkinType;
    int? selectedPrice;

    return StatefulBuilder(
      builder: (context, setModalState) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Filter Skincare",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                value: selectedSkinType,
                hint: Text("Pilih Tipe Kulit"),
                isExpanded: true,
                items: ["Normal", "Kering", "Berminyak", "Sensitif"]
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (val) {
                  setModalState(() => selectedSkinType = val);
                },
              ),
              Slider(
                value: (selectedPrice ?? 50000).toDouble(),
                min: 10000,
                max: 300000,
                divisions: 10,
                label: selectedPrice?.toString() ?? "Max 50000",
                onChanged: (val) {
                  setModalState(() => selectedPrice = val.toInt());
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  applyAdvancedFilter(
                    skinType: selectedSkinType,
                    maxPrice: selectedPrice,
                  );
                },
                child: Text("Terapkan Filter"),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Note',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Article',
          ),
        ],
        onTap: _onItemTapped,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.7,
              child: Image.asset("img/wp.png", fit: BoxFit.cover),
            ),
          ),
          Column(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromRGBO(251, 231, 231, 1),
                      const Color.fromRGBO(246, 210, 210, 1)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          Text(
                            "Cari Rekomendasi Skincare untuk bumil di sini",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(71, 77, 144, 1),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8), // Jarak antara teks dan garis
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  thickness: 1.2,
                                  indent: 20,
                                  endIndent: 10,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigasi ke halaman favorit
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FavoritePage(favorites: favoriteList),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.star,
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        onChanged: filterSearch,
                        decoration: InputDecoration(
                          hintText: "Cari Skincare...",
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.filter_list),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => FilterDialog(
                                  selectedSkinType: null,
                                  minPrice: null,
                                  maxPrice: null,
                                  onApply: (skinType, minPrice, maxPrice) {
                                    applyAdvancedFilter(
                                      skinType: skinType,
                                      maxPrice: maxPrice,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          filled: true,
                          fillColor: const Color.fromARGB(61, 249, 249, 249),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: displayedList.length,
                  itemBuilder: (context, index) {
                    var product = displayedList[index];
                    bool isFavorite = favoriteList.contains(product);

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SkincareDetail(product: product),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(245, 227, 227, 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 120, top: 0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.star,
                                  color: isFavorite
                                      ? const Color.fromARGB(255, 220, 153, 153)
                                      : Colors.grey,
                                ),
                                onPressed: () => toggleFavorite(product),
                              ),
                            ),
                            Image.asset(product["image"], height: 80),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                product["name"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromRGBO(71, 77, 144, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FilterDialog extends StatefulWidget {
  final String? selectedSkinType;
  final int? minPrice;
  final int? maxPrice;
  final Function(String?, int?, int?) onApply;

  FilterDialog({
    this.selectedSkinType,
    this.minPrice,
    this.maxPrice,
    required this.onApply,
  });

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String? skinType;
  int? min;
  int? max;

  @override
  void initState() {
    super.initState();
    skinType = widget.selectedSkinType;
    min = widget.minPrice;
    max = widget.maxPrice;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Filter Produk"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tipe Kulit:"),
            Wrap(
              spacing: 8,
              children:
                  ["Normal", "Kering", "Berminyak", "Sensitif"].map((type) {
                return FilterChip(
                  label: Text(type),
                  selected: skinType == type,
                  onSelected: (bool selected) {
                    setState(() {
                      skinType = selected ? type : null;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text("Harga:"),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Min"),
                    onChanged: (val) => min = int.tryParse(val),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Max"),
                    onChanged: (val) => max = int.tryParse(val),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Batal"),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onApply(skinType, min, max);
            Navigator.of(context).pop();
          },
          child: Text("Terapkan"),
        ),
      ],
    );
  }
}

class SkincareDetail extends StatefulWidget {
  final Map<String, dynamic> product;

  SkincareDetail({required this.product});

  @override
  _SkincareDetailState createState() => _SkincareDetailState();
}

class _SkincareDetailState extends State<SkincareDetail> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Text(
          widget.product["name"],
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(
              Icons.star,
              color: isFavorite
                  ? const Color.fromARGB(255, 220, 153, 153)
                  : Colors.grey,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(247, 207, 216, 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk
            Image.asset(
              widget.product["image"],
              height: 350,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            // Konten di bawah gambar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Produk
                  Text(
                    widget.product["name"],
                    style: TextStyle(
                      color: const Color.fromRGBO(71, 77, 144, 1),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Harga Produk
                  Text(
                    "Harga: Rp ${widget.product["price"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(71, 77, 144, 1),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Detail Produk
                  Text("Detail Produk:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    widget.product["details"],
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritePage extends StatelessWidget {
  final List<Map<String, dynamic>> favorites;

  FavoritePage({required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(251, 231, 231, 1),
        ),
        body: Stack(children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.7,
              child: Image.asset("img/wp.png", fit: BoxFit.cover),
            ),
          ),
          Column(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromRGBO(251, 231, 231, 1),
                      const Color.fromRGBO(246, 210, 210, 1)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Produk dibintangi",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(71, 77, 144, 1),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 8), // Jarak antara teks dan garis
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              thickness: 1.2,
                              indent: 2,
                              endIndent: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
              ),
              Expanded(
                child: favorites.isEmpty
                    ? Center(child: Text("Belum ada produk favorit."))
                    : ListView.builder(
                        itemCount: favorites.length,
                        itemBuilder: (context, index) {
                          var product = favorites[index];
                          return ListTile(
                            leading: Image.asset(product["image"], width: 50),
                            title: Text(product["name"]),
                            subtitle: Text(product["brand"]),
                            trailing: Icon(Icons.star,
                                color: Color.fromARGB(255, 220, 153, 153)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SkincareDetail(product: product),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ]));
  }
}
