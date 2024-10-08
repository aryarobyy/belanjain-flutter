import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const DetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    bool isDesktop = screenWidth > 800;

    return Scaffold(
      appBar: AppBar(
        title: Text(product['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isDesktop || isLandscape
            ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product['image'] != null && product['image'].isNotEmpty)
              Flexible(
                flex: 2,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.asset(
                    "${product['image']}",
                    height: 400,
                  ),
                ),
              ),
            const SizedBox(width: 32),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ID: ${product['id']}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Title: ${product['title']}",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Toko: ${product['toko']}",
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Harga: Rp ${product['harga']}",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product['image'] != null && product['image'].isNotEmpty)
              FittedBox(
                fit: BoxFit.cover,
                child: Image.asset(
                  "${product['image']}",
                  height: 300,
                ),
              ),
            const SizedBox(height: 16),
            Text(
              "ID: ${product['id']}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Title: ${product['title']}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Toko: ${product['toko']}",
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Harga: Rp ${product['harga']}",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}