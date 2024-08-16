import 'package:art_hive_app/headers.dart';

class MyArtsView extends StatefulWidget {
  const MyArtsView({super.key});

  @override
  State<MyArtsView> createState() => _MyArtsViewState();
}

class _MyArtsViewState extends State<MyArtsView> {
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
            child: myArtsListContent(
              artData: artData,
            ),
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
              currentTab: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class myArtsListContent extends StatelessWidget {
  const myArtsListContent({
    super.key,
    required this.artData,
  });

  final List<Map<String, String>> artData;

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Expanded(
      child: ListView.builder(
        itemCount: artData.length, // Specify the number of items
        itemBuilder: (BuildContext context, int index) {
          final artItem = artData[index]; // Get the data for the current item
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                Get.to(
                  () => ArtDetailsView(
                    artData: artData[index],
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
                        child: Image.asset(
                          'assets/art${index + 1}.jpg',
                          height: _size.width * 0.46,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        artItem['title'] ?? '',
                        style: AppFonts.heading3,
                        overflow: TextOverflow.ellipsis, // Handle overflow
                        maxLines: 1, // Limit to one line
                      ),
                      Text(
                        artItem['artist'] ?? '',
                        style: AppFonts.bodyText1,
                        overflow: TextOverflow.ellipsis, // Handle overflow
                        maxLines: 1, // Limit to one line
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Text(
                        'This artwork features a surreal landscape with sharp, towering mountain peaks that merge into a blurred, abstract central area, suggesting a mysterious or dream-like quality. The color palette is rich with deep blues, warm oranges, and vibrant reds at the base, which could represent lava or a fiery abyss. The contrast between the realistic mountains and the abstract elements creates an intriguing visual tension',
                        style: AppFonts.bodyText2,
                        overflow: TextOverflow.ellipsis, // Handle overflow
                        maxLines: 3, // Limit to three lines
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      // Edit and Delete buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            artItem['price'] ?? '',
                            style: AppFonts.bodyText1,
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: primarycolor,
                            ),
                            onPressed: () {
                              Get.to(() => AddEditArtworkView(isEdit: true));
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              // Implement delete functionality
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
      ),
    );
  }
}
