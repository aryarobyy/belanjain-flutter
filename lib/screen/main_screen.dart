import 'package:belanjain/fetchs/_product.dart';
import 'package:belanjain/models/product_model.dart';
import 'package:belanjain/providers/product_provider.dart';
import 'package:belanjain/screen/detail_screen.dart';
import 'package:belanjain/screen/kamera_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final String inputCategory;
  const MainScreen({
    super.key,
    required this.inputCategory,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ProductProvider _productProvider = ProductProvider();
  String _currentCategory = 'All';
  String _searchQuery = '';
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  final List<String> categories = ['All', 'fragrances', 'furniture', 'beauty', 'groceries', ];

  @override
  void initState() {
    super.initState();
    if(widget.inputCategory != null ){
      _currentCategory = widget.inputCategory;
    };
    _productProvider.loadProducts().then((_) {
      setState(() {});
    });
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchQuery = '';
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search for products...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        )
            : const Text('Belanjain'),
        actions: [
          if (_isSearching)
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt_outlined),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return KameraScreen();
                        })
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: _stopSearch,
                ),
              ],
            )
          else
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: _startSearch,
            ),
        ],
      ),
      body: _buildFiltered2(context),
    );
  }

  Widget _buildFiltered2(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = _currentCategory == category;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ChoiceChip(
                  label: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: Colors.blue,
                  backgroundColor: Colors.grey[200],
                  onSelected: (bool selected) {
                    setState(() {
                      _currentCategory = category;
                    });
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: FutureBuilder<List<ProductModel>>(
            future: ProductService().getProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No products available.'),
                );
              } else {
                final filteredProducts = snapshot.data!.where((product) {
                  final matchesSearch = product.title.toLowerCase().contains(_searchQuery.toLowerCase());
                  final matchesCategory = _currentCategory == 'All' || product.category == _currentCategory;
                  return matchesSearch && matchesCategory;
                }).toList();

                if (filteredProducts.isEmpty) {
                  return const Center(
                    child: Text(
                        'No products match your search or category filter.'),
                  );
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(product: product),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.network(
                                  product.imageUrl,
                                  height: 100,
                                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Text(
                                    "Rate:",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${product.rating}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text("Price: \$${product.price.toString()}"),
                              const SizedBox(height: 4),
                              Text("Status: ${product.status}"),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}