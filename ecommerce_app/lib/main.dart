import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/screens/auth_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

// --- HIGH-END TECH GADGETS COLOR PALETTE ---
const Color kCyberBlue = Color(0xFF0066FF);
const Color kNeonPurple = Color(0xFF8A2BE2);
const Color kDarkCharcoal = Color(0xFF1A1A1A);
const Color kSpaceGray = Color(0xFF2A2A2A);
const Color kPureWhite = Color(0xFFFFFFFF);
const Color kEmeraldGlow = Color(0xFF00FFAA);
// --- END OF COLOR PALETTE ---

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final cartProvider = CartProvider();
  cartProvider.initializeAuthListener();

  FlutterNativeSplash.remove();
  
  runApp(
    ChangeNotifierProvider.value(
      value: cartProvider,
      child: const MyApp(),
    ),
  );

  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aurora Prime',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: kCyberBlue,
          brightness: Brightness.dark,
          primary: kCyberBlue,
          onPrimary: kPureWhite,
          secondary: kNeonPurple,
          onSecondary: kPureWhite,
          background: kDarkCharcoal,
          surface: kSpaceGray,
          onBackground: kPureWhite,
          onSurface: kPureWhite,
        ),
        useMaterial3: true,

        scaffoldBackgroundColor: kDarkCharcoal,

        textTheme: GoogleFonts.orbitronTextTheme(
          Theme.of(context).textTheme.copyWith(
            bodyLarge: GoogleFonts.inter(color: kPureWhite),
            bodyMedium: GoogleFonts.inter(color: kPureWhite),
            bodySmall: GoogleFonts.inter(color: kPureWhite),
            titleLarge: GoogleFonts.orbitron(
              color: kPureWhite,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: GoogleFonts.orbitron(
              color: kPureWhite,
              fontWeight: FontWeight.w600,
            ),
            headlineSmall: GoogleFonts.orbitron(
              color: kPureWhite,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kEmeraldGlow,
            foregroundColor: kDarkCharcoal,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: GoogleFonts.orbitron(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: kSpaceGray,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          labelStyle: TextStyle(color: kPureWhite.withOpacity(0.7)),
          hintStyle: TextStyle(color: kPureWhite.withOpacity(0.5)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: kCyberBlue, width: 2.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),

        // FIXED: Correct CardTheme syntax
        cardTheme: CardThemeData(
          elevation: 4,
          color: kSpaceGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadowColor: Colors.black.withOpacity(0.5),
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.zero,
        ),

        appBarTheme: AppBarTheme(
          backgroundColor: kDarkCharcoal,
          foregroundColor: kPureWhite,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.orbitron(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: kNeonPurple,
          foregroundColor: kPureWhite,
        ),

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: kSpaceGray,
          selectedItemColor: kCyberBlue,
          unselectedItemColor: kPureWhite.withOpacity(0.6),
        ),
      ),
      home: const AuthWrapper(),
    );
  }
}