import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'presentation/pages/characters_page.dart';
import 'presentation/providers/character_list_provider.dart';

// Cores do design
const Color kPurple = Color(0xFF87A1FA); // roxo
const Color kHeader = Color(0xFF1C1B1F); // topo
const Color kBody   = Color(0xFF000000); // fundo

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // base para o textTheme escuro do GoogleFonts
    final baseDark = ThemeData(brightness: Brightness.dark);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CharacterListProvider()),
      ],
      child: MaterialApp(
        title: 'Rick & Morty — Kode Start',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: kPurple,
            brightness: Brightness.dark, // textos claros
          ),
          textTheme: GoogleFonts.latoTextTheme(baseDark.textTheme),
          scaffoldBackgroundColor: kBody,
          appBarTheme: const AppBarTheme(
            backgroundColor: kHeader,
            foregroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
          ),
        ),
        home: const CharactersPage(),
      ),
    );
  }
}
