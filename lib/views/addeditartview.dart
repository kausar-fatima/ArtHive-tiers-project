import 'package:art_hive_app/headers.dart';

class AddEditArtworkView extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController artistNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController artStyleController = TextEditingController();

  AddEditArtworkView({super.key, required this.isEdit});
  final bool isEdit;

  void addArtwork() async {
    String title = titleController.text.trim();
    String artistName = artistNameController.text.trim();
    String description = descriptionController.text.trim();
    String price = priceController.text.trim();
    String artStyle = artStyleController.text.trim();

    // Add your logic here to save the artwork details

    Get.snackbar('Success', 'Artwork added successfully.');
    Get.back(); // Navigate back after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg', // Replace with your background image asset
              fit: BoxFit.fill,
            ),
          ),
          // Artwork Form Card
          Center(
            child: Card(
              margin: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () => Get.back(),
                              icon: Icon(Icons.arrow_back),
                              color: primarycolor,
                            ),
                            Spacer(),
                            Text(!isEdit ? "Add Artwork" : "Edit Artwork",
                                style: AppFonts.heading3),
                            Spacer(),
                          ],
                        ),
                        SizedBox(height: 25),
                        // Upload Section
                        GestureDetector(
                          // onTap: uploadArtworkImage,
                          child: Column(
                            children: [
                              Icon(
                                Icons.upload,
                                color: primarycolor,
                                size: 40,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Upload Artwork Image',
                                style: AppFonts.bodyText2
                                    .copyWith(color: primarycolor),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        // Title TextFormField
                        customTextField(
                          controller: titleController,
                          hinttext: "Title",
                          isobscure: false,
                          icon: Icon(Icons.title),
                          maxline: 1,
                          isdesc: false,
                        ),
                        SizedBox(height: 20),

                        // Artist Name TextFormField
                        customTextField(
                          controller: artistNameController,
                          hinttext: "Artist Name",
                          isobscure: false,
                          icon: Icon(Icons.person_outline),
                          maxline: 1,
                          isdesc: false,
                        ),
                        SizedBox(height: 20),

                        // Description TextFormField
                        customTextField(
                          controller: descriptionController,
                          hinttext: "Description",
                          isobscure: false,
                          icon: Icon(Icons.description_outlined),
                          maxline: 5, // Allow more lines for description
                          isdesc: true,
                        ),
                        SizedBox(height: 20),

                        // Price TextFormField
                        customTextField(
                          controller: priceController,
                          hinttext: "Price",
                          isobscure: false,
                          icon: Icon(Icons.attach_money_outlined),
                          maxline: 1,
                          isdesc: false,
                        ),
                        SizedBox(height: 20),

                        // Art Style TextFormField
                        customTextField(
                          controller: artStyleController,
                          hinttext: "Art Style",
                          isobscure: false,
                          icon: Icon(Icons.brush_outlined),
                          maxline: 1,
                          isdesc: false,
                        ),
                        SizedBox(height: 20),

                        customTextField(
                          controller: artStyleController,
                          hinttext: "Phone No",
                          isobscure: false,
                          icon: Icon(Icons.phone),
                          maxline: 1,
                          isdesc: false,
                        ),
                        SizedBox(height: 20),

                        CustomButton(
                          text: !isEdit ? "Add Artwork" : "Edit Artwork",
                          parver: 12.0,
                          onpress: addArtwork,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
