import 'package:art_hive_app/headers.dart';

// ignore: must_be_immutable
class ArtDetailsView extends StatefulWidget {
  final Map<String, dynamic> artData;

  const ArtDetailsView(
      {super.key, required this.artData, required this.ismyart});
  final bool ismyart;

  @override
  State<ArtDetailsView> createState() => _ArtDetailsViewState();
}

class _ArtDetailsViewState extends State<ArtDetailsView> {
  final ArtworkController artworkController = Get.find<ArtworkController>();
  late String text =
      widget.artData['isFavorite'] ? "Remove from Favorite" : "Add to Favorite";
  late bool isfav;

  @override
  void initState() {
    super.initState();
    isfav = widget.artData['isFavorite'];
    text = isfav ? "Remove from Favorite" : "Add to Favorite";
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                'assets/background.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top image section
                  Stack(
                    children: [
                      Container(
                        height: size.height * 0.6,
                        width: double.infinity,
                        child: Image.network(
                          widget.artData['imageUrl'] == null
                              ? "assets/placeholder.jpg"
                              : widget.artData['imageUrl']!,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            }
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
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
                        top: 20,
                        left: 20,
                        child: IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.artData['title']!,
                                style: AppFonts.heading1.copyWith(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Artist name
                              Text(
                                'by ${widget.artData['artist']}',
                                style: AppFonts.bodyText1.copyWith(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: size.height * 0.38,
                    color: white,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          // Description section
                          Text(
                            widget.artData['description']!,
                            style: AppFonts.bodyText2.copyWith(
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Details section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow('Artist Style',
                                  widget.artData['artistStyle']!),
                              const SizedBox(height: 10),
                              _buildDetailRow(
                                  'Price', "\$${widget.artData['price']}"),
                              const SizedBox(height: 10),
                              _buildDetailRow(
                                  'Contact', widget.artData['phoneNo']!),
                            ],
                          ),
                          Spacer(),
                          // Add to favorite button
                          if (!widget.ismyart)
                            SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                onpress: () {
                                  setState(() {
                                    isfav = !isfav;
                                    text = isfav
                                        ? "Remove from Favorite"
                                        : "Add to Favorite";
                                  });
                                  artworkController.updateFavoriteStatus(
                                      widget.artData['id']!, isfav, true);
                                },
                                parver: 12.0,
                                text: text,
                              ),
                            ),
                          if (!widget.ismyart) const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppFonts.bodyText1.copyWith(
            //fontSize: 18,
            color: Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: AppFonts.bodyText2.copyWith(
            //fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
