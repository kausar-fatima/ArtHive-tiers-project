import 'package:art_hive_app/headers.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Sample data for illustration
  final List<Map<String, String>> artData = [
    {"title": "Mystic Peaks", "artist": "Alex Rivera", "price": "\$200"},
    {"title": "Ocean Breeze", "artist": "Emily Carter", "price": "\$150"},
    // Add more artwork here
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
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
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: secondarycolor,
                      ),
                      hintText: 'Search...',
                      hintStyle:
                          AppFonts.bodyText1.copyWith(color: Colors.grey[800]),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                    ),
                  ),
                ),
              ),
              Expanded(child: ListContent(artData: artData, isFavorite: false)),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => AddEditArtworkView(isEdit: false));
            },
            child: Icon(
              Icons.add,
              color: primarycolor,
            ),
            backgroundColor: white,
            shape: CircleBorder(),
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
