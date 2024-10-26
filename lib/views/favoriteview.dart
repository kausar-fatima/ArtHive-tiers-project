import 'package:art_hive_app/headers.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  final ArtworkController FavartworkController = Get.find<ArtworkController>();
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
              'Favorite Artworks',
              style: AppFonts.heading3.copyWith(fontSize: 28),
            )),
          ),
          backgroundColor:
              Colors.transparent, // Make Scaffold background transparent
          body: Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: FutureBuilder(
                  future: FavartworkController.fetchFavoriteArtwork(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      if (FavartworkController.artworks.isEmpty) {
                        return const Center(
                          child: Text('No artworks found'),
                        );
                      } else {
                        return ListContent(
                            artData: FavartworkController.artworks,
                            isFavorite: true);
                      }
                    }
                  }),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => AddEditArtworkView(isEdit: false));
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
              currentTab: 2,
            ),
          ),
        ),
      ),
    );
  }
}
