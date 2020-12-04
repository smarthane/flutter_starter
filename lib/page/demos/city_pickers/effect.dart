import 'package:bot_toast/bot_toast.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';
import 'package:city_pickers/city_pickers.dart';

Effect<CityPickersState> buildEffect() {
  return combineEffects(<Object, Effect<CityPickersState>>{
    CityPickersAction.action: _onAction,
  });
}

void _onAction(Action action, Context<CityPickersState> ctx) async {
  var index = action.payload;
  switch (index) {
    case 0:
      Result result = await CityPickers.showCityPicker(context: ctx.context);
      BotToast.showText(text: result.toString());
      break;
    case 1:
      Result result = await CityPickers.showCitiesSelector(context: ctx.context);
      BotToast.showText(text: result.toString());
      break;
    case 2:
      Result result = await CityPickers.showFullPageCityPicker(context: ctx.context);
      BotToast.showText(text: result.toString());
      break;
    default:
      break;
  }
}
