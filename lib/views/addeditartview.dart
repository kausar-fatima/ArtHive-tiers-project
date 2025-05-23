import 'dart:io';
import 'package:art_hive_app/headers.dart';
import 'package:art_hive_app/views/components/bg.dart';

// ignore: must_be_immutable
class AddEditArtworkView extends StatefulWidget {
  const AddEditArtworkView({super.key, required this.isEdit, this.artwork});
  final bool isEdit;
  final Artwork? artwork;

  @override
  State<AddEditArtworkView> createState() => _AddEditArtworkViewState();
}

class _AddEditArtworkViewState extends State<AddEditArtworkView> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController artistNameController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController artStyleController = TextEditingController();

  final TextEditingController phoneNoController = TextEditingController();

  final ArtworkController artworkController = Get.find<ArtworkController>();

  String? _selectedImage;

  File? imageFile;

  // Observable state for loading
  final RxBool isLoading = false.obs;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEdit) {
      fillInputFields();
    }
  }

  void fillInputFields() {
    // If editing, populate the text controllers with the artwork data
    if (widget.isEdit && widget.artwork != null) {
      titleController.text = widget.artwork!.title;
      artistNameController.text = widget.artwork!.artistName;
      descriptionController.text = widget.artwork!.description;
      priceController.text = widget.artwork!.price.toString();
      artStyleController.text = widget.artwork!.artStyle;
      phoneNoController.text = widget.artwork!.phoneNo.toString();
    }
    // Load the existing image from the URL
    if (widget.artwork!.imageUrl.isNotEmpty) {
      setState(() {
        _selectedImage = widget.artwork!.imageUrl;
      });
    }
  }

  void addArtwork() async {
    // Validate user input
    String title = titleController.text.trim();
    String artistName = artistNameController.text.trim();
    String description = descriptionController.text.trim();
    String price = priceController.text.trim();
    String artStyle = artStyleController.text.trim();
    String phoneNo = phoneNoController.text.trim();

    isLoading.value = true;
    if (_formKey.currentState!.validate()) {
      if (_selectedImage == null) {
        Get.snackbar('Image Error', 'Image field is required.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            colorText: Colors.red);
        return;
      }
      try {
        if (widget.isEdit && widget.artwork != null) {
          // Edit existing artwork
          await artworkController.editArtwork(
              Artwork(
                id: widget.artwork!.id,
                title: title,
                artistName: artistName,
                description: description,
                price: double.parse(price),
                artStyle: artStyle,
                imageUrl:
                    widget.artwork!.imageUrl, // Keep the existing image URL
                phoneNo: phoneNo,
                artistEmail: artworkController.userController.user.value!.email,
                isFavorite: false, // Set default value for isFavorite
              ),
              imageFile,
              false);
          debugPrint("@@@@@@@@ Artwork Edited successfully @@@@@@@@");
          Get.back();
          Get.snackbar('Artwork Success', 'Artwork edited successfully.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
              colorText: Colors.green);
        } else {
          // Add new artwork
          await artworkController.addArtwork(
              Artwork(
                id: '',
                title: title,
                artistName: artistName,
                description: description,
                price: double.parse(price),
                artStyle: artStyle,
                imageUrl: '', // Placeholder, will be set after upload
                phoneNo: phoneNo,
                artistEmail: artworkController.userController.user.value!.email,
                isFavorite: false, // Set default value for isFavorite
              ),
              imageFile!,
              false);
          debugPrint("@@@@@@@@ Artwork Added successfully @@@@@@@@");
          Get.back();
          Get.snackbar('Artwork Success', 'Artwork uploaded successfully.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
              colorText: Colors.green);
        }
      } catch (e) {
        Get.snackbar(
            'Artwork Error', 'Failed to save artwork. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            colorText: Colors.red);
      }
    } else {
      Get.snackbar('Artwork Error', 'Please fix the errors in the form.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.red);
    }
    isLoading.value = false;
  }

  void uploadImage() async {
    try {
      imageFile = await artworkController.pickImage();
      if (imageFile != null) {
        setState(() {
          _selectedImage = imageFile!.path;
        });
      } else {
        Get.snackbar(
            'Image Upload Error', 'Failed to upload image. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            colorText: Colors.red);
      }
    } catch (e) {
      Get.snackbar(
          'Image Upload Error', 'Failed to upload image. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
              child: Container(
            decoration: kAppBg,
          )),
          // Artwork Form Card
          Center(
            child: Card(
              margin: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Icon(
                                Icons.arrow_back,
                                color: primarycolor,
                              ),
                            ),
                            const Spacer(),
                            Text(
                                !widget.isEdit
                                    ? "Upload Artwork"
                                    : "Edit Artwork",
                                style: AppFonts.heading3),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 25),
                        // Upload Section
                        _selectedImage == null
                            ? GestureDetector(
                                onTap: uploadImage,
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.upload,
                                      color: Colors.blue,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Upload Artwork Image',
                                      style: AppFonts.bodyText2
                                          .copyWith(color: Colors.blue),
                                    ),
                                  ],
                                ),
                              )
                            : Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Imagebox(),
                                    ),
                                  ),
                                  if (widget.isEdit)
                                    Positioned(
                                      top: 3.5,
                                      right: 50,
                                      child: GestureDetector(
                                        onTap:
                                            uploadImage, // Allow the user to upload a new image
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Colors.white.withOpacity(0.7),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Icon(
                                              Icons.edit,
                                              size: 20,
                                              color: primarycolor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                        const SizedBox(height: 25),
                        // Title TextFormField
                        CustomTextField(
                          controller: titleController,
                          validator: InputValidators.validateTitle,
                          hinttext: "Title",
                          icon: const Icon(Icons.title),
                          maxline: 1,
                          isdesc: false,
                        ),
                        const SizedBox(height: 20),

                        // Artist Name TextFormField
                        CustomTextField(
                          controller: artistNameController,
                          validator: InputValidators.validateArtistName,
                          hinttext: "Artist Name",
                          icon: const Icon(Icons.person_outline),
                          maxline: 1,
                          isdesc: false,
                        ),
                        const SizedBox(height: 20),

                        // Description TextFormField
                        CustomTextField(
                          controller: descriptionController,
                          validator: InputValidators.validateDesc,
                          hinttext: "Description",
                          icon: const Icon(Icons.description_outlined),
                          maxline: 5, // Allow more lines for description
                          isdesc: true,
                        ),
                        const SizedBox(height: 20),

                        // Price TextFormField
                        CustomTextField(
                          controller: priceController,
                          validator: InputValidators.validatePrice,
                          hinttext: "Price",
                          icon: const Icon(Icons.attach_money_outlined),
                          maxline: 1,
                          isdesc: false,
                        ),
                        const SizedBox(height: 20),

                        // Art Style TextFormField
                        CustomTextField(
                          controller: artStyleController,
                          validator: InputValidators.validateStyle,
                          hinttext: "Art Style",
                          icon: const Icon(Icons.brush_outlined),
                          maxline: 1,
                          isdesc: false,
                        ),
                        const SizedBox(height: 20),

                        CustomTextField(
                          controller: phoneNoController,
                          validator: InputValidators.validatePhoneNumber,
                          hinttext: "Phone No",
                          icon: const Icon(Icons.phone),
                          maxline: 1,
                          isdesc: false,
                        ),
                        const SizedBox(height: 20),
                        Obx(
                          () {
                            return CustomButton(
                              text: isLoading.value
                                  ? "Loading..."
                                  : !widget.isEdit
                                      ? "Upload Artwork"
                                      : "Edit Artwork",
                              parver: 12.0,
                              onpress: isLoading.value
                                  ? () {} // Disable button while loading
                                  : addArtwork,
                            );
                          },
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

  Widget Imagebox() {
    if (_selectedImage != null && _selectedImage!.startsWith('http')) {
      // Load image from the network
      return Image.network(
        _selectedImage!,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child; // Image is fully loaded
          } else {
            return Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300], // Background color while loading
                ),
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null &&
                            loadingProgress.expectedTotalBytes != 0
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                ),
              ),
            );
          }
        },
        errorBuilder: (context, error, stackTrace) {
          return errorImageWidget();
        },
      );
    } else if (imageFile != null) {
      // Load image from local file
      return Image.file(
        imageFile!,
        fit: BoxFit.cover,
      );
    } else {
      // Default error state
      return errorImageWidget();
    }
  }

  Widget errorImageWidget() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[300],
      ),
      child: const Icon(
        Icons.error,
        color: Colors.red,
        size: 40,
      ),
    );
  }
}
