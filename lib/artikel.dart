import 'package:flutter/material.dart';

import 'utama.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'BellyBloom',
    home: ArticleScreen(),
  ));
}

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final List<Map<String, String>> articles = [
    {
      "title": "Perkembangan Janin Selama Awal Kehamilan",
      "image": "img/artikel.jpg",
      "content": "Artikel ini membahas perkembangan janin di awal kehamilan."
    },
    {
      "title": "Melahirkan Lebih Tenang dengan Metode Gentle Birth",
      "image": "img/artikel.jpg",
      "content": "Gentle Birth adalah metode melahirkan yang lebih nyaman."
    },
    {
      "title": "Gejala Kehamilan Ektopik",
      "image": "img/artikel.jpg",
      "content":
          "Kehamilan ektopik adalah kondisi serius yang perlu diwaspadai."
    },
    {
      "title": "Makanan yang Harus Dihindari selama Kehamilan",
      "image": "img/artikel.jpg",
      "content": "Ada beberapa makanan yang sebaiknya dihindari oleh ibu hamil."
    },
    {
      "title": "Bolehkah Ibu Hamil Memakai Skincare?",
      "image": "img/artikel.jpg",
      "content": "Skincare aman untuk ibu hamil tergantung pada kandungannya."
    },
  ];

  List<Map<String, String>> filteredArticles = [];
  List<Map<String, String>> bookmarkedArticles = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredArticles = articles;
  }

  void _searchArticles(String query) {
    setState(() {
      filteredArticles = articles
          .where((article) =>
              article["title"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _toggleBookmark(Map<String, String> article) {
    setState(() {
      if (bookmarkedArticles.contains(article)) {
        bookmarkedArticles.remove(article);
      } else {
        bookmarkedArticles.add(article);
      }
    });
  }

  void _showBookmarkedArticles() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            BookmarkedArticlesScreen(bookmarkedArticles: bookmarkedArticles),
      ),
    );
  }

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    if (index == 0) {
      // Home
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PregnancyTracker()),
      );
    } else if (index == 1) {
    } else if (index == 2) {
      // VitaMil
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ArticleScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink[300],
        onTap: _onItemTapped,
      ),
      appBar: AppBar(
        title: Text("Artikel", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: _showBookmarkedArticles,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: _searchArticles,
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: filteredArticles.length,
                itemBuilder: (context, index) {
                  final article = filteredArticles[index];
                  final isBookmarked = bookmarkedArticles.contains(article);
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ArticleDetailScreen(article: article),
                      ),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10.0)),
                            child: Image.asset(
                              article["image"]!,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    article["title"]!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    isBookmarked
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    color: isBookmarked
                                        ? const Color.fromARGB(
                                            255, 234, 95, 159)
                                        : Colors.grey,
                                  ),
                                  onPressed: () => _toggleBookmark(article),
                                ),
                              ],
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
      ),
    );
  }
}

class BookmarkedArticlesScreen extends StatelessWidget {
  final List<Map<String, String>> bookmarkedArticles;

  const BookmarkedArticlesScreen({Key? key, required this.bookmarkedArticles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bookmarked Articles")),
      body: bookmarkedArticles.isEmpty
          ? Center(child: Text("No bookmarked articles"))
          : ListView.builder(
              itemCount: bookmarkedArticles.length,
              itemBuilder: (context, index) {
                final article = bookmarkedArticles[index];
                return ListTile(
                  leading:
                      Image.asset(article["image"]!, width: 50, height: 50),
                  title: Text(article["title"]!),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ArticleDetailScreen(article: article),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class ArticleDetailScreen extends StatefulWidget {
  final Map<String, String> article;
  const ArticleDetailScreen({Key? key, required this.article})
      : super(key: key);

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  List<Map<String, String>> bookmarkedArticles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              setState(() {
                if (bookmarkedArticles.contains(widget.article)) {
                  bookmarkedArticles.remove(widget.article);
                } else {
                  bookmarkedArticles.add(widget.article);
                }
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.article["title"]!,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Image.asset(widget.article["image"]!,
                height: 200, width: double.infinity),
            SizedBox(height: 16.0),
            Text(widget.article["content"]!, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
