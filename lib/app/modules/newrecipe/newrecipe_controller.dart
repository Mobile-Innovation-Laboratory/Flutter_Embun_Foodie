import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

Future<void> uploadRecipe(
    {required String dishName,
    required String ingredients,
    required String price,
    required String category,
    required File? image,
    required String instructions}) async {
  try {
    String? imageUrl;

    if (image != null) {
      // Upload image ke Firebase Storage
      final storageRef = FirebaseStorage.instance.ref().child('image/${DateTime.now().toIso8601String()}');
      await storageRef.putFile(image);
      imageUrl = await storageRef.getDownloadURL();
    }

    // UserId sementara
    String tempUserId = "dummyUserId123";

    // Tambahkan data ke Firestore
    await FirebaseFirestore.instance.collection('recipes').add({
      'name': dishName,
      'ingredients': ingredients,
      'price': price,
      'category': category,
      'image': imageUrl ?? '',
      'instructions': instructions,
      'userId': tempUserId,
      'createdAt': Timestamp.now(),
    });

    print('Recipe uploaded successfully');
  } catch (e) {
    print('Failed to upload recipe: $e');
  }
}

