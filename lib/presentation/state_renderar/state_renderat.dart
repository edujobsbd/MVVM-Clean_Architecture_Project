import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mvvmproject/data/mapper/mapper.dart';
import 'package:mvvmproject/data/network/faliure.dart';
import 'package:mvvmproject/presentation/resources/assets_manager.dart';
import 'package:mvvmproject/presentation/resources/color_manager.dart';
import 'package:mvvmproject/presentation/resources/phone_manager.dart';
import 'package:mvvmproject/presentation/resources/style_manager.dart';
import 'package:mvvmproject/presentation/resources/value_manager.dart';
import 'package:mvvmproject/presentation/string_manager.dart';

enum StateRenderarType {
  //pop-up state
  popupLoadingState,
  popupErrorState,
  //full screen
  fullScreenLoadingState,
  fullScreenErrorState,
  contentScreenState, //ui for content
  emptyScreenState //empty state for not receiving any data from api
}

class StateRenderar extends StatelessWidget {
  StateRenderarType stateRenderarType;
  String message;
  String title;
  Function? retryActionFunction;

  StateRenderar({
    Key? key,
    required this.stateRenderarType,
    Failure? failure,
    String? message,
    String? title,
    required this.retryActionFunction,
  })  : title = title ?? emptyString,
        message = message ?? AppString.loading,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRenderarType) {
      case StateRenderarType.popupLoadingState:
        return _getPopUpDialogue(
          context,
          [
            _getAnimatedImg(JsonAssets.loading),
          ],
        );
      case StateRenderarType.popupErrorState:
        return _getPopUpDialogue(
          context,
          [
            _getAnimatedImg(JsonAssets.error),
            _getMsg(message),
            _getRetryButton(AppString.tryAgain, context),
          ],
        );
      case StateRenderarType.fullScreenLoadingState:
        return _getItemsInColumn(
          [
            _getAnimatedImg(JsonAssets.loading),
            _getMsg(message),
          ],
        );

      case StateRenderarType.fullScreenErrorState:
        return _getItemsInColumn(
          [
            _getAnimatedImg(JsonAssets.error),
            _getMsg(message),
            _getRetryButton(AppString.ok, context),
          ],
        );

      case StateRenderarType.contentScreenState:
        return Container();
      case StateRenderarType.emptyScreenState:
        return _getItemsInColumn(
          [
            _getAnimatedImg(JsonAssets.empty),
            _getMsg(message),
          ],
        );

      default:
        return Container();
    }
  }

  Widget _getPopUpDialogue(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.as14),
      ),
      elevation: AppSize.as1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(
              AppSize.as14,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: AppSize.as12,
                  offset: Offset(AppSize.as0, AppSize.as12))
            ]),
        child: _getDialogueContent(context, children),
      ),
    );
  }

  _getDialogueContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget _getAnimatedImg(animetionName) {
    return SizedBox(
        height: AppSize.as100,
        width: AppSize.as100,
        child: Lottie.asset(animetionName));
  }

  Widget _getMsg(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(message,
            style:
                getMedium(color: ColorManager.black, fontSize: FontSize.s16)),
      ),
    );
  }

  Widget _getRetryButton(String buttomTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: AppSize.as180,
          child: ElevatedButton(
              onPressed: () {
                if (stateRenderarType ==
                    StateRenderarType.fullScreenErrorState) {
                  retryActionFunction?.call(); // to call api function
                } else {
                  Navigator.of(context).pop(); // to dismiss the pop up state
                }
              },
              child: Text(buttomTitle)),
        ),
      ),
    );
  }

  Widget _getItemsInColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
