abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs {
  //shared variables and functions that will be used through any  view model
}
abstract class BaseViewModelInputs{
    void start(); // it will be called when init. of view model;
    void dispose();// will be called to stop this function after an operation
}


abstract class BaseViewModelOutputs{}