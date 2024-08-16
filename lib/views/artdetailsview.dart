import 'package:art_hive_app/headers.dart';

class ArtDetailsView extends StatelessWidget {
  final Map<String, String> artData;

  ArtDetailsView({required this.artData, required this.ismyart});
  final bool ismyart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                'assets/background.jpg', // Replace with your background image path
                fit: BoxFit.fill, // Cover the entire screen
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top image section
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        height: 300,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(24),
                          ),
                          child: Image.asset(
                            'assets/art1.jpg', // Dynamic image path
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Artwork title
                        Text(
                          artData['title'] ?? '',
                          style: AppFonts.heading1.copyWith(fontSize: 24),
                        ),
                        SizedBox(height: 10),
                        // Artist name
                        Text(
                          'by ${artData['artist']}',
                          style: AppFonts.bodyText1.copyWith(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[700]),
                        ),
                        SizedBox(height: 20),
                        // Description
                        Text(
                          'Description',
                          style: AppFonts.heading2.copyWith(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'This artwork features a surreal landscape with sharp, towering mountain peaks that merge into a blurred, abstract central area, suggesting a mysterious or dream-like quality. The color palette is rich with deep blues, warm oranges, and vibrant reds at the base, which could represent lava or a fiery abyss. The contrast between the realistic mountains and the abstract elements creates an intriguing visual tension',
                          style: AppFonts.bodyText2,
                        ),
                        SizedBox(height: 20),
                        // Artist style
                        Text(
                          'Artist Style',
                          style: AppFonts.heading2.copyWith(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Abstract, Surrealism',
                          style: AppFonts.bodyText2,
                        ),
                        SizedBox(height: 20),
                        // Price
                        Text(
                          'Price',
                          style: AppFonts.heading2.copyWith(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(
                          artData['price'] ?? '',
                          style: AppFonts.bodyText1,
                        ),
                        SizedBox(height: 20),
                        // Contact number
                        Text(
                          'Contact Number',
                          style: AppFonts.heading2.copyWith(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '+1 (123) 456-7890',
                          style: AppFonts.bodyText1,
                        ),
                        SizedBox(height: 30),
                        // Add to cart button
                        if (!ismyart)
                          CustomButton(
                              onpress: () {},
                              text: 'Add to Favorite',
                              parver: 15.0),
                        if (!ismyart) SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
