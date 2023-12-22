import 'package:amazon_clone/Provider/user_provider.dart';
import 'package:amazon_clone/common/widgets/BottomBar.dart';
import 'package:amazon_clone/features/Admin/screens/admin_screen.dart';
import 'package:amazon_clone/features/auth/screens/Auth_Screen.dart';
import 'package:amazon_clone/routes.dart';
import 'package:amazon_clone/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/global_variables.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider(),),
  ],
  child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Auth_Services  auth_services = Auth_Services();

  @override
  void initState() {
    super.initState();
    auth_services.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme:  const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          )
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty ?
          Provider.of<UserProvider>(context).user.type == 'user'
          ? const BottomBar()
          : const AdminScreen()
          : const AuthScreen(),
    );
  }
}
