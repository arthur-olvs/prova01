import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blueGrey),
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.blueGrey),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: const TextStyle(fontSize: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.blue, width: 2), borderRadius: BorderRadius.circular(10)),
          labelStyle: const TextStyle(color: Colors.blueGrey),
        ),
      ),
      home: const IMCCalculator(),
    );
  }
}

class IMCCalculator extends StatefulWidget {
  const IMCCalculator({super.key});

  @override
  State<IMCCalculator> createState() => _IMCCalculatorState();
}

class _IMCCalculatorState extends State<IMCCalculator> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  double? imcResult;
  String imcCategory = '';

  void _calculateIMC() {
    String weightText = weightController.text.replaceAll(',', '.');
    String heightText = heightController.text.replaceAll(',', '.');

    double? weight = double.tryParse(weightText);
    double? height = double.tryParse(heightText);

    if (weight != null && height != null && height > 0) {
      setState(() {
        imcResult = weight / (height * height);
        _determineCategory(imcResult!);
      });
    } else {
      setState(() {
        imcResult = null;
        imcCategory = 'Preencha peso e altura corretamente.';
      });
    }
  }

  void _determineCategory(double imc) {
    if (imc < 16) {
      imcCategory = 'Magreza grave';
    } else if (imc >= 16 && imc < 17) {
      imcCategory = 'Magreza moderada';
    } else if (imc >= 17 && imc < 18.5) {
      imcCategory = 'Magreza leve';
    } else if (imc >= 18.5 && imc < 25) {
      imcCategory = 'Saudável';
    } else if (imc >= 25 && imc < 30) {
      imcCategory = 'Sobrepeso';
    } else if (imc >= 30 && imc < 35) {
      imcCategory = 'Obesidade grau I';
    } else if (imc >= 35 && imc < 40) {
      imcCategory = 'Obesidade grau II';
    } else {
      imcCategory = 'Obesidade grau III';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.blue, 
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Icon(Icons.monitor_weight, size: 80, color: Colors.blue),
            const SizedBox(height: 30),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Peso (kg)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    controller: heightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Altura (m)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _calculateIMC,
              child: const Text('Calcular IMC'),
            ),
            const SizedBox(height: 40),
            if (imcResult != null)
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1), 
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.blue, width: 1), 
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Resultado:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${imcResult!.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.blue), 
                    ),
                    const SizedBox(height: 15),
                    Text(
                      imcCategory,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else if (imcCategory.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  imcCategory,
                  style: TextStyle(fontSize: 18, color: Colors.red[700], fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 40),
            Text(
              'Tabela de IMC',
              style: Theme.of(context).textTheme.titleLarge, 
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Table(
              border: TableBorder.all(color: Colors.grey[400]!), 
              columnWidths: const {
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey[200]), 
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Categoria', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('IMC', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                _buildTableRow('Magreza grave', '< 16', context),
                _buildTableRow('Magreza moderada', '16 a < 17', context),
                _buildTableRow('Magreza leve', '17 a < 18.5', context),
                _buildTableRow('Saudável', '18.5 a < 25', context, isHealthy: true),
                _buildTableRow('Sobrepeso', '25 a < 30', context, isWarning: true), 
                _buildTableRow('Obesidade grau I', '30 a < 35', context, isDanger: true), 
                _buildTableRow('Obesidade grau II', '35 a < 40', context, isDanger: true),
                _buildTableRow('Obesidade grau III', '>= 40', context, isDanger: true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String category, String imcRange, BuildContext context, {bool isHealthy = false, bool isWarning = false, bool isDanger = false}) {
    Color? rowColor;
    TextStyle? textStyle = Theme.of(context).textTheme.bodyMedium;

    if (isHealthy) {
      rowColor = Colors.green[100];
      textStyle = textStyle?.copyWith(color: Colors.green[700], fontWeight: FontWeight.w500);
    } else if (isWarning) {
      rowColor = Colors.orange[100];
      textStyle = textStyle?.copyWith(color: Colors.orange[700]);
    } else if (isDanger) {
      rowColor = Colors.red[100];
      textStyle = textStyle?.copyWith(color: Colors.red[700]);
    }

    return TableRow(
      decoration: BoxDecoration(color: rowColor),
      children: [
        Padding(padding: const EdgeInsets.all(12.0), child: Text(category, style: textStyle)),
        Padding(padding: const EdgeInsets.all(12.0), child: Text(imcRange, style: textStyle)),
      ],
    );
  }
}
