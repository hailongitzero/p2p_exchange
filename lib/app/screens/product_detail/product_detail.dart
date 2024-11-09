import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:p2p_exchange/app/models/product.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  final String currentUserId = FirebaseAuth.instance.currentUser!
      .uid; // Pass the ID of the current user for alignment

  ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetail> {
  final TextEditingController _commentController = TextEditingController();

  String formatCurrency(double amount) {
    final formatCurrency = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatCurrency.format(amount);
  }

  // Function to handle adding a new comment
  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        widget.product.comments = (widget.product.comments ?? [])
          ..add(_commentController.text);
      });
      _commentController.clear();
      Navigator.of(context).pop(); // Close the modal after adding a comment
    }
  }

  // Function to open the comment modal
  void _openCommentModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add a Comment"),
          content: TextField(
            controller: _commentController,
            maxLines: 3,
            decoration:
                const InputDecoration(hintText: "Type your comment here..."),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              onPressed: _addComment,
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Add to favorites logic
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Slider
            if (widget.product.imageSlides != null &&
                widget.product.imageSlides!.isNotEmpty)
              CarouselSlider(
                options: CarouselOptions(
                  height: 300.0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  autoPlay: true,
                ),
                items: widget.product.imageSlides!.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    },
                  );
                }).toList(),
              )
            else if (widget.product.image != null)
              Image.network(
                widget.product.image!,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

            const SizedBox(height: 16.0),

            // Product Information
            Text(
              widget.product.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              formatCurrency(widget.product.price ?? 0),
              style: const TextStyle(fontSize: 20, color: Colors.red),
            ),
            const SizedBox(height: 8.0),
            Text("Condition: ${widget.product.condition ?? 'Unknown'}"),
            const SizedBox(height: 4.0),
            Text("Status: ${widget.product.status ?? 'N/A'}"),
            const SizedBox(height: 8.0),
            Text(
              widget.product.description,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 16.0),

            // Comments Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Comments",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: _openCommentModal,
                  child: const Text("Add Comment"),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            if (widget.product.comments != null &&
                widget.product.comments!.isNotEmpty)
              ...widget.product.comments!.map((comment) {
                bool isSelfComment = comment == widget.currentUserId;
                return Align(
                  alignment: isSelfComment
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: isSelfComment
                          ? Colors.blue.shade100
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      comment,
                      style: TextStyle(
                        color:
                            isSelfComment ? Colors.blue.shade900 : Colors.black,
                      ),
                    ),
                  ),
                );
              })
            else
              const Text("No comments yet."),

            const SizedBox(height: 16.0),

            // Buy and Add to Favorites Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Buy logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text("Buy Now"),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Add to favorites logic
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text("Add to Favorites"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
