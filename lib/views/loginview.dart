import 'package:art_hive_app/headers.dart';

class LoginView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // final UserController userController = Get.find<UserController>();

  LoginView({super.key});
  final UserController userController = Get.find<UserController>();

  // Observable state for loading
  final RxBool isLoading = false.obs;

  Future<void> function() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    // Observable state for loading
    isLoading.value = true;

    if (_formKey.currentState!.validate()) {
      // Trigger validation
      final User? user = await userController.firebaseService.getUser(email);
      if (user?.email != null) {
        userController.user.value = user;
        debugPrint(
            "Here is email**********${userController.user.value!.email}");
        debugPrint("Here is name**********${userController.user.value!.name}");
        debugPrint(
            "Here is password**********${userController.user.value!.password}");

        //userController.saveUserOnLocalSt(user!);
        debugPrint(
            "Here is email on local storage**********${userController.user.value!.email}");
        debugPrint(
            "Here is name on local storage**********${userController.user.value!.name}");
        debugPrint(
            "Here is password on local storage**********${userController.user.value!.password}");

        if (user?.password == password) {
          await userController.updateIsLoggedIn(true);
          Get.snackbar('Login Success', 'Logged in successfully.',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.white,
              colorText: Colors.green);
          Get.offAndToNamed(MyGet.home);
        } else {
          Get.snackbar('Login Error', 'Invalid password.',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.white,
              colorText: Colors.red);
        }
      } else {
        Get.snackbar("Login Error", "User does not exist.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white,
            colorText: Colors.red);
      }
    } else {
      Get.snackbar('Login Error', 'Please fix the errors in the form.',
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
                        // Email TextFormField
                        CustomTextField(
                          validator: InputValidators.validateEmail,
                          controller: emailController,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(MyGet.forgotPassword);
                              },
                              child: Text(
                                'Forgot Password',
                                style: AppFonts.bodyText2
                                    .copyWith(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Obx(
                          () {
                            return CustomButton(
                              parver: 12.0,
                              onpress: isLoading.value
                                  ? () {} // Disable button while loading
                                  : () async {
                                      await function(); // Call the async function inside a synchronous wrapper
                                    },
                              text: isLoading.value
                                  ? "Loading..." // Pass a String instead of Text widget
                                  : "Login",
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Create your account ',
                              style: AppFonts.bodyText2,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.offAndToNamed(MyGet.singup);
                              },
                              child: Text(
                                'Signup',
                                style: AppFonts.bodyText2
                                    .copyWith(color: Colors.blue),
                              ),
                            ),
                          ],
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
