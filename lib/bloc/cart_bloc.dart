import 'package:flutter_bloc/flutter_bloc.dart';

import '../item.dart';

// enum을 통해 일어날 이벤트 타입 선언
enum CartEventType{
  add,remove
}


class CartEvent {
  final CartEventType type;
  final Item item;

  CartEvent(this.type, this.item);

}

class CartBloc extends Bloc<CartEvent,List<Item>>{
  // CartBloc(super.initialState);
  CartBloc() : super([]){
    on<CartEvent>((event,emit){
      switch(event.type){
        case  CartEventType.add:
          state.add(event.item);
        case CartEventType.remove:
          state.remove(event.item);
      }
      emit(state);
    });
  }

}