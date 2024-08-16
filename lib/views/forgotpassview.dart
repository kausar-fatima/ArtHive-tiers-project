import 'package:art_hive_app/headers.dart';

class ForgotPasswordView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  // final UserController userController = Get.find<UserController>();

  ForgotPasswordView({super.key});
  final UserController userController = Get.find<UserController>();

  void function() async {
    String email = emailController.text.trim();
    String newPassword = newPasswordController.text.trim();

    final User? user = await userController.firebaseService.getUser(email);

    if (user != null) {
      user.password = newPassword;
      await userController.saveUser(user); // Save updated user data
      Get.snackbar('Success', 'Password reset successfully.');
      Get.back(); // Navigate back to login
    } else {
      Get.snackbar('Error', 'User does not exist.');
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
              margin: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child:
                            Text('Forgot Password', style: AppFonts.heading3),
                      ),

                      SizedBox(height: 25),
                      // Email TextFormField
                      customTextField(
                        controller: emailController,
                        hinttext: "Email",
                        isobscure: false,
                        icon: Icon(Icons.mail_outline),
                        maxline: 1,
                        isdesc: false,
                      ),
                      SizedBox(height: 20),
                      // Password TextFormField
                      customTextField(
                        controller: newPasswordController,
                        hinttext: "New Password",
                        isobscure: true,
                        icon: Icon(Icons.lock_outline_rounded),
                        maxline: 1,
                        isdesc: false,
                      ),

                      SizedBox(height: 20),
                      CustomButton(
                        text: "Reset Password",
                        parver: 12.0,
                        onpress: function,
                      ),
                      SizedBox(height: 20),
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
