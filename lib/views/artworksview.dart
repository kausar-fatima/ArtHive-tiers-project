import 'package:art_hive_app/headers.dart';
import 'package:art_hive_app/views/components/artworklistcontent.dart';

class Artworksview extends StatefulWidget {
  const Artworksview({super.key});

  @override
  State<Artworksview> createState() => _ArtworksviewState();
}

class _ArtworksviewState extends State<Artworksview> {
  @override
  Widget build(BuildContext context) {
    final ArtworkController artworkController = Get.find<ArtworkController>();
    final TextEditingController searchController = TextEditingController();
    var size = MediaQuery.of(context).size;

    void onSearchChanged() {
      debugPrint("Search query: ${searchController.text}");
      artworkController.searchArtworks(searchController.text);
    }

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      artworkController.fetchArtworks();
      searchController.addListener(onSearchChanged);
    }

    @override
    void dispose() {
      // TODO: implement dispose
      searchController.removeListener(onSearchChanged);
      searchController.dispose();
      super.dispose();
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.grey,
          ],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.07, vertical: size.height * 0.02),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white
                    .withOpacity(0.7), // Semi-transparent background
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: secondarycolor,
                  ),
                  hintText: 'Search...',
                  hintStyle:
                      AppFonts.bodyText1.copyWith(color: Colors.grey[800]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: artworkController
                  .fetchArtworks(), // Fetching data from Future
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (artworkController.artworks.isEmpty) {
                  return const Center(
                    child: Text('No artworks found'),
                  );
                } else {
                  // If data is available, display it
                  return ListContent(
                    artData: artworkController
                        .artworks, // Access the data from the FutureBuilder
                    isFavorite: false,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
