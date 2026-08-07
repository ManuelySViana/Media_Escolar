import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Média Escolar",
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true
      ),
      home: MediaEscolarPage(),
    );
  }
}

class MediaEscolarPage extends StatefulWidget{
  const MediaEscolarPage({super.key});

  @override
  State<MediaEscolarPage> createState() => MediaEscolarPageState();
}

class MediaEscolarPageState extends State<MediaEscolarPage> {

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController nota1Controller = TextEditingController();
  final TextEditingController nota2Controller = TextEditingController();
  final TextEditingController nota3Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de Média"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.school,
              size: 80,
            ),
            const Text(
              'Média Escolar',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold
              )
              )
          ],
        )
      )
    );
      
      
  }
}