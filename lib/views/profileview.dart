import 'dart:io';

import 'package:art_hive_app/headers.dart';
import 'package:art_hive_app/views/components/profileButtons.dart';

import 'components/bg.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final UserController userController = Get.find<UserController>();
  final ArtworkController artworkController = Get.find<ArtworkController>();

  String? _selectedImage;
  bool isPasswordVisible = false; // Variable to control visibility

  File? imageFile;

  bool isupdated = false;

  final _formKey = GlobalKey<FormState>();

  // Observable state for loading
  final RxBool isLoading = false.obs;

  void uploadImage() async {
    try {
      imageFile = await artworkController.pickImage();
      if (imageFile != null) {
        setState(() {
          _selectedImage = imageFile!.path;
        });
        await saveImage();
      } else {
        Get.snackbar('Image Upload Error',
            'Failed to upload profile image. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            colorText: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Image Upload Error',
          'Failed to upload profile image. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.red);
    }
  }

  Future<void> saveImage() async {
    isLoading.value = true;
    if (imageFile != null) {
      await artworkController.uploadImage(imageFile!, true);
      await userController.updateUserImage(imageFile!);
      Get.snackbar(
          'Image Upload Success', 'Profile image uploaded successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.green);
    } else {
      Get.snackbar('Image Error', 'No image selected to upload.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.red);
    }
    isLoading.value = false;
  }

  @override
  void initState() {
    super.initState();
    if (userController.user.value != null) {
      _selectedImage = userController.user.value!.imageUrl ??
          "assets/profile placeholder.png";
    } else {
      _selectedImage = "assets/profile placeholder.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    final String name = userController.user.value?.name ?? "No Name";
    final String email = userController.user.value?.email ?? "No Email";
    final String password =
        userController.user.value?.password ?? "No Password";
    var size = MediaQuery.of(context).size;

    void function() async {
      await userController.updateIsLoggedIn(false);

      Get.offAllNamed(MyGet.login); // Navigate to Login Screen
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Get.offAndToNamed(MyGet.home),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: size.width * 0.25),
          child: Text(
            "Profile",
            style: AppFonts.heading3.copyWith(fontSize: 28),
          ),
        ),
      ),
      body: Container(
        decoration: kAppBg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(height: size.height * 0.05),
                // User Information
                Container(
                  margin: EdgeInsets.only(
                      left: size.width * 0.1,
                      right: size.width * 0.1,
                      top: size.height * 0.08,
                      bottom: size.height * 0.05),
                  padding: const EdgeInsets.only(top: 20, bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: size.height * 0.035,
                      ),
                      Text(
                        name,
                        style: AppFonts.bodyText1
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        email,
                      ),
                      if (password.isNotEmpty)
                        // Password Text with visibility toggle
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isPasswordVisible
                                  ? password
                                  : '*' *
                                      password
                                          .length, // Dynamically create masked version
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    isPasswordVisible = !isPasswordVisible;
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                Positioned(
                  right: size.width / 2 - 50,
                  left: size.width / 2 - 50,
                  top: size.height * 0.025,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.grey[200], // Fallback color
                    backgroundImage:
                        _selectedImage == userController.user.value!.imageUrl
                            ? FileImage(File(_selectedImage!))
                            : imageFile != null
                                ? FileImage(imageFile!)
                                : AssetImage('assets/placeholder.png')
                                    as ImageProvider,
                    onBackgroundImageError: (error, stackTrace) {
                      errorImageWidget();
                    },
                  ),
                ),
                Positioned(
                  right: size.width / 3 - 60,
                  left: size.width / 2 - 50,
                  top: size.height * 0.043,
                  child: GestureDetector(
                    onTap: () async {
                      uploadImage();
                    },
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.edit,
                        size: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            ProfileButtons(
                text: 'Edit Profile',
                icon: const Icon(Icons.edit),
                onpress: () {
                  _showEditProfileDialog(
                      context, userController, artworkController, _formKey);
                }),
            // width: size.width * 0.5,
            //             height: 50,
            ProfileButtons(
              text: 'Logout',
              icon: const Icon(
                Icons.logout,
                weight: 8,
              ),
              onpress: () async {
                bool? confirm = await showConfirmationDialog(
                  context,
                  title: "Logout Acount",
                  content: "Are you sure to Logout your account",
                );

                if (confirm == true) {
                  function();
                } else {
                  Get.snackbar("Cancelled", "Logout cancelled",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.white,
                      colorText: Colors.red);
                }
              },
            ),
            SizedBox(height: size.height * 0.09),
            ProfileButtons(
              text: 'Delete Account',
              icon: const Icon(Icons.delete_sharp),
              onpress: () async {
                // Implement delete account functionality
                bool? confirm = await showConfirmationDialog(
                  context,
                  title: "Delete Acount",
                  content: "Are you sure to delete account",
                );

                if (confirm == true) {
                  userController.clearUser(email);
                  artworkController.deleteArtworksByArtistEmail(email);
                  Get.offAllNamed(MyGet.login);
                } else {
                  Get.snackbar("Cancelled", "Deletion cancelled",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.white,
                      colorText: Colors.red);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget Imagebox() {
  //   debugPrint(
  //       "+++++++++$_selectedImage++++++++${userController.user.value!.imageUrl}+++++++++");

  //   return ClipOval(
  //     child: Container(
  //       width: 120,
  //       height: 120,
  //       decoration: BoxDecoration(
  //         shape: BoxShape.circle,
  //         color: Colors.grey[300], // Adjust this color as needed
  //       ),
  //       child: _selectedImage == userController.user.value!.imageUrl
  //           ? Image.file(
  //               File(_selectedImage!),
  //               fit: BoxFit.cover,
  //               errorBuilder: (context, error, stackTrace) {
  //                 return errorImageWidget(); // Error icon if image fails to load
  //               },
  //             )
  //           : imageFile != null
  //               ? Image.file(
  //                   imageFile!,
  //                   fit: BoxFit.cover,
  //                   errorBuilder: (context, error, stackTrace) {
  //                     return errorImageWidget(); // Error icon if image fails to load
  //                   },
  //                 )
  //               : Image.asset(
  //                   _selectedImage!,
  //                   fit: BoxFit.cover,
  //                 ),
  //     ),
  //   );
  // }

  Widget errorImageWidget() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
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

void _showEditProfileDialog(BuildContext context, UserController userController,
    ArtworkController artworkController, GlobalKey<FormState> formKey) {
  final TextEditingController nameController =
      TextEditingController(text: userController.user.value!.name);
  final TextEditingController emailController =
      TextEditingController(text: userController.user.value!.email);
  final TextEditingController passwordController =
      TextEditingController(text: userController.user.value!.password);
  var size = MediaQuery.of(context).size;

  // Observable state for loading
  final RxBool isLoading = false.obs;

  Future<void> function() async {
    String oldEmail = userController.user.value!.email;
    String newEmail = emailController.text;
    isLoading.value = true;
    if (formKey.currentState!.validate()) {
      // Save the updated values
      bool isupdated = await userController.updateUser(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      if (isupdated) {
        debugPrint("***********$oldEmail************$newEmail***********");
        await artworkController.updateArtistEmail(oldEmail, newEmail);
        debugPrint("@@@@@@@@ Profile updated successfully @@@@@@@@");
        Get.back(); // Close the dialog
        Get.snackbar('Profile Success', 'Profile updated successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            colorText: Colors.green);
      } else {
        Get.snackbar('Profile Error', 'Email already registered',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            colorText: Colors.red);
      }
    } else {
      Get.snackbar('Profile Error', 'Please fix the errors in the form',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.red);
    }
    isLoading.value = false;
  }

  Get.defaultDialog(
    title: "Edit Profile",
    content: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextField(
                validator: InputValidators.validateName,
                controller: nameController,
                hinttext: "Name",
                icon: const Icon(Icons.person),
                maxline: 1,
                isdesc: false),
            const SizedBox(height: 16),
            CustomTextField(
                controller: emailController,
                validator: InputValidators.validateEmail,
                hinttext: "Email",
                icon: const Icon(Icons.mail_outline),
                maxline: 1,
                isdesc: false),
            const SizedBox(height: 16),
            CustomTextField(
                controller: passwordController,
                validator: InputValidators.validatePassword,
                hinttext: "Password",
                isPasswordField: true,
                icon: const Icon(Icons.lock),
                maxline: 1,
                isdesc: false),
          ],
        ),
      ),
    ),
    confirm: SizedBox(
      width: size.width * 0.5,
      height: 50,
      child: Obx(
        () {
          return CustomButton(
            text: isLoading.value
                ? "Loading..." // Pass a String instead of Text widget
                : "Save Changes",
            parver: 10.0,
            onpress: isLoading.value
                ? () {} // Disable button while loading
                : () async {
                    await function(); // Call the async function inside a synchronous wrapper
                  },
          );
        },
      ),
    ),
    cancel: SizedBox(
      width: size.width * 0.5,
      height: 50,
      child: CustomButton(
          text: "Cancel",
          parver: 10.0,
          onpress: () {
            Get.back();
          }),
    ),
  );
}
