import 'package:flutter/material.dart';

void main() {
  runApp(CoffeeApp());
}

class CoffeeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'JakartaSans'),
      home: CoffeeHomePage(),
    );
  }
}

class CoffeeHomePage extends StatefulWidget {
  @override
  _CoffeeHomePageState createState() => _CoffeeHomePageState();
}

class _CoffeeHomePageState extends State<CoffeeHomePage> {
  int _selectedCategoryIndex = 0;

  // Sample product data categorized
  final List<List<Map<String, String>>> _products = [
    [
      {'name': 'Ice Cold Coffee', 'description': 'Americano', 'price': 'Rp 15.000', 'image': 'assets/Instant-Iced-Coffee-5-1.jpg'},
      {'name': 'Dalgona Coffee', 'description': 'Nescafe', 'price': 'Rp 13.000', 'image': 'assets/images.jpg'},
    ],
    [
      {'name': 'Chocolate Brownie', 'description': 'Delicious', 'price': 'Rp 20.000', 'image': 'assets/brownie.jpg'},
      {'name': 'Nutty Brownie', 'description': 'Nutty Flavor', 'price': 'Rp 22.000', 'image': 'assets/nutty_brownie.jpg'},
    ],
    [
      {'name': 'Choco Chip Cookie', 'description': 'Classic', 'price': 'Rp 10.000', 'image': 'assets/cookie.jpg'},
      {'name': 'Oreo Cookie', 'description': 'Oreo Flavor', 'price': 'Rp 12.000', 'image': 'assets/oreo_cookie.jpg'},
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFED8B1),
      appBar: AppBar(
        backgroundColor: Color(0xFF6F4E37),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Location", style: TextStyle(fontSize: 12, color: Colors.white)),
            Text("Semarang, Jawa Tengah", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart_outlined), onPressed: () {}),
        ],
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
      ),
      body: Column(
        children: [
          _buildStackedWidgets(),
          _buildCategoryTabs(),
          Expanded(child: _buildProductGrid()),
        ],
      ),
    );
  }

  Widget _buildStackedWidgets() {
    return Stack(
      children: [
        _buildGradientBackground(),
        Column(
          children: [
            _buildSearchAndPromoBox(),
          ],
        ),
      ],
    );
  }

  Widget _buildGradientBackground() {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6F4E37), Color(0xFFA67B5B)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildSearchAndPromoBox() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
      decoration: BoxDecoration(
        color: Color(0xFFA67B5B),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          _buildSearchBar(),
          SizedBox(height: 12),
          _buildPromotionalBanner(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Color(0xFFBC9170),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.white),
          SizedBox(width: 2.5),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari pilihan makanan mu..',
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionalBanner() {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.brown[300],
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage('assets/banner2.jpg'), // Ensure this path is correct
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildCategoryTab('Coffee', 0),
          _buildCategoryTab('Brownies', 1),
          _buildCategoryTab('Cookies', 2),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(String title, int index) {
    bool isSelected = _selectedCategoryIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF6F4E37) : Color(0xFFD3B39E),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(color: isSelected ? Colors.white : Colors.brown[800], fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    final products = _products[_selectedCategoryIndex];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          return _buildProductCard(products[index]);
        },
      ),
    );
  }

  Widget _buildProductCard(Map<String, String> product) {
    return Card(
      color: Color(0xFFECB176),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  product['image']!, // Ensure this path is correct
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              product['name']!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF6F4E37),
              ),
            ),
            Text(product['description']!, style: TextStyle(color: Color(0xFF6F4E37))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(product['price']!, style: TextStyle(color: Color(0xFF6F4E37))),
                Icon(Icons.add_circle_outline, color: Color(0xFF6F4E37)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionalBannerBelow() {
    return Container(
      width: double.infinity,
      height: 100,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.brown[300],
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage('assets/banner2.jpg'), // Ensure this path is correct
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
