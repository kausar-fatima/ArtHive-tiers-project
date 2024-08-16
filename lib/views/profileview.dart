import 'package:art_hive_app/headers.dart';

class ProfileView extends StatelessWidget {
  final String name = 'Fatima';
  final String email = 'fatima@gmail.com';
  final String contactNo = '123-456-7890';

  const ProfileView({super.key}); // Change as needed

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    final UserController userController = Get.find<UserController>();
    void function() async {
      await userController.updateIsLoggedIn(false);

      Get.offAndToNamed(MyGet.login); // Navigate to Home Screen
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/background(2).jpg', // Replace with your background image asset
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
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: _size.height * 0.6,
                  width: _size.width * 0.7,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/profile.jpg'), // Replace with your profile image asset
                                fit: BoxFit
                                    .cover, // Ensures the image fits within the circle
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              icon: Icon(Icons.edit, color: Colors.white),
                              onPressed: () {
                                // Implement image edit functionality
                              },
                              color: primarycolor,
                              splashColor: primarycolor,
                              highlightColor: primarycolor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        name,
                        style: AppFonts.bodyText1,
                      ),
                      SizedBox(height: 18),
                      Divider(),
                      SizedBox(height: 24),
                      Text(
                        email,
                        style: AppFonts.bodyText1,
                      ),
                      SizedBox(height: 18),
                      if (contactNo.isNotEmpty)
                        Text(
                          contactNo,
                          style: AppFonts.bodyText1,
                        ),
                      SizedBox(height: 25),
                      SizedBox(
                        width: _size.width * 0.5,
                        height: 50,
                        child: CustomButton(
                          text: 'Edit Profile',
                          parver: 10.0,
                          onpress: () {},
                        ),
                      ),
                      Spacer(),
                      // Logout and Delete Account Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Implement delete account functionality
                            },
                            child: Text(
                              'Delete Account',
                              style: AppFonts.bodyText2
                                  .copyWith(color: Colors.red),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              function();
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
            top: 40, // Adjust this value as needed
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
}
