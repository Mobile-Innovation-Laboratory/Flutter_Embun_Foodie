import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class EditRecepiesView extends StatefulWidget {
  final String productName;
  final String productImage;
  final String productPrice;
  final String productDescription;
  final List<String> ingredients;
  final String howToCook;
  final String category;
  final String username;

  EditRecepiesView({
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productDescription,
    required this.ingredients,
    required this.howToCook,
    required this.category,
    required this.username,
  });

  @override
  _EditRecepiesViewState createState() => _EditRecepiesViewState();
}

class _EditRecepiesViewState extends State<EditRecepiesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Recipe',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, size: 33),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Iconsax.heart),
          )
        ],
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
              child: Image.asset(
                widget.productImage,
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
                          ],
                        ),
                        Text(
                          widget.username,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
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
                child: Text(widget.howToCook, textAlign: TextAlign.justify),
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
            SizedBox(height: 20), // Spasi sebelum tombol
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Tambahkan logika update data di sini
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Resep berhasil diperbarui!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff469110), // Warna hijau sesuai tema
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Update Resep",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Spasi setelah tombol
          ],
        ),
      ),
    );
  }
}
