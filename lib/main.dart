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
  final TextEditingController nota4Controller = TextEditingController();

  String nomeAluno = "";
  String situacao = "";
  double media = 0;
  double maiorNota = 0;
  double menorNota = 0;
  double pontosFaltantes = 0;
 
  void calcularMedia(){
    String nome = nomeController.text.trim();
    double? nota1 = double.tryParse(
      nota1Controller.text.replaceAll(",", ".")
    );
    double? nota2 = double.tryParse(
      nota2Controller.text.replaceAll(",", ".")
    );
    double? nota3 = double.tryParse(
      nota3Controller.text.replaceAll(",", ".")
    );
    double? nota4 = double.tryParse(
      nota4Controller.text.replaceAll(",", ".")
    );

    if (nome.isEmpty || nota1 == null || nota2 == null || nota3 == null || nota4 == null) {
      mostrarMensagem('Preencha todos os campos corretamente.');
      return;
    }
    if(
      nota1 < 0 || nota1 > 10 || 
      nota2 < 0 || nota2 > 10 ||
      nota3 < 0 || nota3 > 10 ||
      nota4 < 0 || nota4 > 10) {
        mostrarMensagem('As notas devem estar entre 0 e 10!');
        return;
      }

      double mediaCalculada = (nota1 + nota2 + nota3 + nota4) /4;

      List
      <double> notas = [nota1, nota2, nota3, nota4];
      double maior = notas.reduce((a, b) => a > b ? a : b);
      double menor = notas.reduce((a, b) => a < b ? a : b);

      double faltantes = mediaCalculada < 7 ? (7.0 - mediaCalculada) : 0;

      String situacaoCalculada;

      if (mediaCalculada >=7){
        situacaoCalculada = 'APROVADO';
      }else if (mediaCalculada >=5){
        situacaoCalculada = 'RECUPERAÇÃO';
      }else {
        situacaoCalculada = 'REPROVADO';
      }
      
      setState(() {
        nomeAluno = nome;
        media = mediaCalculada;
        situacao = situacaoCalculada;
        maiorNota = maior;
        menorNota = menor;
        pontosFaltantes = faltantes;
      });

      return;
  }

  void mostrarMensagem(String mensagem){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem))
    );
  }

  void limparCampos(){
    nomeController.clear();
    nota1Controller.clear();
    nota2Controller.clear();
    nota3Controller.clear();
    nota4Controller.clear();

    setState(() {
      nomeAluno = '';
      media = 0;
      situacao = '';
      maiorNota = 0;
      menorNota = 0;
      pontosFaltantes = 0;
    });
  }

  IconData escolherIcone(){
    if(situacao == 'APROVADO'){
      return Icons.check_circle;
    }else if (situacao == 'RECUPERAÇÃO'){
      return Icons.warning;
    }
    return Icons.cancel;
  }

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
            ),
            const SizedBox(height: 5,),

            const Text(
            'Digite o nome e as quatro notas do aluno',
            textAlign: TextAlign.center,
            ),

            const  SizedBox(height: 25,),

            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do aluno',
                hintText: 'Exemplo: Manuely',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder()
              )
            ),

            const SizedBox(height: 15,),

            TextField(
              controller: nota1Controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true
              ),
              decoration: const InputDecoration(
                labelText: 'Nota 1',
                hintText: 'Digite uma nota de 0 a 10',
                prefixIcon: Icon(Icons.edit),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15,),

            TextField(
              controller: nota2Controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true
              ),
              decoration: const InputDecoration(
                labelText: 'Nota 2',
                hintText: 'Digite uma nota de 0 a 10',
                prefixIcon: Icon(Icons.edit),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15,),

            TextField(
              controller: nota3Controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true
              ),
              decoration: const InputDecoration(
                labelText: 'Nota 3',
                hintText: 'Digite uma nota de 0 a 10',
                prefixIcon: Icon(Icons.edit),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15,),

            TextField(
              controller: nota4Controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true
              ),
              decoration: const InputDecoration(
                labelText: 'Nota 4',
                hintText: 'Digite uma nota de 0 a 10',
                prefixIcon: Icon(Icons.edit),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20,),

            ElevatedButton.icon(
              onPressed: calcularMedia, 
              icon: const Icon(Icons.calculate),
              label: const Text('Calcular Média')
            ),

            const SizedBox(height: 10,),

            OutlinedButton.icon(
              onPressed: limparCampos, 
              icon: const Icon(Icons.delete),
              label: const Text('Limpar'),
              ),

            const SizedBox(height: 25,),

            if(situacao.isNotEmpty)
            Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [

                    Icon(
                      escolherIcone(),
                      size: 60,
                    ),

                    Text(
                      nomeAluno,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10,),
                    Text('Média: ${media.toStringAsFixed(1)}'),

                    const SizedBox(height: 5),
                      Text('Maior Nota: ${maiorNota.toStringAsFixed(1)}'),
                      Text('Menor Nota: ${menorNota.toStringAsFixed(1)}'),  

                    if (media < 7) ...[
                        const SizedBox(height: 5),
                        Text(
                          'Faltaram ${pontosFaltantes.toStringAsFixed(1)} ponto(s) para a aprovação',
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      
                    const SizedBox(height: 10,),
                    Text(
                      situacao,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),  
                  ],
                ),
              ),
            )
          ],
        )
      )
    );

  }
}