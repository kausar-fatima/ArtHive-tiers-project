import 'package:art_hive_app/headers.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  final ArtworkController FavartworkController = Get.find<ArtworkController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FavartworkController.fetchFavoriteArtwork();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
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
                  artData: FavartworkController.artworks, isFavorite: true);
            }
          }
        },
      ),
    );
  }
}
