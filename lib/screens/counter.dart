import 'package:flutter/material.dart';

class CounterDesign extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CounterDesign();
  }
}

class _CounterDesign extends State<CounterDesign> {
  int _n = 0;
  int _amt = 0;

  void add() {
    setState(() {
      _n++;
      _amt = _amt + 10;
    });
  }

  void minus() {
    setState(() {
      if (_n != 0) _n--;
      _amt = _amt - 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 155.0,
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            children: <Widget>[
              new IconButton(
                icon: const Icon(
                  Icons.filter_alt,
                  color: Colors.black,
                ),
                onPressed: () {
                  
                },
              ),
              SizedBox(
                width: 10.0,
              ),
              //new Text('$_n', style: new TextStyle(fontSize: 30.0)),
              SizedBox(
                width: 45.0,
              ),
              new IconButton(
                icon: const Icon(
                  Icons.info,
                  color: Colors.black,
                ),
                onPressed: () {
                 
                },
              ),
              SizedBox(
                width: 20.0,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 100.0,
        ),
        Container(
          ),
      ],
    );
  }
}
             
             
             /* ),
            ),
          ),
        ]),
      ),
    ]);
  }
}*/
