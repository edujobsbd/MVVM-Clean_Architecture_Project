import 'dart:async';

import 'package:mvvmproject/presentation/state_renderar/state_randerer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs {
  StreamController inputStateStreamController = StreamController();
  @override
  Sink get inputState => inputStateStreamController.sink;

  @override
  Stream<FlowState> get outputState => inputStateStreamController.stream.map((flowState) => flowState);

  
  @override
  void dispose() {
    inputStateStreamController.close();
  }
}
abstract class BaseViewModelInputs{
    void start(); // it will be called when init. of view model;
    void dispose();// will be called to stop this function after an operation

    Sink get inputState;
}


abstract class BaseViewModelOutputs{
  Stream<FlowState> get outputState; 
}