import 'package:art_hive_app/headers.dart';

class SignUpView extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // final UserController userController = Get.find<UserController>();

  SignUpView({super.key});
  final UserController userController = Get.find<UserController>();

  void function() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (_formKey.currentState!.validate()) {
      // Create a new UserModel instance
      User newUser = User(name: name, email: email, password: password);

      // Save the user using UserController
      await userController.saveUser(newUser);

      Get.snackbar('Success', 'Account created successfully.');
      Get.toNamed(MyGet.login);
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
                        // Name TextFormField
                        customTextField(
                          controller: nameController,
                          hinttext: "Name",
                          icon: Icon(Icons.person_outline),
                          isobscure: false,
                          validator: InputValidators.validateName,
                          maxline: 1,
                          isdesc: false,
                        ),
                        SizedBox(height: 20),
                        // Email TextFormField
                        customTextField(
                          controller: emailController,
                          validator: InputValidators.validateEmail,
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
                        SizedBox(height: 20),
                        CustomButton(
                          text: "Sign up",
                          parver: 12.0,
                          onpress: function,
                        )
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
