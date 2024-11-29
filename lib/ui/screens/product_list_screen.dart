import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/product_controller.dart';
import '../../data/models/product_model.dart';
import '../widgets/product_card.dart';
import '../widgets/error_widget.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  String sortOption = "none";
  List<Product> originalProducts = [];
  final FocusNode searchFocusNode = FocusNode();
  final GlobalKey _popupKey = GlobalKey();

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProductController>(context);

    if (controller.products.isNotEmpty && originalProducts.isEmpty) {
      originalProducts = List.from(controller.products);
    }

    final filteredProducts = controller.products
        .where((product) =>
        product.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    if (sortOption == "price_asc") {
      filteredProducts.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortOption == "price_desc") {
      filteredProducts.sort((a, b) => b.price.compareTo(a.price));
    } else if (sortOption == "name") {
      filteredProducts.sort(
              (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    } else if (sortOption == "featured") {
      filteredProducts.clear();
      filteredProducts.addAll(originalProducts);
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),  // Height for AppBar
          child: AppBar(
            title: const Center(
              child: Text(
                'Products',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            backgroundColor: Colors.teal,
            elevation: 3,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30.0),  // Curved bottom edges
              ),
            ),
            automaticallyImplyLeading: false,  // Remove back button
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      focusNode: searchFocusNode,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Search products...",
                        prefixIcon: const Icon(Icons.search, color: Colors.teal),
                        contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
                        filled: true,
                        fillColor: Colors.teal[50],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.teal[400],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: PopupMenuButton<String>(
                      key: _popupKey,
                      onSelected: (value) {
                        setState(() {
                          sortOption = value;
                        });
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: "featured",
                          child: Text("Featured"),
                        ),
                        PopupMenuItem(
                          value: "name",
                          child: Text("Name"),
                        ),
                        PopupMenuItem(
                          value: "price_asc",
                          child: Text("Price: Low to High"),
                        ),
                        PopupMenuItem(
                          value: "price_desc",
                          child: Text("Price: High to Low"),
                        ),
                      ],
                      icon: const Icon(Icons.sort, size: 30, color: Colors.white),
                      color: Colors.teal[100], // Matches box color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : controller.errorMessage != null
                  ? AppErrorWidget(error: controller.errorMessage!)
                  : filteredProducts.isEmpty
                  ? const Center(
                child: Text(
                  "No products found",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
                  : GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: filteredProducts[index],
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
