import 'package:flutter/material.dart';

class CalculoPage extends StatefulWidget {
  @override
  State<CalculoPage> createState() => _CalculoPageState();
}

class _CalculoPageState extends State<CalculoPage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: _resetFields,
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Icon(
                Icons.person_outline,
                size: 180,
                color: Colors.green,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: TextFormField(
                  controller: weightController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Insira seu Peso!";
                    }
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.green,
                  ),
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.green,
                    ),
                    labelText: 'Peso (Kg)',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: TextFormField(
                  controller: heightController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Insira sua Altura!";
                    }
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.green,
                  ),
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.green,
                    ),
                    labelText: 'Altura (cm)',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed:() {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if(formKey.currentState!.validate()){
                    _calculate();
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(370, 60),
                  primary: const Color(0xff4caf50),
                  padding: const EdgeInsets.all(14),
                ),
                child: const Text(
                  'Calcular',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _infoText,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
