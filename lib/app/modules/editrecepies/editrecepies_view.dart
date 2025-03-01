import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

class EditRecepiesView extends StatefulWidget {
  final String recipeid;

  const EditRecepiesView({required this.recipeid});

  @override
  _EditRecepiesViewState createState() => _EditRecepiesViewState();
}

class _EditRecepiesViewState extends State<EditRecepiesView> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic>? recipeData;

  @override
  void initState() {
    super.initState();
    fetchRecipe();
  }

  Future<void> fetchRecipe() async {
    var doc = await FirebaseFirestore.instance
        .collection('recipes')
        .doc(widget.recipeid)
        .get();

    if (doc.exists) {
      setState(() {
        recipeData = doc.data();
      });
    }
  }

  Future<void> updateRecipe() async {
    if (_formKey.currentState?.validate() ?? false) {
      await FirebaseFirestore.instance
          .collection('recipes')
          .doc(widget.recipeid)
          .update(recipeData!);
      showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop(true);
          Navigator.pushNamed(context, '/myrecipe');
        });
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Icon(Icons.check_circle, color: Colors.green, size: 80),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'Recipe updated successfully!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
    }
  }

  Future<void> confirmDeleteRecipe() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(

        title: Text('Confirm Delete', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w500),),
        content: Text('Are you sure you want to delete this recipe?', style: GoogleFonts.poppins(fontSize: 14),),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await deleteRecipe();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> deleteRecipe() async {
    await FirebaseFirestore.instance
        .collection('recipes')
        .doc(widget.recipeid)
        .delete();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Recipe deleted successfully!')),
    );
    Navigator.pushNamed(context, '/myrecipe');
  }

  @override
  Widget build(BuildContext context) {
    if (recipeData == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Recipe',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.chevron_left, size: 33),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel('Dish name'),
                _buildTextField('name', 'Insert the name of the dish...'),
                _buildLabel('Description'),
                _buildTextField('description', 'Insert the description of the dish...', maxLines: 3),
                _buildLabel('Ingredients'),
                _buildScrollableTextField('ingredients', 'Enter ingredients...'),
                _buildLabel('Estimated time'),
                _buildTextField('price', 'Enter time estimate for food ingredients...'),
                _buildLabel('Category'),
                DropdownButtonFormField<String>(
                  value: recipeData!['category'] is String ? recipeData!['category'] : null,
                  decoration: _inputDecoration(),
                  items: ["Rice Dishes", "Snacks", "Drinks", "Sweets", "Chicken & Duck"]
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category, style: GoogleFonts.poppins(fontSize: 14, color: Colors.black)),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => recipeData!['category'] = value),
                ),
                _buildLabel('Food image'),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: recipeData!['image'] == null
                        ? _uploadPlaceholder()
                        : Image.memory(base64Decode(recipeData!['image']), fit: BoxFit.cover),
                  ),
                ),
                _buildLabel('Instructions'),
                _buildTextField('howtocook', 'Provide step-by-step instructions...', maxLines: 3),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: confirmDeleteRecipe,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(double.infinity, 60),
                        ),
                        child: Text(
                          'Delete',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: updateRecipe,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff469110),
                          minimumSize: const Size(double.infinity, 60),
                        ),
                        child: Text(
                          'Update',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildTextField(String field, String hint, {int maxLines = 1, bool isList = false}) => TextFormField(
        initialValue: isList && recipeData![field] is List
            ? (recipeData![field] as List).join(', ')
            : recipeData![field]?.toString(),
        onChanged: (value) => recipeData![field] = isList ? value.split(',').map((e) => e.trim()).toList() : value,
        maxLines: maxLines,
        decoration: _inputDecoration().copyWith(hintText: hint),
      );

  Widget _buildLabel(String text) => Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 4),
        child: Text(text, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
      );

  InputDecoration _inputDecoration() => InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xff469110))),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xff469110), width: 1.5)),
      );

  Widget _uploadPlaceholder() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.cloud_upload, size: 40, color: Color(0xff469110)),
          Text('Click to Upload', style: TextStyle(color: Color(0xff469110))),
          Text('or drag and drop'),
          Text('(Max. File size: 25 MB)', style: TextStyle(color: Colors.grey)),
        ],
      );
  Widget _buildScrollableTextField(String field, String hint) => Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff469110)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          child: TextFormField(
            initialValue: recipeData![field] is List
                ? (recipeData![field] as List).join('\n')
                : recipeData![field]?.toString(),
            onChanged: (value) => recipeData![field] = value.split('\n').map((e) => e.trim()).toList(),
            maxLines: null,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12),
              border: InputBorder.none,
              hintText: hint,
            ),
          ),
        ),
      );
}
