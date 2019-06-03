import 'package:flutter/material.dart';

enum BuildingType{theater,restaurant}

class Building{
   BuildingType type;
   String title;
   String address;

    Building(this.type,this.title,this.address);
}


typedef onItemClickListener = void Function(int position);
class ItemView extends StatelessWidget{
   int position;
    Building building;
   onItemClickListener listener;
   ItemView(this.position ,this.building,this.listener);

     @override
      Widget build(BuildContext context) {
         final icon =Icon(
           building.type == BuildingType.restaurant?Icons.restaurant:Icons.theaters,
           color: Colors.blue[500]);

         final widget = Row(
           children: <Widget>[
             Container(
               margin: EdgeInsets.all(16),
               child: icon,
             ),
             Expanded(
               child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Text(
                     building.title,
                     style: TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.w500,
                      )
                     ),
               Text(building.address)
               ],
               ),)
           ],
         );

         return InkWell(
           onTap:() =>listener(position),
            child: widget
         );
      }
}

class BuildingListview extends StatelessWidget{
  List<Building> buildings;
  onItemClickListener listener;
  BuildingListview(this.buildings,this.listener);
   @override
    Widget build(BuildContext context) {
       return ListView.builder(
         itemCount: buildings.length,
         itemBuilder: (context,index){
           return new ItemView(index, buildings[index],listener);

         },
       );
    }
}

class MyApp extends StatelessWidget{
  final buildings =[
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.restaurant, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
    Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
  ];
   @override
    Widget build(BuildContext context) {
       return MaterialApp(
         title: 'Listview demo',
         home: Scaffold(
           appBar: AppBar(
             title: Text('Buildings'),
           ),
           body: BuildingListview(buildings, (index)=>debugPrint('item $index clicked')),
         ),
       );
    }
}

void main(){
  runApp(new MyApp());
}