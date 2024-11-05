import 'package:art_hive_app/headers.dart';

// ignore: must_be_immutable
class NavBarContainer extends StatefulWidget {
  NavBarContainer({
    super.key,
    this.currentTab = 0,
  });
  int currentTab;
  @override
  State<NavBarContainer> createState() => _NavBarContainerState();
}

class _NavBarContainerState extends State<NavBarContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MaterialButton(
                onPressed: () {
                  setState(() {
                    widget.currentTab = 0;
                    Get.offAndToNamed(MyGet.home);
                  });
                },
                minWidth: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.dashboard,
                      color: widget.currentTab == 0
                          ? primarycolor
                          : secondarycolor,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                        color: widget.currentTab == 0
                            ? primarycolor
                            : secondarycolor,
                      ),
                    )
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    widget.currentTab = 1;
                    Get.offAndToNamed(MyGet.myarts);
                  });
                },
                minWidth: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.gamepad_rounded,
                      color: widget.currentTab == 1
                          ? primarycolor
                          : secondarycolor,
                    ),
                    Text(
                      'My Arts',
                      style: TextStyle(
                        color: widget.currentTab == 1
                            ? primarycolor
                            : secondarycolor,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MaterialButton(
                onPressed: () {
                  setState(() {
                    widget.currentTab = 2;
                    Get.offAndToNamed(MyGet.favorite);
                  });
                },
                minWidth: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: widget.currentTab == 2
                          ? primarycolor
                          : secondarycolor,
                    ),
                    Text(
                      'Favorite',
                      style: TextStyle(
                        color: widget.currentTab == 2
                            ? primarycolor
                            : secondarycolor,
                      ),
                    )
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    widget.currentTab = 3;
                    Get.offAndToNamed(MyGet.profile);
                  });
                },
                minWidth: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_3,
                      color: widget.currentTab == 3
                          ? primarycolor
                          : secondarycolor,
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: widget.currentTab == 3
                            ? primarycolor
                            : secondarycolor,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
