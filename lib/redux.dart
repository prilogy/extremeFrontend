import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';

// class 
class Info {
  int likesCount;

  Info({this.likesCount});
}
enum Actions { Like, UnLike}
Info infoReducer(Info state, dynamic action){

  switch(action){ // switch of Actions enum
    case Actions.Like:
    {
      return Info(likesCount: action.likesCount + 1);
    }
    case Actions.UnLike:
    {
      return Info(likesCount: action.likesCount - 1);
    }
  }

  return state; // If nothing happened, return what was recieved
}