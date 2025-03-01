import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class DetailRecepiesView extends StatefulWidget {
  final String productName;
  final String? productImage;
  final String productPrice;
  final String productDescription;
  final List<String> ingredients;
  final String howToCook;
  final String category;
  final String userid;

  DetailRecepiesView({
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productDescription,
    required this.ingredients,
    required this.howToCook,
    required this.category,
    required this.userid,
  });

  @override
  _DetailRecepiesViewState createState() => _DetailRecepiesViewState();
}

class _DetailRecepiesViewState extends State<DetailRecepiesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Recipe',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20),
        ),
      
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, size: 33),
        ),
        
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
    
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: widget.productImage != null && widget.productImage!.isNotEmpty
                  ? Image.memory(
                      base64Decode(widget.productImage!),
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/placeholder.png', // Ganti dengan path gambar placeholder
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.productName,
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Iconsax.discount_shape, color: Color(0xff469110), size: 14),
                            SizedBox(width: 5),
                            Text(
                              widget.productPrice,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Color(0xff469110),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 2),
                                        Text(
                                          ' min',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF00623B),
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                          ),
                                        ),
                              ],
                            ),
                            FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                              future: FirebaseFirestore.instance.collection('users').doc(widget.userid).get(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Text('Loading...', style: GoogleFonts.poppins(fontSize: 14));
                                }
                                if (!snapshot.hasData || snapshot.data == null) {
                                  return Text('Unknown User', style: GoogleFonts.poppins(fontSize: 14));
                                }
                                final userData = snapshot.data!.data();
                                return Text(
                                  userData?['fullname'] ?? 'Unknown User',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),


                    SizedBox(height: 10),
                    Text(
                      widget.productDescription,
                      style: GoogleFonts.poppins(fontSize: 14),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Ingredients',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            SizedBox( 
              width: double.infinity, 
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.ingredients.map((ingredient) => Text('- $ingredient')).toList(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
      'How to Cook',
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    SizedBox(height: 10),
    Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(22),
        child: Text(
          widget.howToCook,
          textAlign: TextAlign.justify,
          style: GoogleFonts.poppins(fontSize: 14),
        ),
      ),
    ),
            SizedBox(height: 20),
            Text(
              'Category',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xff469110),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '#${widget.category}',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
