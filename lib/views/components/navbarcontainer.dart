import 'package:art_hive_app/headers.dart';

// ignore: must_be_immutable
class NavBarContainer extends StatelessWidget {
  const NavBarContainer(
      {super.key, required this.currentTab, required this.onTabChanged});
  final int currentTab;
  final Function(int) onTabChanged;
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
                onPressed: () => onTabChanged(0),
                minWidth: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.dashboard,
                      color: currentTab == 0 ? primarycolor : secondarycolor,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                        color: currentTab == 0 ? primarycolor : secondarycolor,
                      ),
                    )
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () => onTabChanged(1),
                minWidth: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.gamepad_rounded,
                      color: currentTab == 1 ? primarycolor : secondarycolor,
                    ),
                    Text(
                      'My Arts',
                      style: TextStyle(
                        color: currentTab == 1 ? primarycolor : secondarycolor,
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
                onPressed: () => onTabChanged(2),
                minWidth: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: currentTab == 2 ? primarycolor : secondarycolor,
                    ),
                    Text(
                      'Favorite',
                      style: TextStyle(
                        color: currentTab == 2 ? primarycolor : secondarycolor,
                      ),
                    )
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () => onTabChanged(3),
                minWidth: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_3,
                      color: currentTab == 3 ? primarycolor : secondarycolor,
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: currentTab == 3 ? primarycolor : secondarycolor,
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
