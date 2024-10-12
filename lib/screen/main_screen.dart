import 'package:flutter/material.dart';
import 'package:tugas_dicoding/screen/products/all_category.dart';
import 'product_provider.dart';
import 'products/accessoris_category.dart';
import 'products/electronic_category.dart';
import 'products/footware_category.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ProductProvider _productProvider = ProductProvider();
  final double cardWidth = 170.0;
  final double cardHeight = 230.0;
  String _currentCategory = 'All';
  String _searchQuery = '';
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _productProvider.loadProducts().then((_) {
      setState(() {});
    });
  }

  List<dynamic> _getFilteredProducts() {
    return _productProvider.products.where((product) {
      String title = product['title'] ?? '';
      String category = product['category'] ?? '';

      bool matchesSearch = title.toLowerCase().contains(_searchQuery.toLowerCase());
      bool matchesCategory = _currentCategory == 'All' || category == _currentCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }


  Widget _getCategoryWidget() {
    List<dynamic> filteredProducts = _getFilteredProducts();

    if (_currentCategory == 'All') {
      return AllCategory(productProvider: _productProvider, filteredProducts: filteredProducts);
    } else if (_currentCategory == 'Accessories') {
      return AccessoriesCategory(productProvider: _productProvider, filteredProducts: filteredProducts);
    } else if (_currentCategory == 'Electronics') {
      return ElectronicCategory(productProvider: _productProvider, filteredProducts: filteredProducts);
    } else if (_currentCategory == 'Footwear') {
      return FootwearCategory(productProvider: _productProvider, filteredProducts: filteredProducts);
    } else {
      return AllCategory(productProvider: _productProvider, filteredProducts: filteredProducts);
    }
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
    });
  }

  Widget _buildSearchField() {
    return TextField(
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search for products...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white54),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => setState(() => _searchQuery = query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQuery.isEmpty) {
              _stopSearch();
              return;
            }
            setState(() {
              _searchQuery = '';
            });
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? _buildSearchField()
            : InkWell(
          onTap: () {
            setState(() {
              _currentCategory = 'All';
            });
          },
          child: const Text(
            "Belanjain",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        actions: _buildActions(),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (_productProvider.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          double availableWidth = constraints.maxWidth - 32;
          int crossAxisCount = (availableWidth / cardWidth).floor();
          crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _currentCategory = 'All';
                            print("Current category changed to: $_currentCategory");
                          });
                        },
                        child: const Text("All"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _currentCategory = 'Accessories';
                            print("Current category changed to: $_currentCategory");
                          });
                        },
                        child: const Text("Accessories"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _currentCategory = 'Electronics';
                            print("Current category changed to: $_currentCategory");
                          });
                        },
                        child: const Text("Electronics"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _currentCategory = 'Footwear';
                            print("Current category changed to: $_currentCategory");
                          });
                        },
                        child: const Text("Footwear"),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: _getCategoryWidget(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}