import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("Home Screen Loaded");

    void greet() {
      print("Hello Akmal");
    }

    

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            void main() {
              greet();
            }
          },
          child: const Text("Flutter Testing", style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
