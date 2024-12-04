import 'package:art_hive_app/headers.dart';

class SignUpView extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // final UserController userController = Get.find<UserController>();

  SignUpView({super.key});
  final UserController userController = Get.find<UserController>();

  // Observable state for loading
  final RxBool isLoading = false.obs;

  Future<void> function() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    // Observable state for loading
    isLoading.value = true;

    if (_formKey.currentState!.validate()) {
      // Create a new UserModel instance
      User newUser = User(name: name, email: email, password: password);

      // Save the user using UserController
      final bool success = await userController.saveUser(newUser);

      if (success) {
        Get.snackbar('Sign up Success', 'Account created successfully.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white,
            colorText: Colors.green);

        Get.toNamed(MyGet.login);
      }
    } else {
      Get.snackbar('Sign up Error', 'Please fix the errors in the form.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          colorText: Colors.red);
    }
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg',
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
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          Icons.gamepad_outlined,
                          color: secondarycolor,
                          size: 35,
                        ),
                        Center(
                          child: Text(
                            'ArtHive',
                            style: AppFonts.logoText
                                .copyWith(fontSize: 22, color: secondarycolor),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Name TextFormField
                        CustomTextField(
                          controller: nameController,
                          hinttext: "Name",
                          icon: const Icon(Icons.person_outline),
                          validator: InputValidators.validateName,
                          maxline: 1,
                          isdesc: false,
                        ),
                        const SizedBox(height: 20),
                        // Email TextFormField
                        CustomTextField(
                          controller: emailController,
                          validator: InputValidators.validateEmail,
                          hinttext: "Email",
                          icon: const Icon(Icons.mail_outline),
                          maxline: 1,
                          isdesc: false,
                        ),
                        const SizedBox(height: 20),
                        // Password TextFormField
                        CustomTextField(
                          validator: InputValidators.validatePassword,
                          controller: passwordController,
                          hinttext: "Password",
                          isPasswordField: true,
                          icon: const Icon(Icons.lock_outline_rounded),
                          maxline: 1,
                          isdesc: false,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account ',
                              style: AppFonts.bodyText2,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.offAndToNamed(MyGet.login);
                              },
                              child: Text(
                                'Login',
                                style: AppFonts.bodyText2
                                    .copyWith(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Obx(() {
                          return CustomButton(
                            text: isLoading.value
                                ? "Loading..." // Pass a String instead of Text widget
                                : "Sign up",
                            parver: 12.0,
                            onpress: isLoading.value
                                ? () {} // Disable button while loading
                                : () async {
                                    await function(); // Call the async function inside a synchronous wrapper
                                  },
                          );
                        })
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
