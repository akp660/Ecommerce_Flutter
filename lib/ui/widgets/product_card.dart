import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../screens/product_detail_screen.dart';  

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Hero(
                tag: 'product-image-${product.id}',  
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: product.images.isNotEmpty && product.images[0].isNotEmpty
                      ? Image.network(
                    product.images[0],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                       
                      return _buildSkeletonPlaceholder();
                    },
                  )
                      : _buildSkeletonPlaceholder(),  
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '\$${product.price}',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

   
  Widget _buildSkeletonPlaceholder() {
    return Container(
      color: Colors.grey[300],  
      alignment: Alignment.center,
      child: Icon(
        Icons.image_not_supported,
        size: 50,
        color: Colors.grey[500],  
      ),
    );
  }
}
