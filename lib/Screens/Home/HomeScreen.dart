import 'package:flutter/material.dart';
import 'package:my_barber/Models/Users.dart';
import 'package:my_barber/Screens/Appointment/AppointmentScreen.dart';
import 'package:my_barber/Screens/Discover/DiscoverScreen.dart';
import 'package:my_barber/Screens/Generic/LoadingScreen.dart';
import 'package:my_barber/Screens/Profile/ProfileScreen.dart';
import 'package:my_barber/Services/auth_service.dart';
import 'package:my_barber/Utils/app_localizations.dart';
import 'package:my_barber/Utils/size_config.dart';

class HomeScreen extends StatefulWidget {
  final int selectedPage;

  HomeScreen(this.selectedPage);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  int _selectedPage;
  var _pageOptions;
  String _appBarTitle = "";
  bool isLoadedOnce = false;
  Users _user;

  void getUser() async {
    setState(() {
      isLoading = true;
    });
    var user = await AuthService().getCurrentUser();
    setState(() {
      _user = user;
      isLoading = false;
      _pageOptions = [
        DiscoverScreen(_user),
        AppointmentScreen(_user),
        ProfileScreen(_user),
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();

    setState(() {
      _selectedPage = widget.selectedPage != null ? widget.selectedPage : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoadedOnce) {
      if (_selectedPage == 0) {
        _appBarTitle =
            AppLocalizations.of(context).translate('discover_screen_title');
      }
      if (_selectedPage == 1) {
        _appBarTitle =
            AppLocalizations.of(context).translate('appointment_screen_title');
      }
      if (_selectedPage == 2) {
        _appBarTitle =
            AppLocalizations.of(context).translate('profile_screen_title');
      }
      isLoadedOnce = true;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(centerTitle: true,
        title: Text(_appBarTitle, style: TextStyle(letterSpacing: 4,fontWeight: FontWeight.bold, shadows: <Shadow>[
          Shadow(
            offset: Offset(2, 5),
            blurRadius: 3.0,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          Shadow(
            offset: Offset(2, 5),
            blurRadius: 8.0,
            color: Color.fromARGB(125, 0, 0, 255),
          ),
        ],),),
      ),
      body: isLoading ? LoadingScreen() : _pageOptions[_selectedPage],
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.white),
          child: BottomNavigationBar(
            currentIndex: _selectedPage,
            onTap: (int index) {
              setState(() {
                if (index == 0) {
                  _appBarTitle = AppLocalizations.of(context)
                      .translate('discover_screen_title');
                }
                if (index == 1) {
                  _appBarTitle = AppLocalizations.of(context)
                      .translate('appointment_screen_title');
                }
                if (index == 2) {
                  _appBarTitle = AppLocalizations.of(context)
                      .translate('profile_screen_title');
                }
                _selectedPage = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            fixedColor: Theme.of(context).primaryColorDark,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                title: Text(
                  AppLocalizations.of(context)
                      .translate('discover_screen_title'),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 2 * SizeConfig.textMultiplier),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book_online),
                title: Text(
                  AppLocalizations.of(context)
                      .translate('appointment_screen_title'),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 2 * SizeConfig.textMultiplier),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_pin),
                title: Text(
                  AppLocalizations.of(context)
                      .translate('profile_screen_title'),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 2 * SizeConfig.textMultiplier),
                ),
              ),
            ],
          )),
    );
  }
}
