import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/global_store/state.dart';

class CityPickersState implements Cloneable<CityPickersState>, GlobalBaseState {

  List<String> itemList;

  @override
  CityPickersState clone() {
    return CityPickersState()
    ..store = store
    ..itemList = itemList;
  }

  @override
  StoreModel store;
}

CityPickersState initState(Map<String, dynamic> args) {
  return CityPickersState()
  ..itemList = ["1.Show City Picker", "2.Show Cities Selector", "3.Show Full Page City Picker"];
}
