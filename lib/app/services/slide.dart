import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/models/slide.dart';

class SlideService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference slideCollectionn =
      FirebaseFirestore.instance.collection('slides');
  var slides = <Slide>[].obs;

  SlideService();

  Future<RxList<Slide>> fetchSlides() async {
    try {
      slideCollectionn.snapshots().listen((snapshot) {
        slides.value = snapshot.docs
            .map((doc) => Slide.fromDocumentSnapshot(doc))
            .toList();
      });
      return slides;
    } catch (e) {
      throw Exception('Failed to get slides: $e');
    }
  }

  Future<void> addSlide(Slide slide) async {
    try {
      await firestore.collection('slides').add(slide.toMap());
    } catch (e) {
      throw Exception('Failed to add slide: $e');
    }
  }

  Future<void> updateSlide(Slide slide) async {
    try {
      await firestore.collection('slides').doc(slide.id).update(slide.toMap());
    } catch (e) {
      throw Exception('Failed to update slide: $e');
    }
  }
}
