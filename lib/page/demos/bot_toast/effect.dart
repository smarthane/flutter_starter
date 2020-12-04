import 'package:bot_toast/bot_toast.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_starter/page/demos/bot_toast/page.dart';

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

  /// 调用BotToast.showXxx都会返回一个CancelFunc函数,调用此函数将会提前关闭对应的Toast
  switch (index) {
    case 0:

      /// 显示简单的Toast
      BotToast.showText(text: "Hello Flutter Starter ！");
      break;
    case 1:

      /// 显示简单自定义的Toast
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
    case 2:

      /// 显示Loading
      CancelFunc cancelFunc =
          BotToast.showLoading(duration: Duration(seconds: 2));

      /// 关闭调用如下方法
      /// cancelFunc.call();
      break;
    case 3:

      /// 显示自定义Loading
      final TickerProvider tickerProvider =
          ctx.stfState as StateWithTickerProvider;
      AnimationController animationController = AnimationController(
          vsync: tickerProvider, duration: Duration(milliseconds: 300));
      animationController.addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });
      animationController.forward();

      CancelFunc cancelFunc = BotToast.showCustomLoading(
          clickClose: true,
          allowClick: true,
          backButtonBehavior: BackButtonBehavior.none,
          ignoreContentClick: false,
          animationDuration: Duration(milliseconds: 200),
          animationReverseDuration: Duration(milliseconds: 200),
          duration: Duration(
            seconds: 2,
          ),
          backgroundColor: Color(0x42000000),
          align: Alignment.center,
          toastBuilder: (cancelFunc) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FadeTransition(
                      opacity: animationController,
                      child: IconButton(
                        icon: Icon(Icons.favorite,
                            color: Colors.redAccent, size: 30),
                        onPressed: () {
                          BotToast.showCustomText(
                              onlyOne: true,
                              duration: Duration(seconds: 1),
                              toastBuilder: (textCancel) => Align(
                                    alignment: Alignment(0, 0.8),
                                    child: Card(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          IconButton(
                                              icon: Icon(
                                                Icons.favorite,
                                                color: Colors.redAccent,
                                              ),
                                              onPressed: () {
                                                cancelFunc();
                                                textCancel();
                                              }),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text("Me too!!"),
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                      ),
                    ),
                    Text(
                      "I miss you!!",
                    )
                  ],
                ),
              ),
            );
          });
      break;
    case 4:

      /// 显示简单的通知Toast
      BotToast.showSimpleNotification(title: "Hello Flutter Starter ！");
      break;
    case 5:

      /// 显示一个标准的通知Toast
      BotToast.showNotification(
          leading: (cancel) => SizedBox.fromSize(
              size: const Size(40, 40),
              child: IconButton(
                icon: Icon(Icons.favorite, color: Colors.redAccent),
                onPressed: cancel,
              )),
          title: (_) => Text('I love u'),
          subtitle: (_) => Text("let's be together"),
          trailing: (cancel) => IconButton(
                icon: Icon(Icons.cancel),
                onPressed: cancel,
              ),
          onTap: () {
            BotToast.showText(text: 'Tap toast');
          },
          onLongPress: () {
            BotToast.showText(text: 'Long press toast');
          },
          enableSlideOff: true,
          backButtonBehavior: BackButtonBehavior.none,
          crossPage: true,
          contentPadding: EdgeInsets.all(2),
          onlyOne: true,
          animationDuration: Duration(milliseconds: 200),
          animationReverseDuration: Duration(milliseconds: 200),
          duration: Duration(seconds: 2));
      break;
    case 6:

      /// 显示一个自定义的通知Toast
      BotToast.showCustomNotification(
          animationDuration: Duration(milliseconds: 200),
          animationReverseDuration: Duration(milliseconds: 200),
          duration: Duration(seconds: 2),
          backButtonBehavior: BackButtonBehavior.none,
          toastBuilder: (cancel) {
            return Card(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: IconButton(
                        icon: Icon(Icons.favorite),
                        color: ctx.state.flag ? Colors.redAccent : Colors.grey,
                        onPressed: () {
                          ctx.state.flag = !ctx.state.flag;
                          BotToast.showText(
                              onlyOne: true,
                              text: ctx.state.flag
                                  ? "Yes, I love you"
                                  : "No!!!!");
                        }),
                  ),
                  IconButton(
                    icon: Icon(Icons.cancel),
                    color: ctx.state.flag ? Colors.redAccent : Colors.grey,
                    onPressed: cancel,
                  )
                ],
              ),
            );
          },
          enableSlideOff: true,
          onlyOne: true,
          crossPage: true);
      break;
    case 7:

      /// 显示一个定位Toast,该方法可以在某个Widget(一般是Button)或者给定一个offset周围显示
      Offset target;
      double verticalOffset = 0;
      double horizontalOffset = 0;
      int second = 4;
      PreferDirection preferDirection = PreferDirection.topCenter;
      bool ignoreContentClick = false;
      bool onlyOne = true;
      bool allowClick = true;
      bool enableSafeArea = true;
      int backgroundColor = 0x00000000;
      int animationMilliseconds = 200;
      int animationReverseMilliseconds = 200;

      BotToast.showAttachedWidget(
          target: target,
          targetContext: ctx.state.targetContext,
          verticalOffset: verticalOffset,
          horizontalOffset: horizontalOffset,
          duration: Duration(seconds: second),
          animationDuration:
          Duration(milliseconds: animationMilliseconds),
          animationReverseDuration:
          Duration(milliseconds: animationReverseMilliseconds),
          preferDirection: preferDirection,
          ignoreContentClick: ignoreContentClick,
          onlyOne: onlyOne,
          allowClick: allowClick,
          enableSafeArea: enableSafeArea,
          backgroundColor: Color(backgroundColor),
          attachedBuilder: (cancel) => (Card(
            color: Colors.amber,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FlatButton.icon(
                    padding: EdgeInsets.all(5),
                    onPressed: (){
                      BotToast.showSimpleNotification(title: "Let's go travel together.");
                    },
                    label: Text("favorite"),
                    icon: Icon(Icons.favorite,color: Colors.redAccent),
                  ),
                  FlatButton.icon(
                    padding: EdgeInsets.all(5),
                    onPressed: (){
                      BotToast.showSimpleNotification(title: "Thank you for liking me.");
                    },
                    label: Text("bookmark"),
                    icon: Icon(Icons.bookmark,color: Colors.redAccent),
                  )                  ],
              ),
            ),
          )));

      break;
    case 8:

      /// 显示一个使用了Animation的Toast
      BotToast.showAnimationWidget(
          clickClose: false,
          allowClick: false,
          onlyOne: true,
          crossPage: true,
          backButtonBehavior: BackButtonBehavior.none,
          wrapToastAnimation: (controller, cancel, child) => Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  cancel();
                },
                //The DecoratedBox here is very important,he will fill the entire parent component
                child: AnimatedBuilder(
                  builder: (_, child) => Opacity(
                    opacity: controller.value,
                    child: child,
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.black26),
                    child: SizedBox.expand(),
                  ),
                  animation: controller,
                ),
              ),
              CustomOffsetAnimation(
                controller: controller,
                child: child,
              )
            ],
          ),
          toastBuilder: (cancelFunc) => AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            title: const Text('this is custom widget'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  cancelFunc();
                },
                highlightColor: const Color(0x55FF8A80),
                splashColor: const Color(0x99FF8A80),
                child: const Text(
                  'cancel',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
              FlatButton(
                onPressed: () {
                  cancelFunc();
                  //confirm?.call();
                },
                child: const Text('confirm'),
              ),
            ],
          ),
          animationDuration: Duration(milliseconds: 300));
      break;
    case 9:
      /// TODO Custom Animation
      break;
    default:
      break;
  }
}




/// 为了方便 演示
/// 直接View写在 effect里面了
class CustomOffsetAnimation extends StatefulWidget {
  final AnimationController controller;
  final Widget child;

  const CustomOffsetAnimation({Key key, this.controller, this.child})
      : super(key: key);

  @override
  _CustomOffsetAnimationState createState() => _CustomOffsetAnimationState();
}

class _CustomOffsetAnimationState extends State<CustomOffsetAnimation> {
  Tween<Offset> tweenOffset;
  Tween<double> tweenScale;

  Animation<double> animation;

  @override
  void initState() {
    tweenOffset = Tween<Offset>(
      begin: const Offset(0.0, 0.8),
      end: Offset.zero,
    );
    tweenScale = Tween<double>(begin: 0.3, end: 1.0);
    animation =
        CurvedAnimation(parent: widget.controller, curve: Curves.decelerate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      child: widget.child,
      animation: widget.controller,
      builder: (BuildContext context, Widget child) {
        return FractionalTranslation(
            translation: tweenOffset.evaluate(animation),
            child: ClipRect(
              child: Transform.scale(
                scale: tweenScale.evaluate(animation),
                child: Opacity(
                  child: child,
                  opacity: animation.value,
                ),
              ),
            ));
      },
    );
  }
}