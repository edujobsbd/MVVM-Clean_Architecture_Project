import 'dart:async';

import 'package:mvvmproject/domain/model/model.dart';
import 'package:mvvmproject/presentation/base/base_viewmodel.dart';

import '../resources/assets_manager.dart';
import '../string_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  //stream Controller
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    //send data to our view
    _postDataToView();
  }

  @override
  void OnPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  int goNext() {
    // TODO: implement goNext
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) {
      _currentIndex = 0; //infinite loop to go to the first page
    }

    return _currentIndex;
  }

  @override
  int goPrevious() {
    // TODO: implement goPrevious
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex =
          _list.length - 1; //infinite loop to go to the length of list
    }
    return _currentIndex;
  }

  @override
  // TODO: implement inputSliderViewObjects
  Sink get inputSliderViewObjects => _streamController.sink;

  @override
  // TODO: implement ouputSliderViewObjects
  Stream<SliderViewObject> get ouputSliderViewObjects =>
      _streamController.stream.map((SliderViewObject) => SliderViewObject);
  List<SliderObject> _getSliderData() => [
        SliderObject(AppString.onBoardingTitle1, AppString.onBoardingSubTitle1,
            ImageAssets.onboarding_logo1),
        SliderObject(AppString.onBoardingTitle2, AppString.onBoardingSubTitle2,
            ImageAssets.onboarding_logo2),
        SliderObject(AppString.onBoardingTitle3, AppString.onBoardingSubTitle3,
            ImageAssets.onboarding_logo3),
        SliderObject(AppString.onBoardingTitle3, AppString.onBoardingSubTitle3,
            ImageAssets.onboarding_logo3),
      ];

  _postDataToView() {
    inputSliderViewObjects.add(
        SliderViewObject(_list[_currentIndex], _currentIndex, _list.length));
  }
}

//inputs means the requests that will our view model receive from view
abstract class OnBoardingViewModelInputs {
  void goNext(); //when user use the right arrow icon to go next sliders
  void goPrevious(); //when user use the left  arrow icon to go previous sliders
  void OnPageChanged(int index);

  Sink get inputSliderViewObjects; // stream input or data adding mathod
}

//inputs means the requests that will our view model send data to view from our model
abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get ouputSliderViewObjects;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlider;
  int currentIndex;
  SliderViewObject(this.sliderObject, this.currentIndex, this.numOfSlider);
}
