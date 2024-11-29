import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/product_controller.dart';
import 'data/api_service.dart';
import 'domain/repository.dart';
import 'ui/screens/product_list_screen.dart';

void main() {
  final apiService = ApiService();
  final productRepository = ProductRepository(apiService);

  runApp(MyApp(productRepository: productRepository));
}

class MyApp extends StatelessWidget {
  final ProductRepository productRepository;

  const MyApp({super.key, required this.productRepository});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductController(productRepository)..loadProducts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const ProductListScreen(),
      ),
    );
  }
}
