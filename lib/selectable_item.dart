import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  String image;
  String name;
  Item({Key? key,required this.name,required this.image}) : super(key: key);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  bool isSelect = false ;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        isSelect = !isSelect;
        print(isSelect);
        setState(() {
        });
      },
      child:Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color:isSelect ? Colors.deepPurple:Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.0))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Image.network(
                 "${widget.image}",
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
             ),
             Text("${widget.name}"),
           ],
        ),
      ),
    );
  }
}

