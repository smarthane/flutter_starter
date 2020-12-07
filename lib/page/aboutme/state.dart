import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_starter/global_store/state.dart';

class AboutMeState implements Cloneable<AboutMeState> , GlobalBaseState {
  @override
  AboutMeState clone() {
    return AboutMeState()
      ..store = store;
  }

  @override
  StoreModel store;
}

AboutMeState initState(Map<String, dynamic> args) {
  return AboutMeState();
}
