import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> filters = const [
    'All',
    'Adidas',
    'Nike',
    'Bata',
    'Sparx',
    'Puma',
    'Woodland',
  ];
  
  String selectedFilter = 'All';
  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  // Shared cart list
  final List<Map<String, dynamic>> cart = [];

  final List<Map<String, dynamic>> products = const [
    {
      'title': "Nike Revolution 7",
      'company': 'Nike',
      'price': 44.32,
      'image': 'https://static.nike.com/a/images/t_web_pdp_936_v2/f_auto/450ed1df-8e17-4d87-a244-85697874661c/NIKE+REVOLUTION+7.png',
    },
    {
      'title': "Nike Air Huarache NBY",
      'company': 'Nike',
      'price': 65.50,
      'image': 'https://static.nike.com/a/images/t_web_pw_592_v2/f_auto/773a2c51-090a-46b1-ae35-d380e8fd3532/AIR+HUARACHE+NBY.png',
    },
    {
      'title': "Adidas Running Shoes",
      'company': 'Adidas',
      'price': 52.00,
      'image': 'https://tse3.mm.bing.net/th/id/OIP.Hxp1MtQwNyR2lvXBoJdXIAHaE8?r=0&pid=Api&h=220&P=0',
    },
    {
      'title': "Adidas Run '70s Running Shoes",
      'company': 'Adidas',
      'price': 89.99,
      'image': 'https://tse3.mm.bing.net/th/id/OIP.eAKGbSSbp-OIJbWkCE8Q0wHaFj?r=0&pid=Api&h=220&P=0',
    },
    {
      'title': "Bata Men's Waterproof Leather Boot",
      'company': 'Bata',
      'price': 29.99,
      'image': 'https://m.media-amazon.com/images/I/71KGROaRgxL._SL1500_.jpg',
    },
    {
      'title': "Bata Men's Casual Sneaker",
      'company': 'Bata',
      'price': 24.50,
      'image': 'https://m.media-amazon.com/images/I/710+f7XX2FL._AC_UL800_QL65_.jpg',
    },
    {
      'title': "Sparx Men's Canvas",
      'company': 'Sparx',
      'price': 19.99,
      'image': 'https://m.media-amazon.com/images/I/61RuAmHMvML._SL1500_.jpg',
    },
    {
      'title': "Sparx Running Shoes",
      'company': 'Sparx',
      'price': 15.00,
      'image': 'https://m.media-amazon.com/images/I/81txEOHcpFL._SL1500_.jpg',
    },
    {
      'title': "Puma Men's Softride SlipOn",
      'company': 'Puma',
      'price': 58.00,
      'image': 'https://i5.walmartimages.com/seo/Puma-Safety-Motion-PWR-Men-s-Composite-Toe-Static-Dissipative-Athletic-Work-Shoe_bf6d9ee3-be7a-4b46-ac1a-cc30aa3b8040.00e43d429fff9382c65b26b6daf1ba81.jpeg',
    },
    {
      'title': "Puma Men's Viz Runners",
      'company': 'Puma',
      'price': 49.99,
      'image': 'https://m.media-amazon.com/images/I/71RRlgNLiGL._AC_SR768,1024_.jpg',
    },
    {
      'title': "Woodland Men's Dnavy 4 Leather Casual",
      'company': 'Woodland',
      'price': 75.00,
      'image': 'https://m.media-amazon.com/images/I/71YGN-VFP-L._SL1500_.jpg',
    },
    {
      'title': "Woodland Trekking Shoes",
      'company': 'Woodland',
      'price': 82.50,
      'image': 'https://assets.myntassets.com/w_412,q_60,dpr_2,fl_progressive/assets/images/6995113/2018/8/14/491e41a2-77ba-4bf5-86af-aeb8f67d63be1534240854106-Woodland-Men-Casual-Shoes-3381534240853938-1.jpg',
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Combined Filter Logic: Brand selection AND Search query
    final filteredProducts = products.where((product) {
      final matchesBrand = selectedFilter == 'All' || product['company'] == selectedFilter;
      final matchesSearch = product['title'].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesBrand && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shoes Collection'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(cart: cart),
                    ),
                  ).then((_) => setState(() {})); // Rebuild on returning from cart
                },
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      '${cart.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Interactive Search Bar
              TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            setState(() {
                              searchQuery = '';
                            });
                          },
                        )
                      : null,
                  hintText: 'Search shoes...',
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Filter Chips List
              SizedBox(
                height: 50,
                child: ListView.builder(
                  itemCount: filters.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final filter = filters[index];
                    final isSelected = selectedFilter == filter;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: GestureDetector(
                        onTap: () => setState(() => selectedFilter = filter),
                        child: Chip(
                          backgroundColor: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : const Color.fromRGBO(245, 247, 249, 1),
                          label: Text(
                            filter,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Products Feed or Empty Search View
              Expanded(
                child: filteredProducts.isEmpty
                    ? const Center(
                        child: Text(
                          'No shoes found!',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return ProductAlignment(
                            productTitle: product['title'],
                            productPrice: '\$${product['price']}',
                            productImage: product['image'],
                            onBuyPressed: () {
                              setState(() {
                                cart.add(Map<String, dynamic>.from(product));
                              });

                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${product['title']} added to cart!'),
                                  duration: const Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: 'VIEW CART',
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CartPage(cart: cart),
                                        ),
                                      ).then((_) => setState(() {}));
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Product Card Widget
class ProductAlignment extends StatelessWidget {
  final String productTitle;
  final String productPrice;
  final String productImage;
  final VoidCallback onBuyPressed;

  const ProductAlignment({
    super.key,
    required this.productTitle,
    required this.productPrice,
    required this.productImage,
    required this.onBuyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 6,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productTitle,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                productPrice,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              Center(
                child: Image.network(
                  productImage,
                  height: 150,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 80,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: onBuyPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Buy',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Cart Collection Page
class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cart;

  const CartPage({super.key, required this.cart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Collection'),
      ),
      body: widget.cart.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (context, index) {
                final item = widget.cart[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Image.network(
                      item['image'],
                      width: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.broken_image,
                        size: 30,
                      ),
                    ),
                    title: Text(item['title']),
                    subtitle: Text('\$${item['price']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          widget.cart.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}