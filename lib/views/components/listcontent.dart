import 'package:art_hive_app/headers.dart';

class ListContent extends StatelessWidget {
  const ListContent({
    super.key,
    required this.artData,
    required this.isFavorite,
  });

  final List<Map<String, String>> artData;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
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
                  artData: artData[index],
                  ismyart: false,
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
                      child: Image.asset(
                        'assets/art${index + 1}.jpg',
                        height: !isFavorite
                            ? _size.width * 0.46
                            : _size.width * 0.28,
                        width: _size.width * 0.41,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      // Add Expanded to prevent overflow
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align text to start
                        children: [
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
                          if (!isFavorite)
                            SizedBox(
                              height: 5,
                            ),
                          if (!isFavorite)
                            Text(
                              'This artwork features a surreal landscape with sharp, towering mountain peaks that merge into a blurred, abstract central area, suggesting a mysterious or dream-like quality. The color palette is rich with deep blues, warm oranges, and vibrant reds at the base, which could represent lava or a fiery abyss. The contrast between the realistic mountains and the abstract elements creates an intriguing visual tension',
                              style: AppFonts.bodyText2,
                              overflow:
                                  TextOverflow.ellipsis, // Handle overflow
                              maxLines: 3, // Limit to one line
                            ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                artItem['price'] ?? '',
                                style: AppFonts.bodyText1,
                              ),
                              Spacer(),
                              if (isFavorite)
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
    );
  }
}
