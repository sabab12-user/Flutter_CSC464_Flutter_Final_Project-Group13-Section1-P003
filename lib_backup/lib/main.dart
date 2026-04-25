import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Initialize Firebase with your web configuration
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBqxC4RBKfzSfk0M_KWksSxJDfFFqudtUo",
        authDomain: "shopping-cart-app-fa202.firebaseapp.com",
        projectId: "shopping-cart-app-fa202",
        storageBucket: "shopping-cart-app-fa202.firebasestorage.app",
        messagingSenderId: "624223088890",
        appId: "1:624223088890:web:1050def70a5df0d2c25943",
        measurementId: "G-Y4DYC4PKJW",
      ),
    );
    print('✅ Firebase initialized successfully');
  } catch (e) {
    print('❌ Firebase error: $e');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MaterialApp(
        title: 'ShopEasy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
          ),
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}