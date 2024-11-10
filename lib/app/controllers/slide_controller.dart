import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/models/product.dart';
import 'package:p2p_exchange/app/models/slide.dart';
import 'package:p2p_exchange/app/services/slide.dart';

class SlideController extends GetxController {
  var slides = <Slide>[].obs;
  var productSlides = <Product>[].obs;
  var filteredSlide = <Slide>[].obs;
  final SlideService service = SlideService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchSlides();
  }

  Future<void> fetchSlides() async {
    slides = await service.fetchSlides();
  }

  Future<void> loadSlideProducts() async {
    try {
      var snapshot = await _firestore
          .collection('products')
          .where('status', isEqualTo: 'Stock')
          .orderBy('createdAt', descending: true)
          .limit(5)
          .get();

      productSlides.value =
          snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList();
    } catch (e) {
      print(e);
      return;
    }
  }

  Future<void> addSlide(Slide slide) async {
    await service.addSlide(slide);
  }

  Future<void> updateSlide(Slide slide) async {
    await service.updateSlide(slide);
  }

  void filterSlide(String query) {
    if (query.isEmpty) {
      filteredSlide.value = slides;
    } else {
      filteredSlide.value = slides
          .where((slide) =>
              slide.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
