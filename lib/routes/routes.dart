import 'package:flutter/material.dart';

import '../screens/screens.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  '/home': (_) => const HomeScreen(),
  '/login': (_) => LoginScreen(),
  '/loading': (_) => const LoadingScreen(),
  '/register': (_) => RegisterScreen(),
};
