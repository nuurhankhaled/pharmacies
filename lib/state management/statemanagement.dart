import 'package:flutter_bloc/flutter_bloc.dart';

class MyBloc extends Bloc<MyBlocEvent,MyBlocState > {
  MyBloc() : super(MyBlocState());

  @override
  Stream<MyBlocState> mapEventToState(MyBlocEvent event) async*{
    if(event.type == "clk"){
      yield MyBlocState().reset();
    } else if(event.type == "+"){
      yield MyBlocState().increment(state);
    } else {
      yield MyBlocState().decrement(state);
    }
  }


}
class MyBlocEvent {
  String type = "clk";
  MyBlocEvent(this.type);
}
class MyBlocState {
  int count = 1;

  MyBlocState reset() {
    MyBlocState x = MyBlocState();
    x.count = 1;
    return x;
  }

  MyBlocState increment(MyBlocState c) {

    MyBlocState x = MyBlocState();
    x.count = c.count + 1;
    return x;
  }

  MyBlocState decrement(MyBlocState c) {
    MyBlocState x = MyBlocState();
    x.count = c.count - 1;
    return x;
  }
}