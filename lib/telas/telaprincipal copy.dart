import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // isso é uma lista de texto, que contem o endereço das imagens
  List<String> images = ['cato1.jpeg', 'cato2.jpeg', 'cato3.webp'];

  List<int> imagemSelecionada = [0, 0, 0];

  void spin() async {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          imagemSelecionada = List.generate(
            3,
            (_) => Random().nextInt(images.length),
          );
        });
      });
    }

    if (imagemSelecionada[0] == imagemSelecionada[1] &&
        imagemSelecionada[1] == imagemSelecionada[2]) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("Parabéns!"),
              content: Text("Miau!"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("OK"),
                ),
              ],
            ),
      );
    }
  }

  double somatorio = 1;

  Future<void> sortear() async {
    int i = 0;
    while (i < 5) {
      setState(() {
        imagemSelecionada[0] = Random().nextInt(images.length);
        imagemSelecionada[1] = Random().nextInt(images.length);
        imagemSelecionada[2] = Random().nextInt(images.length);
      });
      await Future.delayed(Duration(milliseconds: 300));
      i++;
    }

    if (imagemSelecionada[0] == imagemSelecionada[1] &&
        imagemSelecionada[1] == imagemSelecionada[2]) {
      somatorio = somatorio + 10;

      showDialog(
        context: context,
        builder:
            (context) =>
                AlertDialog(title: Text("Parabens"), content: Text("Miau")),
      );
    } else {
      somatorio = somatorio - 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width - 30;
    final larguraImagem = larguraTela / 3;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Meow",
          style: TextStyle(fontSize: 30, backgroundColor: Colors.blue),
        ),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.blueGrey,
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          sortear();
        },
        child: Icon(Icons.add_a_photo),
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Row(
            //LINHA
            mainAxisAlignment: MainAxisAlignment.center, //alinhamento
            children: [
              //FILHOS
              Image.asset(
                images[imagemSelecionada[0]],
                width: larguraImagem,
                height: 200,
              ),
              SizedBox(width: 15),
              Image.asset(
                images[imagemSelecionada[1]],
                width: larguraImagem,
                height: 200,
              ),
              SizedBox(width: 15),
              Image.asset(
                images[imagemSelecionada[2]],
                width: larguraImagem,
                height: 200,
              ),
            ],
          ),
          Text(
            "Pontos: " + somatorio.toString(),
            style: TextStyle(fontSize: 20,
            color: Colors.black, fontWeight: FontWeight.w500,
            backgroundColor: Colors.blue,),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
