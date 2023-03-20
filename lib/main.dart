import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:  MyHomePage(title: 'BMI Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String result = '';
  final formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    myButton('Male', 0, Colors.red),
                    myButton('Female', 1, Colors.red)
                  ],
                ),
                SizedBox(height: 30,),
                 TextFormField(

                   validator: (value){
                     if(value!.isEmpty){
                       return 'Enter height in cm';
                     }else{
                       return null;
                     }
                   },
                   controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter Height in cm',
                    fillColor: Colors.grey[350],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                    )
                  ),
                ),
                SizedBox(height: 12,),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Enter weight in kg';
                    }else{
                      return null;
                    }
                  },
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter weight in kg',
                      fillColor: Colors.grey[350],
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                      )
                  ),
                ),
                SizedBox(height: 30,),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(

                    onPressed: (){


                      formKey.currentState!.save();
                      if(formKey.currentState!.validate()) {
                        calculateBmi(double.parse(heightController.text.trim()),
                            double.parse(weightController.text.trim()));
                        heightController.clear();
                        weightController.clear();

                      }



                    },
                    child: Text('Calculate BMI'),

                  ),
                ),
                SizedBox(height: 30,),
                Text('Your BMI is :', style: TextStyle(fontSize: 30, color: Colors.grey[700]),),
                SizedBox(height: 30,),
                Center(child: Text(result , style: TextStyle(fontSize: 50),)),





              ],
            ),
          ),
        ),
      ),
    );
  }

  void changeIndex(int index){
    setState(() {
      currentIndex = index;
    });
  }
  Widget myButton(String text, int index, Color color){
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: currentIndex == index ? color : Colors.grey[200],
        ),
        height: 80,
        margin: EdgeInsets.symmetric(horizontal: 12),
        child: TextButton(onPressed: (){
          changeIndex(index);
        },

            child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,
              color: currentIndex == index ? Colors.white : Colors.black
            ),)),
      ),
    );
  }


  void calculateBmi(double height, double weight) {

      double calculation = weight / ((height * height) / 10000);
      final bmi = calculation.toStringAsFixed(2);
      setState(() {
        result = bmi;
      });



  }
}
