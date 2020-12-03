import 'package:bot_toast/bot_toast.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Effect<BotToastState> buildEffect() {
  return combineEffects(<Object, Effect<BotToastState>>{
    BotToastAction.action: _onAction,
  });
}

void _onAction(Action action, Context<BotToastState> ctx) {
  var index = action.payload;
  switch (index) {
    case 0:
      BotToast.showText(text: "Hello Flutter Starter ！");
      break;
    case 1:
      BotToast.showSimpleNotification(title: "Hello Flutter Starter ！");
      break;
    case 2:
      BotToast.showLoading(duration: Duration(seconds: 2));
      break;
    case 3:
      BotToast.showCustomText(
          onlyOne: true,
          crossPage: true,
          clickClose: false,
          ignoreContentClick: false,
          animationDuration: Duration(milliseconds: 200),
          animationReverseDuration: Duration(milliseconds: 200),
          backButtonBehavior: BackButtonBehavior.none,
          toastBuilder: (_) => Align(
                alignment: Alignment(0, 0.8),
                child: Card(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            BotToast.showSimpleNotification(
                                title: "Yes, I do!",
                                crossPage: true,
                                closeIcon: Icon(
                                  Icons.favorite,
                                  color: Colors.redAccent,
                                ),
                                duration: Duration(seconds: 2));
                          }),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text("Do you like flutter starter ? "),
                      ),
                    ],
                  ),
                ),
              ));
      break;
    default:
      break;
  }
}
