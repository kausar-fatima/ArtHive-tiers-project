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
        itemCount: artData.length, // Specify the number of items
        itemBuilder: (BuildContext context, int index) {
          final artItem = artData[index]; // Get the data for the current item
          return Padding(
            padding: const EdgeInsets.all(16.0),
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
              child: Card(
                elevation: 5, // Add shadow to the card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          artItem.imageUrl.isEmpty
                              ? "assets/placeholder.jpg"
                              : artItem.imageUrl,
                          height: !isFavorite
                              ? size.width * 0.46
                              : size.width * 0.28,
                          width: size.width * 0.41,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child; // Image is fully loaded
                            } else {
                              return Center(
                                child: Container(
                                  height: !isFavorite
                                      ? size.width * 0.46
                                      : size.width * 0.28,
                                  width: size.width * 0.41,
                                  color: Colors.grey[
                                      300], // Background color while loading
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
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
                              height: !isFavorite
                                  ? size.width * 0.46
                                  : size.width * 0.28,
                              width: size.width * 0.41,
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
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        // Add Expanded to prevent overflow
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // Align text to start
                          children: [
                            Text(
                              artItem.title,
                              style: AppFonts.heading3,
                              overflow:
                                  TextOverflow.ellipsis, // Handle overflow
                              maxLines: 1, // Limit to one line
                            ),
                            Text(
                              artItem.artistName,
                              style: AppFonts.bodyText1,
                              overflow:
                                  TextOverflow.ellipsis, // Handle overflow
                              maxLines: 1, // Limit to one line
                            ),
                            if (!isFavorite)
                              const SizedBox(
                                height: 5,
                              ),
                            if (!isFavorite)
                              Text(
                                artItem.description,
                                style: AppFonts.bodyText2,
                                overflow:
                                    TextOverflow.ellipsis, // Handle overflow
                                maxLines: 3, // Limit to one line
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "\$${artItem.price.toString()}",
                                  style: AppFonts.bodyText1,
                                ),
                                const Spacer(),
                                if (isFavorite)
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      // Implement delete functionality
                                      artworkController.updateFavoriteStatus(
                                          artItem.id, false, false);
                                    },
                                  ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
