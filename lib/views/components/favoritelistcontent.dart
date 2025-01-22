import 'package:art_hive_app/headers.dart';

class FavoriteListContent extends StatelessWidget {
  final ArtworkController artworkController = Get.find<ArtworkController>();

  FavoriteListContent({
    super.key,
    required this.favoriteArtData,
  });

  final RxList<Artwork> favoriteArtData;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(
      () => favoriteArtData.isEmpty
          ? Center(
              child: Text(
                "No favorites added yet.",
                style: AppFonts.bodyText1,
              ),
            )
          : ListView.builder(
              itemCount: favoriteArtData.length,
              itemBuilder: (BuildContext context, int index) {
                final artItem = favoriteArtData[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              artItem.imageUrl.isEmpty
                                  ? "assets/placeholder.jpg"
                                  : artItem.imageUrl,
                              height: size.width * 0.28,
                              width: size.width * 0.41,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                    child: Container(
                                      height: size.width * 0.28,
                                      width: size.width * 0.41,
                                      color: Colors.grey[300],
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
                                  height: size.width * 0.28,
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
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  artItem.title,
                                  style: AppFonts.heading4,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  artItem.artistName,
                                  style: AppFonts.bodyText1,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: FittedBox(
                                        child: Text(
                                          "Rs ${artItem.price.toString()}",
                                          style: AppFonts.bodyText1,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        artworkController.updateFavoriteStatus(
                                          artItem.id,
                                          false,
                                          false,
                                        );
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
                );
              },
            ),
    );
  }
}
