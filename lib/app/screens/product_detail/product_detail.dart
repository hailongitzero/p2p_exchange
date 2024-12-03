import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:p2p_exchange/app/controllers/comment_controller.dart';
import 'package:p2p_exchange/app/controllers/trade_controller.dart';
import 'package:p2p_exchange/app/controllers/user_controller.dart';
import 'package:p2p_exchange/app/models/Trade.dart';
import 'package:p2p_exchange/app/models/comment.dart';
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
  final CommentController commentController = Get.put(CommentController());
  final TradeController tradeController = Get.put(TradeController());
  final UserController userController = Get.put(UserController());
  final productDetailKey = GlobalKey();
  String formatCurrency(double amount) {
    final formatCurrency = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatCurrency.format(amount);
  }

  @override
  void dispose() {
    // Clean up any resources here, e.g., timers, streams, etc.
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Initialize product if it's null, otherwise set the provided product
    commentController.getProductComments(widget.product.id!);
    commentController.comment.value = Comment();
    tradeController.trade.value = Trade();
  }

  // Function to open the comment modal
  void _openCommentModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add a Comment"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: commentController.comment.value?.content,
                  maxLines: 5,
                  decoration: const InputDecoration(labelText: 'Comment'),
                  onChanged: (value) => commentController.comment.update((cmd) {
                    cmd?.content = value;
                  }),
                ),
                const SizedBox(height: 16.0),
                Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (commentController.isImagesUploading.value)
                          const Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: CircularProgressIndicator(),
                          )
                        else if (commentController.imagesUrls.isNotEmpty)
                          Wrap(
                            spacing: 8.0,
                            children: commentController.imagesUrls
                                .map((url) => Image.network(
                                      url,
                                      width: 100,
                                      height: 100,
                                    ))
                                .toList(),
                          )
                        else if (!(commentController
                                .comment.value?.images?.isEmpty ??
                            true))
                          Wrap(
                            spacing: 8.0,
                            children: commentController.comment.value!.images!
                                .map((url) => Image.network(
                                      url,
                                      width: 100,
                                      height: 100,
                                    ))
                                .toList(),
                          )
                        else
                          Container(),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: commentController.isImagesUploading.value
                              ? null
                              : () async {
                                  await commentController.pickAndUploadImages();
                                },
                          child: const Text('Pick Slide Images'),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Obx(() => ElevatedButton(
                  onPressed: commentController.isImagesUploading.value
                      ? null
                      : () async {
                          await commentController.addProductComment(
                              widget.product.id!,
                              commentController.comment.value!);
                          Navigator.of(context)
                              .pop(); // Close dialog after submitting
                        },
                  child: const Text("Submit"),
                )),
          ],
        );
      },
    );
  }

  void _openTradeModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Message"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: tradeController.trade.value?.content,
                  maxLines: 5,
                  decoration: const InputDecoration(labelText: 'Message'),
                  onChanged: (value) => tradeController.trade.update((cmd) {
                    cmd?.content = value;
                  }),
                ),
                const SizedBox(height: 16.0),
                Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (tradeController.isImagesUploading.value)
                          const Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: CircularProgressIndicator(),
                          )
                        else if (tradeController.imagesUrls.isNotEmpty)
                          Wrap(
                            spacing: 8.0,
                            children: tradeController.imagesUrls
                                .map((url) => Image.network(
                                      url,
                                      width: 100,
                                      height: 100,
                                    ))
                                .toList(),
                          )
                        else if (!(tradeController
                                .trade.value?.images?.isEmpty ??
                            true))
                          Wrap(
                            spacing: 8.0,
                            children: tradeController.trade.value!.images!
                                .map((url) => Image.network(
                                      url,
                                      width: 100,
                                      height: 100,
                                    ))
                                .toList(),
                          )
                        else
                          Container(),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: tradeController.isImagesUploading.value
                              ? null
                              : () async {
                                  await tradeController.pickAndUploadImages();
                                },
                          child: const Text('Select Images'),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Obx(() => ElevatedButton(
                  onPressed: tradeController.isImagesUploading.value
                      ? null
                      : () async {
                          await tradeController.addProductTrade(
                              widget.product.id!, tradeController.trade.value!);
                          Navigator.of(context)
                              .pop(); // Close dialog after submitting
                        },
                  child: const Text("Trade"),
                )),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      key: productDetailKey,
      navigationBar: CupertinoNavigationBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              CupertinoIcons.back,
              size: 20,
            )),
        middle: const Text(''),
        trailing: IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.person_solid, size: 20)),
        previousPageTitle: '',
      ),
      child: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    final textTheme = Theme.of(context).textTheme;

    // Get the screen height using MediaQuery
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate the remaining height for the scrollable content
    double topPadding =
        16.0; // Padding from the top (for navigation bar and margins)
    double bottomPadding = 16.0 +
        80.0; // Bottom padding for the buttons (16 for margin, 80 for button height)
    double availableHeight = screenHeight - topPadding - bottomPadding;

    return Stack(
      children: [
        // Scrollable content
        SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  availableHeight, // Set the height constraint for scrolling content
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Slider
                if (widget.product.imageSlides != null &&
                    widget.product.imageSlides!.isNotEmpty)
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 150.0,
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
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                const SizedBox(height: 16.0),

                // Product Information
                Text(
                  widget.product.name,
                  style: textTheme
                      .copyWith(
                          titleLarge: textTheme.titleLarge!.copyWith(
                              color: Colors.blue, fontWeight: FontWeight.bold))
                      .titleLarge,
                ),
                Text(
                  formatCurrency(widget.product.price ?? 0),
                  style: textTheme
                      .copyWith(
                          titleLarge:
                              textTheme.titleLarge!.copyWith(color: Colors.red))
                      .titleLarge,
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Condition: ${widget.product.condition ?? 'Unknown'}",
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 4.0),
                Text(
                  "Status: ${widget.product.status ?? 'N/A'}",
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 8.0),
                Text(
                  widget.product.description,
                  style: textTheme.bodyMedium,
                ),

                const SizedBox(height: 16.0),

                // Comments Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Comments",
                      style: textTheme
                          .copyWith(
                              titleLarge: textTheme.titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold))
                          .titleLarge,
                    ),
                    TextButton(
                      onPressed: _openCommentModal,
                      child: const Text("Add Comment"),
                    ),
                  ],
                ),
                Obx(() {
                  final comments = commentController.comments.toList();

                  return Container(
                    height:
                        200.0, // Set a fixed height to enable scrolling within this area
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: comments.isNotEmpty
                        ? ListView.builder(
                            key: ValueKey(
                                comments), // Add a unique key based on the comments list
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              final comment = comments[index];
                              bool isSelfComment =
                                  comment.userId == widget.currentUserId;

                              return Align(
                                alignment: isSelfComment
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: isSelfComment
                                        ? Colors.blue.shade100
                                        : Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: isSelfComment
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      if (comment.images != null &&
                                          comment.images!.isNotEmpty)
                                        SizedBox(
                                          height: 50.0,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: comment.images!.length,
                                            itemBuilder: (context, imgIndex) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.network(
                                                    comment.images![imgIndex],
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        comment.content ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        comment.createdAt != null
                                            ? DateFormat('dd/MM/yy HH:mm')
                                                .format(comment.createdAt ??
                                                    DateTime.now())
                                            : 'Date unknown',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              "No comments yet.",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                  );
                }),
              ],
            ),
          ),
        ),

        // Positioned Buttons at the bottom
        Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _openTradeModal();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text("Trade"),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: OutlinedButton(
                  onPressed: () async {
                    bool isAdded = await userController
                        .addUserFavorious(widget.product.id!);
                    showDialog(
                      context: context, // Parent context
                      builder: (BuildContext dialogContext) {
                        return CupertinoAlertDialog(
                          title: const Text("Success"),
                          content:
                              const Text("Added to favorites successfully!"),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.pop(
                                    dialogContext); // Use dialog's context to pop
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text("Favorites"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
