import 'package:flutter/cupertino.dart';
import 'package:focused_menu/modals.dart';
import 'widget/CustomList.dart';
import 'package:flutter/material.dart';
import 'widget/CustomCard.dart';
import 'widget/Atividade.dart';
import 'package:intl/intl.dart';
import 'package:focused_menu/focused_menu.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPageIndex = 0;
  Atividade _newAtiv = Atividade(image: 'assets/placeholder.jpg', titulo: 'titulo', subtitulo: 'subtitulo');
  List<Atividade> _oldAtiv = [];
  List<Atividade> _currentAtiv =[];
  String _tituloLembrete = '';
  String _subtituloLembrete = '';
  DateTime _lembrete = DateTime.now();

  TextEditingController _date = TextEditingController();
  TextEditingController _time = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index){
          setState(() {
            _currentPageIndex = index;
            print(index);
          });
        },
        selectedIndex: _currentPageIndex,
        indicatorColor: Colors.amber,
        destinations: const <Widget> [
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: "Home",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_max_outlined),
            label: "Home",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_mini_outlined),
            label: "Home",
          )
        ]
      ),
      body:<Widget>[
        GridView.builder(
          itemCount: _currentAtiv.length,
          itemBuilder: (BuildContext context, int index){
            return FocusedMenuHolder(
              openWithTap: true,
              onPressed: (){},
              menuItems: [
                FocusedMenuItem(
                    title: Text('Editar'),
                    trailingIcon: Icon(Icons.edit),
                    onPressed: (){
                      setState(() {
                        _currentPageIndex = 1;
                        print('edição');
                      });
                      },
                ),
                FocusedMenuItem(
                  title: Text('deletar', style: TextStyle(color: Colors.white),),
                  trailingIcon: Icon(Icons.edit, color: Colors.white),
                  backgroundColor:Colors.red,
                  onPressed: (){
                    setState(() {
                      _currentAtiv.removeAt(index);
                      print('deletado');
                    });
                    },
                ),
              ],
              blurBackgroundColor: Colors.blueGrey[900],
              child: CustomCard(image: _currentAtiv[index].image, title: _currentAtiv[index].titulo, subtitle: _currentAtiv[index].subtitulo),

            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.6,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                label: Text('Titulo'),
              ),
              onChanged: (value) {
                setState(() {
                  _tituloLembrete = value;
                });
              },
            ),
            SizedBox(height: 20,),
            Text(_tituloLembrete),
            SizedBox(height: 20,),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
                label: Text('Subtitulo'),
              ),
              onChanged: (value) {
                setState(() {
                  _subtituloLembrete = value;
                });
              },
            ),
            SizedBox(height: 20,),
            Text(_subtituloLembrete),
            TextField(
              controller: _date,
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today_rounded),
                labelText: 'date'
              ),
              onTap: () async {
                DateTime? pickeddate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2040),
                );
                if (pickeddate != null){
                  setState(() {
                    _date.text = DateFormat('yyy-MM-dd').format(pickeddate);
                    _lembrete = DateTime(pickeddate.year,pickeddate.month,pickeddate.day,_lembrete.hour, _lembrete.minute);
                  });
                }
              },
            ),
            SizedBox(height: 20,),
            TextField(
              controller: _time,
              decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today_rounded),
                  labelText: 'date'
              ),
              onTap: () async {
                  TimeOfDay? newTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return MediaQuery(
                      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                      child: child ?? Container(),
                      );
                    },
                    );
                  if (newTime != null){
                    setState(() {
                      _time.text = newTime.toString();
                      _lembrete = DateTime(_lembrete.year,_lembrete.month,_lembrete.day,newTime.hour, newTime.minute);
                    });
                  }
                  },
            ),
            SizedBox(height: 20,),
            Text('$_lembrete'),
            SizedBox(height: 20,),
            FloatingActionButton(
              tooltip: 'confirm',
              onPressed: (){
                setState(() {
                  _newAtiv = Atividade(image: 'assets/placeholder.jpg', titulo: _tituloLembrete, subtitulo: _subtituloLembrete);
                  _oldAtiv.add(_newAtiv);
                  _currentAtiv.add(_newAtiv);
                });
              },
            ),
            Text(_newAtiv.image),
            Text(_newAtiv.titulo),
            Text(_newAtiv.subtitulo),
            Text(_newAtiv.lembretes.toString())
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.grey,
              child:
              FloatingActionButton(
                tooltip: 'Deletar',
                onPressed: (){
                  setState(() {
                    _oldAtiv = [];
                  });
                },
              ),
            ),
            Expanded(
              flex: 9,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _oldAtiv.length,
                itemBuilder: (BuildContext context, int index) {
                  return FocusedMenuHolder(
                    openWithTap: true,
                    onPressed: (){},
                    menuItems: [
                      FocusedMenuItem(
                        title: Text('Editar'),
                        trailingIcon: Icon(Icons.edit),
                        onPressed: (){
                          setState(() {
                            _currentPageIndex = 1;
                            print('edição');
                          });
                        },
                      ),
                      FocusedMenuItem(
                        title: Text('deletar', style: TextStyle(color: Colors.white),),
                        trailingIcon: Icon(Icons.edit, color: Colors.white),
                        backgroundColor:Colors.red,
                        onPressed: (){
                          setState(() {
                            _oldAtiv.removeAt(index);
                            print('deletado');
                          });
                        },
                      ),
                    ],
                    blurBackgroundColor: Colors.blueGrey[900],
                    child: CustomList(image: _oldAtiv[index].image, title: _oldAtiv[index].titulo, subtitle: _oldAtiv[index].subtitulo),

                  );
                }
                    //CustomList(image: _oldAtiv[index].image, title: _oldAtiv[index].titulo, subtitle: _oldAtiv[index].subtitulo);},
              ),
            ),

          ],
        )

      ][_currentPageIndex],
    );
  }
}
