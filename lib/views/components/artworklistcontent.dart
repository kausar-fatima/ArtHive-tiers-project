import 'package:art_hive_app/headers.dart';

class ListContent extends StatelessWidget {
  final ArtworkController artworkController = Get.find<ArtworkController>();
  ListContent({
    super.key,
    required this.artData,
    required this.isFavorite,
  });

  final RxList<Artwork> artData;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(
      () => ListView.builder(
        itemCount: artData.length,
        itemBuilder: (BuildContext context, int index) {
          final artItem = artData[index];
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 25.0, vertical: size.height * 0.05),
            child: GestureDetector(
              onTap: () {
                Get.to(
                  () => ArtDetailsView(
                    artData: {
                      'id': artItem.id,
                      'title': artItem.title,
                      'artist': artItem.artistName,
                      'price': artItem.price.toString(),
                      'description': artItem.description,
                      'imageUrl': artItem.imageUrl,
                      'phoneNo': artItem.phoneNo.toString(),
                      'artistStyle': artItem.artStyle,
                      'isFavorite': artItem.isFavorite,
                    },
                    ismyart: isFavorite ? true : false,
                  ),
                );
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Card widget for text content
                  SizedBox(
                    width: double.infinity,
                    // height: size.height * 0.34,
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height:
                                    size.height * 0.13), // Space for the image
                            Text(
                              artItem.title,
                              style: AppFonts.heading3,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.05),
                              child: Text(
                                artItem.description,
                                style: AppFonts.bodyText2,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.05),
                              child: Text(
                                "Rs ${artItem.price.toString()}",
                                style: AppFonts.bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Positioned image outside the card
                  Positioned(
                    top: -40, // Adjust to move image out of the card
                    left: size.width * 0.05, // Center it horizontally
                    right: size.width * 0.2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 10,
                            offset: const Offset(
                                4, 4), // Shadow to right and bottom
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          artItem.imageUrl.isEmpty
                              ? "assets/placeholder.jpg"
                              : artItem.imageUrl,
                          height: size.width * 0.4,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Container(
                                height: size.width * 0.4,
                                color: Colors.grey[300],
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
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
                              );
                            }
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: size.width * 0.4,
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
