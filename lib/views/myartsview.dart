import 'package:art_hive_app/headers.dart';

class MyArtsView extends StatelessWidget {
  const MyArtsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ArtworkController artworkController = Get.find<ArtworkController>();
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: FutureBuilder<void>(
        future: artworkController.fetchMyArtwork(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Check if artworkController.artworks is empty
            if (artworkController.artworks.isEmpty) {
              return const Center(child: Text('No artworks found.'));
            } else {
              return MyArtsListContent(
                artData: artworkController.artworks,
              );
            }
          }
        },
      ),
    );
  }
}

class MyArtsListContent extends StatelessWidget {
  final ArtworkController artworkController = Get.find<ArtworkController>();
  MyArtsListContent({
    super.key,
    required this.artData,
  });

  final RxList<Artwork> artData;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(() {
      return ListView.builder(
        itemCount: artData.length, // Specify the number of items
        itemBuilder: (BuildContext context, int index) {
          final artItem = artData[index]; // Get the data for the current item
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: GestureDetector(
              onTap: () {
                Get.to(
                  () => ArtDetailsView(
                    artData: {
                      'title': artItem.title,
                      'artist': artItem.artistName,
                      'price': artItem.price.toString(),
                      'description': artItem.description,
                      'imageUrl': artItem.imageUrl,
                      'phoneNo': artItem.phoneNo.toString(),
                      'artistStyle': artItem.artStyle,
                      'isFavorite': artItem.isFavorite,
                    },
                    ismyart: true,
                  ),
                );
              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      artItem.imageUrl.isEmpty
                          ? "assets/placeholder.jpg"
                          : artItem.imageUrl, // Use image URL from artwork
                      height: size.height * 0.35,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child; // Image is fully loaded
                        } else {
                          return Center(
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              color: Colors
                                  .grey[300], // Background color while loading
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                              null &&
                                          loadingProgress.expectedTotalBytes !=
                                              0
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
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
                          height: 150,
                          width: double.infinity,
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
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                artItem.title,
                                style: AppFonts.heading3.copyWith(color: white),
                                overflow:
                                    TextOverflow.ellipsis, // Handle overflow
                                maxLines: 1, // Limit to one line
                              ),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: white,
                                ),
                                onPressed: () {
                                  Get.to(
                                    () => AddEditArtworkView(
                                      isEdit: true,
                                      artwork: artItem,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          Text(
                            'by ${artItem.artistName}',
                            style: AppFonts.bodyText1.copyWith(
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                                fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            artItem.description,
                            style: AppFonts.bodyText2.copyWith(color: white),
                            overflow: TextOverflow.ellipsis, // Handle overflow
                            maxLines: 3, // Limit to three lines
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    top: 16,
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: white,
                      ),
                      onPressed: () async {
                        // Implement delete functionality

                        bool? confirm = await showConfirmationDialog(
                          context,
                          title: "Delete My Artwork",
                          content: "Are you sure to delete your Artwork",
                        );
                        if (confirm!) {
                          artData.removeAt(index);
                          await artworkController.deleteArtwork(artItem.id);
                          Get.snackbar("Successful Deletion",
                              "Arwork deleted successfully");
                        } else {
                          Get.snackbar("Cancelled", "Deletion cancelled");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
