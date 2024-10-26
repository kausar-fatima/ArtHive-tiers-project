import 'package:art_hive_app/headers.dart';

class ForgotPasswordView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // final UserController userController = Get.find<UserController>();

  ForgotPasswordView({super.key});
  final UserController userController = Get.find<UserController>();

  void function() async {
    String email = emailController.text.trim();
    String newPassword = newPasswordController.text.trim();

    if (_formKey.currentState!.validate()) {
      final User? user = await userController.firebaseService.getUser(email);

      if (user != null) {
        user.password = newPassword;
        await userController.saveUser(user); // Save updated user data
        Get.snackbar('Success', 'Password reset successfully.');
        Get.back(); // Navigate back to login
      } else {
        Get.snackbar('Error', 'User does not exist.');
      }
    } else {
      Get.snackbar('Error', 'Please fix the errors in the form.');
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
            child: Image.asset(
              'assets/background.jpg', // Replace with your background image asset
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
                      customTextField(
                        controller: emailController,
                        validator: InputValidators.validateEmail,
                        hinttext: "Email",
                        isobscure: false,
                        icon: const Icon(Icons.mail_outline),
                        maxline: 1,
                        isdesc: false,
                      ),
                      const SizedBox(height: 20),
                      // Password TextFormField
                      customTextField(
                        controller: newPasswordController,
                        validator: InputValidators.validatePassword,
                        hinttext: "New Password",
                        isobscure: true,
                        icon: const Icon(Icons.lock_outline_rounded),
                        maxline: 1,
                        isdesc: false,
                      ),

                      const SizedBox(height: 20),
                      CustomButton(
                        text: "Reset Password",
                        parver: 12.0,
                        onpress: function,
                      ),
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
