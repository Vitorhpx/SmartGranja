import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  final IconData icon;
  final double dataValue;
  final String dataUnit;
  final String dataCategory;

  const DataCard({
    Key? key,
    required this.icon,
    required this.dataValue,
    required this.dataUnit,
    required this.dataCategory
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          child: Column(
            children: <Widget>[
              Icon(this.icon),
              Text(
                this.dataCategory,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                '$dataValue $dataUnit',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                )
              )
            ]
          ),
          padding: EdgeInsets.all(16.0),
        )
      ),
      width: double.infinity,
    );
  }
}
