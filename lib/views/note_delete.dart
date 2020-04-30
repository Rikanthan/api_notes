import 'package:flutter/material.dart';

class notedelete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Warning'),
      content:Text('Are you sure you want yo delete this note?'),
      actions: <Widget>[
        FlatButton(
            child:Text('Yes'),
            onPressed:()
            {
              Navigator.of(context).pop(true);
            },

        ),
        FlatButton(
          child:Text('No'),
          onPressed:()
          {
            Navigator.of(context).pop(false);
          },

        ),


      ],
    );
  }
}
