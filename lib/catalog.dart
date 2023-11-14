import 'package:flutter/material.dart';
import 'package:flutter_basket/bloc/cart_bloc.dart';
import 'package:flutter_basket/item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import 'cart.dart';

class Catalog extends StatefulWidget {
  const Catalog({super.key});

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  List<Item> _itemList = ItemList;

  @override
  Widget build(BuildContext context) {
    final _cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Catalog"),
          actions: [
            IconButton(onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>Cart()));
            }, icon: Icon(Icons.shopping_basket)),
          ],
        ),
        body: BlocProvider(
          create: (BuildContext context) => _cartBloc,
          child: BlocBuilder(
            bloc: _cartBloc,
            builder: (BuildContext context, List state) {
              return ListView(
                children: _itemList
                    .map((item) => _buildItem(item, state, _cartBloc))
                    .toList(),
              );
            },
          ),
        ));
  }

  Widget _buildItem(Item item, List state, CartBloc cartBloc) {
    final ischecked = state.contains(item);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          item.title,
          style: TextStyle(fontSize: 31.0),
        ),
        subtitle: Text(
          "${item.price}",
          style: TextStyle(fontSize: 15),
        ),
        trailing: IconButton(
          icon: ischecked
              ? Icon(
                  Icons.check,
                  color: Colors.red,
                )
              : Icon(Icons.check),
          onPressed: () {
            setState(() {
              if(ischecked){
                context.read<CartBloc>().add(CartEvent(CartEventType.remove,item));
              }else{
                context.read<CartBloc>().add(CartEvent(CartEventType.add,item));
              }
            });

          },
        ),
      ),
    );
  }
}
