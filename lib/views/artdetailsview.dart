import 'package:art_hive_app/headers.dart';

// ignore: must_be_immutable
class ArtDetailsView extends StatefulWidget {
  final Map<String, dynamic> artData;

  const ArtDetailsView(
      {super.key, required this.artData, required this.ismyart});
  final bool ismyart;

  @override
  State<ArtDetailsView> createState() => _ArtDetailsViewState();
}

class _ArtDetailsViewState extends State<ArtDetailsView> {
  final ArtworkController artworkController = Get.find<ArtworkController>();
  late String text;
  late bool isfav;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isfav = widget.artData['isFavorite'];
    text = isfav ? "Remove from Favorite" : "Add to Favorite";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                'assets/background.jpg',
                fit: BoxFit.fill,
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
                        padding: const EdgeInsets.all(8),
                        height: 300,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(24),
                          ),
                          child: Image.network(
                            widget.artData['imageUrl'] == null
                                ? "assets/placeholder.jpg"
                                : widget
                                    .artData['imageUrl']!, // Dynamic image path
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child; // Image is fully loaded
                              } else {
                                return Center(
                                  child: Container(
                                    color: Colors.grey[
                                        300], // Background color while loading
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null &&
                                                loadingProgress
                                                        .expectedTotalBytes !=
                                                    0
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                (loadingProgress
                                                        .expectedTotalBytes ??
                                                    1)
                                            : null,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        child: IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Artwork title
                        Text(
                          widget.artData['title']!,
                          style: AppFonts.heading1.copyWith(fontSize: 24),
                        ),
                        const SizedBox(height: 10),
                        // Artist name
                        Text(
                          'by ${widget.artData['artist']}',
                          style: AppFonts.bodyText1.copyWith(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 20),
                        // Description
                        Text(
                          'Description',
                          style: AppFonts.heading2.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.artData['description']!,
                          style: AppFonts.bodyText2,
                        ),
                        const SizedBox(height: 20),
                        // Artist style
                        Text(
                          'Artist Style',
                          style: AppFonts.heading2.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.artData['artistStyle']!,
                          style: AppFonts.bodyText2,
                        ),
                        const SizedBox(height: 20),
                        // Price
                        Text(
                          'Price',
                          style: AppFonts.heading2.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "\$${widget.artData['price']!}",
                          style: AppFonts.bodyText1,
                        ),
                        const SizedBox(height: 20),
                        // Contact number
                        Text(
                          'Contact Number',
                          style: AppFonts.heading2.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.artData['phoneNo']!,
                          style: AppFonts.bodyText1,
                        ),
                        const SizedBox(height: 30),
                        // Add to favorite button
                        if (!widget.ismyart)
                          CustomButton(
                              onpress: () {
                                // Add to favorite
                                setState(
                                  () {
                                    isfav = !isfav;
                                    if (isfav) {
                                      text = "Remove from Favorite";
                                    } else if (!isfav) {
                                      text = "Add to Favorite";
                                    }
                                  },
                                );
                                artworkController.updateFavoriteStatus(
                                    widget.artData['id']!, isfav, true);
                              },
                              text: text,
                              parver: 15.0),
                        if (!widget.ismyart) const SizedBox(height: 30),
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
