import 'package:art_hive_app/headers.dart';

class MyArtsView extends StatefulWidget {
  const MyArtsView({super.key});

  @override
  State<MyArtsView> createState() => _MyArtsViewState();
}

class _MyArtsViewState extends State<MyArtsView> {
  final ArtworkController artworkController = Get.find<ArtworkController>();
  // Sample data for illustration
  // final List<Map<String, String>> artData = [
  //   {"title": "Mystic Peaks", "artist": "Alex Rivera", "price": "\$200"},
  //   {"title": "Ocean Breeze", "artist": "Emily Carter", "price": "\$150"},
  //   // Add more artwork here
  // ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage('assets/background(2).jpg'), // Your background image
            fit: BoxFit.fill, // Cover the whole screen
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            toolbarHeight: 70,
            title: Center(
                child: Text(
              'My Artworks',
              style: AppFonts.heading3.copyWith(fontSize: 28),
            )),
          ),
          backgroundColor:
              Colors.transparent, // Make Scaffold background transparent
          body: Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
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
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => const AddEditArtworkView(isEdit: false));
            },
            backgroundColor: white,
            shape: const CircleBorder(),
            child: Icon(
              Icons.add,
              color: primarycolor,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            color: white.withOpacity(0.5),
            notchMargin: 10,
            child: NavBarContainer(
              currentTab: 1,
            ),
          ),
        ),
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
            padding: const EdgeInsets.all(16.0),
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
              child: Card(
                elevation: 5, // Add shadow to the card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align content to start
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          artItem.imageUrl.isEmpty
                              ? "assets/placeholder.jpg"
                              : artItem.imageUrl, // Use image URL from artwork
                          height: size.width * 0.46,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child; // Image is fully loaded
                            } else {
                              return Center(
                                child: Container(
                                  height: size.width * 0.46,
                                  width: double.infinity,
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
                              height: size.width * 0.46,
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
                      const SizedBox(height: 10),
                      Text(
                        artItem.title,
                        style: AppFonts.heading3,
                        overflow: TextOverflow.ellipsis, // Handle overflow
                        maxLines: 1, // Limit to one line
                      ),
                      Text(
                        artItem.artistName,
                        style: AppFonts.bodyText1,
                        overflow: TextOverflow.ellipsis, // Handle overflow
                        maxLines: 1, // Limit to one line
                      ),
                      const SizedBox(height: 10),
                      Text(
                        artItem.description,
                        style: AppFonts.bodyText2,
                        overflow: TextOverflow.ellipsis, // Handle overflow
                        maxLines: 3, // Limit to three lines
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '\$${artItem.price}',
                            style: AppFonts.bodyText1,
                          ),
                          const Spacer(),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: primarycolor,
                            ),
                            onPressed: () {
                              Get.to(() => AddEditArtworkView(
                                    isEdit: true,
                                    artwork: artItem,
                                  ));
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
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
                                await artworkController
                                    .deleteArtwork(artItem.id);
                                Get.snackbar("Successful Deletion",
                                    "Arwork deleted successfully");
                              } else {
                                Get.snackbar("Cancelled", "Deletion cancelled");
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
