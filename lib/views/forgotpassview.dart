import 'package:art_hive_app/headers.dart';
import 'package:art_hive_app/views/components/bg.dart';

class ForgotPasswordView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final UserController userController = Get.find<UserController>();

  // Observable state for loading
  final RxBool isLoading = false.obs;

  ForgotPasswordView({super.key});

  Future<void> function() async {
    String email = emailController.text.trim();
    String newPassword = newPasswordController.text.trim();

    if (_formKey.currentState!.validate()) {
      try {
        // Show loading indicator
        isLoading.value = true;

        final User? user = await userController.firebaseService.getUser(email);

        if (user != null) {
          user.password = newPassword;
          await userController.firebaseService
              .updateUserField(email, 'password', newPassword);
          // Show success Snackbar
          Get.snackbar('Password Reset Success', 'Password reset successfully.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
              colorText: Colors.green);

          // Navigate back to login after success
          // Get.back();
        } else {
          // Show error Snackbar
          Get.snackbar('Password Reset Error', 'User does not exist.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
              colorText: Colors.red);
        }
      } catch (error) {
        // Handle any errors during the process
        Get.snackbar(
            'Password Reset Error', 'An error occurred. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            colorText: Colors.red);
      } finally {
        // Hide loading indicator
        isLoading.value = false;
      }
    } else {
      // Validation failed
      Get.snackbar('Password Reset Error', 'Please fix the errors in the form.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
              child: Container(
            decoration: kAppBg,
          )),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child:
                            Text('Forgot Password', style: AppFonts.heading3),
                      ),
                      const SizedBox(height: 25),

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
                        controller: newPasswordController,
                        validator: InputValidators.validatePassword,
                        hinttext: "New Password",
                        isPasswordField: true,
                        icon: const Icon(Icons.lock_outline_rounded),
                        maxline: 1,
                        isdesc: false,
                      ),

                      const SizedBox(height: 20),

                      // Custom Button with loading indicator
                      Obx(() {
                        return CustomButton(
                          parver: 12.0,
                          onpress: isLoading.value
                              ? () {} // Disable button while loading
                              : () async {
                                  await function(); // Call the async function inside a synchronous wrapper
                                },
                          text: isLoading.value
                              ? "Loading..." // Pass a String instead of Text widget
                              : "Reset Password",
                        );
                      }),

                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Login to your account ',
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
                    ],
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
