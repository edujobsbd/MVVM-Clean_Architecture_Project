import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvmproject/data/mapper/mapper.dart';
import 'package:mvvmproject/presentation/state_renderar/state_renderat.dart';

import '../string_manager.dart';

abstract class FlowState {
  StateRenderarType getStateRanderarType();
  String getMessage();
}

//loading state(popup, fullscreen)

class LoadingState extends FlowState {
  StateRenderarType stateRenderarType;
  String message;

  LoadingState({String? message, required this.stateRenderarType})
      : message = message ?? AppString.loading;
  @override
  String getMessage() {
    return message;
  }

  @override
  StateRenderarType getStateRanderarType() {
    return stateRenderarType;
  }
}

//error state(popup, fullscreen)

class ErrorState extends FlowState {
  StateRenderarType stateRenderarType;
  String message;

  ErrorState(this.message, this.stateRenderarType);
  @override
  String getMessage() {
    return message;
  }

  @override
  StateRenderarType getStateRanderarType() {
    return stateRenderarType;
  }
}
//content  state

class ContentState extends FlowState {
  ContentState();
  @override
  String getMessage() {
    return emptyString;
  }

  @override
  StateRenderarType getStateRanderarType() {
    return StateRenderarType.contentScreenState;
  }
}
//error state(popup, fullscreen)

class EmptyState extends FlowState {
  String message;

  EmptyState(
    this.message,
  );
  @override
  String getMessage() {
    return message;
  }

  @override
  StateRenderarType getStateRanderarType() {
    return StateRenderarType.emptyScreenState;
  }
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRanderarType() == StateRenderarType.popupLoadingState) {
            //show popup loading
            showPopUp(context, getStateRanderarType(), getMessage());

            //go to content ui screen
            return contentScreenWidget;
          } else //StateRandererType.fullScreenLoadingState
          {
            return StateRenderar(
              stateRenderarType: getStateRanderarType(),
              retryActionFunction: retryActionFunction,
              message: getMessage(),
            );
          }
        }
      case ErrorState:
        {
          dismissDialogues(context);

          if (getStateRanderarType() == StateRenderarType.popupErrorState) {
            //show popup loading
            showPopUp(context, getStateRanderarType(), getMessage());

            //go to content ui screen
            return contentScreenWidget;
          } else //StateRandererType.fullScreenErrorState
          {
            return StateRenderar(
              stateRenderarType: getStateRanderarType(),
              retryActionFunction: retryActionFunction,
              message: getMessage(),
            );
          }
        }
      case ContentState:
        {
          dismissDialogues(context);
          return contentScreenWidget;
        }
      case EmptyState:
        {
          return StateRenderar(
              stateRenderarType: getStateRanderarType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction);
        }
      default:
        {
          return contentScreenWidget;
        }
    }
  }

  dismissDialogues(BuildContext context) {
    if (_isThereAnyPopupShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isThereAnyPopupShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  showPopUp(BuildContext context, StateRenderarType stateRenderarType,
      String message) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderar(
          stateRenderarType: stateRenderarType,
          message: message,
          retryActionFunction: () {},
        ),
      ),
    );
  }
}
