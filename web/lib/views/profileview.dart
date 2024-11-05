import 'dart:io';

import 'package:art_hive_app/headers.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final UserController userController = Get.find<UserController>();
  final ArtworkController artworkController = Get.find<ArtworkController>();

  String? _selectedImage;

  File? imageFile;

  bool isupdated = false;

  final _formKey = GlobalKey<FormState>();

  void uploadImage() async {
    try {
      imageFile = await artworkController.pickImage();
      if (imageFile != null) {
        setState(() {
          _selectedImage = imageFile!.path;
        });
      } else {
        Get.snackbar(
            'Error', 'Failed to upload profile image. Please try again.');
      }
    } catch (e) {
      Get.snackbar(
          'Error', 'Failed to upload profile image. Please try again.');
    }
  }

  void saveImage() async {
    if (imageFile != null) {
      await artworkController.uploadImage(imageFile!, true);
      await userController.updateUserImage(imageFile!);
      Get.snackbar('Success', 'Profile image uploaded successfully');
    } else {
      Get.snackbar('Error', 'No image selected to upload.');
    }
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

      Get.offAndToNamed(MyGet.login); // Navigate to Login Screen
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/background(2).jpg',
              fit: BoxFit.fill,
            ),
          ),
          // Profile Card
          Center(
            child: Card(
              margin: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: size.height * 0.6,
                  width: size.width * 0.7,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Imagebox(),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              icon: const Icon(Icons.edit, color: Colors.white),
                              onPressed: uploadImage,
                              color: primarycolor,
                              splashColor: primarycolor,
                              highlightColor: primarycolor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: size.width * 0.5,
                        height: 50,
                        child: CustomButton(
                          text: 'Save Image',
                          parver: 10.0,
                          onpress: saveImage,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Divider(),
                      const SizedBox(height: 24),
                      Text(
                        name,
                        style: AppFonts.bodyText1,
                      ),
                      const SizedBox(height: 18),
                      Text(
                        email,
                        style: AppFonts.bodyText1,
                      ),
                      const SizedBox(height: 18),
                      if (password.isNotEmpty)
                        Text(
                          password,
                          style: AppFonts.bodyText1,
                        ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: size.width * 0.5,
                        height: 50,
                        child: CustomButton(
                          text: 'Edit Profile',
                          parver: 10.0,
                          onpress: () {
                            _showEditProfileDialog(context, userController,
                                artworkController, _formKey);
                          },
                        ),
                      ),
                      const Spacer(),
                      // Logout and Delete Account Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              // Implement delete account functionality
                              bool? confirm = await showConfirmationDialog(
                                context,
                                title: "Delete Acount",
                                content: "Are you sure to delete account",
                              );

                              if (confirm == true) {
                                userController.clearUser(email);
                                artworkController
                                    .deleteArtworksByArtistEmail(email);
                                Get.offAndToNamed(MyGet.login);
                              } else {
                                Get.snackbar("Cancelled", "Deletion cancelled");
                              }
                            },
                            child: Text(
                              'Delete Account',
                              style: AppFonts.bodyText2
                                  .copyWith(color: Colors.red),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              bool? confirm = await showConfirmationDialog(
                                context,
                                title: "Logout Acount",
                                content: "Are you sure to Logout your account",
                              );

                              if (confirm == true) {
                                function();
                              } else {
                                Get.snackbar("Cancelled", "Logout cancelled");
                              }
                            },
                            child: Text(
                              'Logout',
                              style: AppFonts.bodyText2,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Back Arrow Button
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: primarycolor),
              onPressed: () {
                Get.offAndToNamed(MyGet.home); // Navigate back
              },
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Imagebox() {
    debugPrint(
        "+++++++++$_selectedImage++++++++${userController.user.value!.imageUrl}+++++++++");

    return ClipOval(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300], // Adjust this color as needed
        ),
        child: _selectedImage == userController.user.value!.imageUrl
            ? Image.file(
                File(_selectedImage!),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return errorImageWidget(); // Error icon if image fails to load
                },
              )
            : imageFile != null
                ? Image.file(
                    imageFile!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return errorImageWidget(); // Error icon if image fails to load
                    },
                  )
                : Image.asset(
                    _selectedImage!,
                    fit: BoxFit.cover,
                  ),
      ),
    );
  }

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

  void function() async {
    String oldEmail = userController.user.value!.email;
    String newEmail = emailController.text;
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
        Get.snackbar('Success', 'Profile updated successfully');
        Get.back(); // Close the dialog
      } else {
        Get.snackbar('Error', 'Email already registered');
      }
    } else {
      Get.snackbar('Error', 'Please fix the errors in the form');
    }
  }

  Get.defaultDialog(
    title: "Edit Profile",
    content: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            customTextField(
                validator: InputValidators.validateName,
                controller: nameController,
                hinttext: "Name",
                isobscure: false,
                icon: const Icon(Icons.person),
                maxline: 1,
                isdesc: false),
            const SizedBox(height: 16),
            customTextField(
                controller: emailController,
                validator: InputValidators.validateEmail,
                hinttext: "Email",
                isobscure: false,
                icon: const Icon(Icons.mail_outline),
                maxline: 1,
                isdesc: false),
            const SizedBox(height: 16),
            customTextField(
                controller: passwordController,
                validator: InputValidators.validatePassword,
                hinttext: "Password",
                isobscure: false,
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
      child: CustomButton(
        text: "Save Changes",
        parver: 10.0,
        onpress: function,
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
