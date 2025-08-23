import 'package:expense_tracker/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 150),
            Lottie.asset('assets/tracker.json'),
            const SizedBox(height: 30),
            Text(
                'EXPENSE TRACKER',
              style: GoogleFonts.montserrat(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
            Spacer(),
            Text('Created By Talha Ayyaz',
              style: GoogleFonts.changa(fontSize: 20),
            ),
            const SizedBox(height: 25)
          ],
        ),
      ),
    );
  }
}