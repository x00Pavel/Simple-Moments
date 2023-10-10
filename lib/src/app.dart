import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

import 'package:provider/provider.dart';


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    MashupsScreen(),
    CameraScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Moments',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/list': (context) => MashupsScreen(),
        '/camera': (context) => CameraScreen(),
        '/profile': (context) => ProfileScreen(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Simple Moments'),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Mashups',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Camera',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class MashupsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}

class CameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Explore Screen'),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}

// class _HomePageState extends State<HomePage>{
//   @override
//   var selectedIndex = 0;
//   Widget build(BuildContext context) {
//     Widget page;
//     switch (selectedIndex) {
//       case 0:
//         page = GeneratorPage();
//         break;
//       case 1:
//         page = FavoritesPage();
//         break;
//       default:
//         throw UnimplementedError('no widget for $selectedIndex');
//     }

//     return Scaffold(body: Row,)

//   }

// }

/// The Widget that configures your application.
// class MyApp extends StatelessWidget {
//   const MyApp({
//     super.key,
//     required this.settingsController,
//   });

//   final SettingsController settingsController;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:
//         AppBar(
//           title: const Text("Simple moments"),
//         )

//     );
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
  //   return ListenableBuilder(
  //     listenable: settingsController,
  //     builder: (BuildContext context, Widget? child) {
  //       return MaterialApp(
  //         // Providing a restorationScopeId allows the Navigator built by the
  //         // MaterialApp to restore the navigation stack when a user leaves and
  //         // returns to the app after it has been killed while running in the
  //         // background.
  //         restorationScopeId: 'app',

  //         // Provide the generated AppLocalizations to the MaterialApp. This
  //         // allows descendant Widgets to display the correct translations
  //         // depending on the user's locale.
  //         localizationsDelegates: const [
  //           AppLocalizations.delegate,
  //           GlobalMaterialLocalizations.delegate,
  //           GlobalWidgetsLocalizations.delegate,
  //           GlobalCupertinoLocalizations.delegate,
  //         ],
  //         supportedLocales: const [
  //           Locale('en', ''), // English, no country code
  //         ],

  //         // Use AppLocalizations to configure the correct application title
  //         // depending on the user's locale.
  //         //
  //         // The appTitle is defined in .arb files found in the localization
  //         // directory.
  //         onGenerateTitle: (BuildContext context) =>
  //             AppLocalizations.of(context)!.appTitle,

  //         // Define a light and dark color theme. Then, read the user's
  //         // preferred ThemeMode (light, dark, or system default) from the
  //         // SettingsController to display the correct theme.
  //         theme: ThemeData(),
  //         darkTheme: ThemeData.dark(),
  //         themeMode: settingsController.themeMode,

  //         // Define a function to handle named routes in order to support
  //         // Flutter web url navigation and deep linking.
  //         onGenerateRoute: (RouteSettings routeSettings) {
  //           return MaterialPageRoute<void>(
  //             settings: routeSettings,
  //             builder: (BuildContext context) {
  //               switch (routeSettings.name) {
  //                 case SettingsView.routeName:
  //                   return SettingsView(controller: settingsController);
  //                 case SampleItemDetailsView.routeName:
  //                   return const SampleItemDetailsView();
  //                 case SampleItemListView.routeName:
  //                 default:
  //                   return const SampleItemListView();
  //               }
  //             },
  //           );
  //         },
  //       );
  //     },
  //   );
//   }
// }
