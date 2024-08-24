import 'package:art_hive_app/headers.dart';

class LoginView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // final UserController userController = Get.find<UserController>();

  LoginView({super.key});
  final UserController userController = Get.find<UserController>();

  void function() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (_formKey.currentState!.validate()) {
      // Trigger validation
      final User? user = await userController.firebaseService.getUser(email);

      if (user != null && user.password == password) {
        await userController.updateIsLoggedIn(true);
        Get.snackbar('Success', 'Logged in successfully.');
        Get.offAndToNamed(MyGet.home);
      } else {
        Get.snackbar('Error', 'Invalid email or password.');
      }
    } else {
      Get.snackbar('Error', 'Please fix the errors in the form.');
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
            child: Image.asset(
              'assets/background.jpg',
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

                        SizedBox(height: 20),
                        // Email TextFormField
                        customTextField(
                          validator: InputValidators.validateEmail,
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
                          validator: InputValidators.validatePassword,
                          controller: passwordController,
                          hinttext: "Password",
                          isobscure: true,
                          icon: Icon(Icons.lock_outline_rounded),
                          maxline: 1,
                          isdesc: false,
                        ),
                        SizedBox(height: 20),
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
                        SizedBox(height: 20),
                        CustomButton(
                          text: "Login",
                          parver: 12.0,
                          onpress: function,
                        ),
                        SizedBox(height: 20),
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
