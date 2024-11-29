import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';

// ProductDetailScreen displays the details of a specific product
class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1; // Quantity of the product being purchased
  int currentPage = 0; // Tracks the current image page in the image carousel
  final PageController _pageController = PageController(viewportFraction: 0.9); // Page controller for the image carousel

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Product Details', // Title displayed on the AppBar
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        backgroundColor: Colors.teal, // Set AppBar background color to teal
        elevation: 5, // Set elevation of the AppBar
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)), // Rounded bottom corners for the AppBar
        ),
        // Removed actions to remove the button from the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add margin between AppBar and image section
              SizedBox(height: 20), // Adds spacing

              // Stack widget for the product image carousel
              Stack(
                children: [
                  SizedBox(
                    height: 300, // Set fixed height for the image carousel
                    child: PageView.builder(
                      controller: _pageController, // Controller for PageView
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index; // Update the current page when user swipes
                        });
                      },
                      itemCount: widget.product.images.length, // Number of images in the carousel
                      itemBuilder: (context, index) {
                        // Build the carousel item for each image
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () => _showFullScreenImage(
                                context, widget.product.images[index]), // Show full-screen image on tap
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0), // Rounded corners for images
                              child: Image.network(
                                widget.product.images[index], // Load the product image from the network
                                fit: BoxFit.cover, // Ensure the image fills the container
                                errorBuilder: (context, error, stackTrace) {
                                  return _placeholderImage(); // Display placeholder image in case of error
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Positioned widget for displaying page indicators
                  Positioned(
                    bottom: 10, // Position the indicator at the bottom
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.product.images.length, // Generate indicator for each image
                            (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: currentPage == index ? 12 : 8, // Highlight current page
                          height: 8,
                          decoration: BoxDecoration(
                            color: currentPage == index ? Colors.white : Colors.grey, // Active/inactive indicator colors
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20), // Add spacing below the image carousel

              // Product details section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product title
                    Text(
                      widget.product.title,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10), // Spacing between title and price

                    // Price and quantity section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Price",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        // Display the product price
                        Text(
                          "\$${widget.product.price}",
                          style: const TextStyle(
                              fontSize: 22,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20), // Add spacing

                    // Product description
                    Text(
                      widget.product.description,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 20), // Add spacing
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom navigation bar for quantity and "BUY NOW" button
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Quantity selector
              Row(
                children: [
                  // Decrease quantity button
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) quantity--; // Prevent quantity from going below 1
                      });
                    },
                  ),
                  Text(
                    "$quantity", // Display current quantity
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  // Increase quantity button
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        quantity++; // Increase quantity
                      });
                    },
                  ),
                ],
              ),
              // Buy now button
              ElevatedButton(
                onPressed: () {}, // Define buy action here
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  backgroundColor: Colors.teal, // Set background color for the button
                ),
                child: const Text(
                  "BUY NOW",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show the full-screen image when the user taps on an image
  void _showFullScreenImage(BuildContext context, String initialImageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Transparent background for the dialog
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(); // Close the dialog on tap
            },
            child: Center(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: PageView.builder(
                  itemCount: widget.product.images.length,
                  itemBuilder: (context, index) {
                    return _buildImagePage(widget.product.images[index]); // Build each image page
                  },
                  controller: PageController(
                      initialPage: widget.product.images.indexOf(initialImageUrl)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Builds a page for displaying a product image
  Widget _buildImagePage(String? imageUrl) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: imageUrl != null && imageUrl.isNotEmpty
            ? Image.network(
          imageUrl, // Load image from network
          fit: BoxFit.contain, // Contain the image within the available space
          errorBuilder: (context, error, stackTrace) {
            return _placeholderImage(); // Show placeholder if image fails to load
          },
        )
            : _placeholderImage(), // Return placeholder if image URL is empty
      ),
    );
  }

  // Placeholder widget for image loading errors or missing images
  Widget _placeholderImage() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Icon(
        Icons.image_not_supported, // Show an icon when image is not available
        color: Colors.grey.shade500,
        size: 48,
      ),
    );
  }
}
