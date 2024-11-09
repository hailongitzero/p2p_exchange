import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:p2p_exchange/app/controllers/categories_controller.dart';
import 'package:p2p_exchange/app/models/category.dart';

class CategoryForm extends StatefulWidget {
  final Category? category;

  const CategoryForm({super.key, this.category});

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final CategoryController categoryController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();

  File? _selectedImage;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      _titleController.text = widget.category!.title;
      _descriptionController.text = widget.category!.description;
      _imageController.text = widget.category!.image;
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      setState(() => _isUploading = true);
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('category_images/${DateTime.now().millisecondsSinceEpoch}');
      final uploadTask = storageRef.putFile(image);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() => _isUploading = false);
      return downloadUrl;
    } catch (e) {
      setState(() => _isUploading = false);
      return null;
    }
  }

  Future<void> _saveCategory() async {
    if (_formKey.currentState!.validate()) {
      String? imageUrl = _imageController.text;

      if (_selectedImage != null) {
        imageUrl = await _uploadImage(_selectedImage!);
      }

      if (imageUrl == null) {
        // Handle image upload failure
        Get.snackbar("Error", "Failed to upload image.");
        return;
      }

      final category = Category(
        id: widget.category?.id ?? '',
        title: _titleController.text,
        description: _descriptionController.text,
        image: imageUrl,
      );

      if (widget.category == null) {
        await categoryController.addCategory(category);
      } else {
        await categoryController.updateCategory(category);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.category == null ? 'Add Category' : 'Edit Category'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) => value!.isEmpty ? 'Enter title' : null,
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (value) => value!.isEmpty ? 'Enter description' : null,
            ),
            TextFormField(
              controller: _imageController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            const SizedBox(height: 10),
            _selectedImage != null
                ? Image.file(_selectedImage!, height: 100)
                : widget.category != null && widget.category!.image.isNotEmpty
                    ? Image.network(widget.category!.image, height: 100)
                    : Container(),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text("Choose Image"),
            ),
            if (_isUploading) const CircularProgressIndicator(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveCategory,
          child: Text(widget.category == null ? 'Add' : 'Save'),
        ),
      ],
    );
  }
}
