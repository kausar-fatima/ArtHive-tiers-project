import 'package:art_hive_app/headers.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ArtworkController artworkController = Get.find<ArtworkController>();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    artworkController.fetchArtworks();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    artworkController.searchArtworks(searchController.text);
  }

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
          resizeToAvoidBottomInset: false,
          backgroundColor:
              Colors.transparent, // Make Scaffold background transparent
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
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
                child: StreamBuilder(
                  stream: artworkController.artworks.stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      if (artworkController.artworks.isEmpty) {
                        return const Center(
                          child: Text('No artworks found'),
                        );
                      } else {
                        return ListContent(
                            artData: artworkController.artworks,
                            isFavorite: false);
                      }
                    }
                  },
                ),
              ),
            ],
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
              currentTab: 0,
            ),
          ),
        ),
      ),
    );
  }
}
