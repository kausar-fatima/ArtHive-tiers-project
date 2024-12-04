import 'package:art_hive_app/headers.dart';
import 'package:flutter/services.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // final ArtworkController artworkController = Get.find<ArtworkController>();
  // final TextEditingController searchController = TextEditingController();

  int _currentTab = 0;

  final List<Widget> _pages = [
    Artworksview(),
    MyArtsView(),
    FavoriteView(),
    ProfileView(),
  ];

  void _onTabChanged(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  // This method will be triggered when the back button is pressed
  Future<bool> _onWillPop() async {
    if (_currentTab != 0) {
      setState(() {
        _currentTab = 0; // Navigate to the first page
      });
      return Future.value(false); // Prevent default back action
    } else {
      SystemNavigator.pop(); // Close the app if on the first page
      return Future.value(true); // Allow the app to close
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/background(2).jpg'), // Your background image
              fit: BoxFit.fill, // Cover the whole screen
            ),
          ),
          child: Scaffold(
            appBar: _currentTab != 0 && _currentTab != 3
                ? AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent,
                    toolbarHeight: 70,
                    title: Center(
                      child: Text(
                        _currentTab == 2 ? 'Favorite Artworks' : 'My Artworks',
                        style: AppFonts.heading3.copyWith(fontSize: 28),
                      ),
                    ),
                  )
                : null,
            resizeToAvoidBottomInset: false,
            backgroundColor:
                Colors.transparent, // Make Scaffold background transparent
            body: _pages[_currentTab],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.to(() => const AddEditArtworkView(isEdit: false));
              },
              backgroundColor: white,
              shape: const CircleBorder(),
              child: Icon(
                Icons.add,
                color: primarycolor,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              color: white.withOpacity(0.5),
              notchMargin: 10,
              child: NavBarContainer(
                currentTab: _currentTab,
                onTabChanged: _onTabChanged,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
