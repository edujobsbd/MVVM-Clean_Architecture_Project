import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvmproject/presentation/login/login_viewmodel.dart';
import 'package:mvvmproject/presentation/on_boarding/onBoarding_viewModel.dart';
import 'package:mvvmproject/presentation/resources/assets_manager.dart';
import 'package:mvvmproject/presentation/resources/color_manager.dart';
import 'package:mvvmproject/presentation/resources/value_manager.dart';
import 'package:mvvmproject/presentation/string_manager.dart';

import '../../domain/model/model.dart';
import '../login/log_in.dart';
import '../register/register.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController(initialPage: 0);
  OnBoardingViewModel _viewModel = OnBoardingViewModel();
  _bind(){
    return _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(stream: _viewModel.ouputSliderViewObjects,builder: (context, snapShot){
      return _getContentWidgets(snapShot.data);
    },);
  }

  Widget _getContentWidgets(SliderViewObject? sliderViewObject){
    if(sliderViewObject==null){
      return Container();
    }else {
      return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.as0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: sliderViewObject.numOfSlider,
        onPageChanged: (index) {
          _viewModel.OnPageChanged(index);
        },
        itemBuilder: (context, index) {
          return OnBoardingPage(sliderViewObject.sliderObject);
        },
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        height: AppSize.as100,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  LoginView()),
                  );
                },
                child: Text(
                  AppString.skip,
                  style: Theme.of(context).textTheme.displayLarge,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            _getBottomSheetWidget(sliderViewObject)
          ],
        ),
      ),
    );
    }
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //left arrow
          Padding(
              padding: EdgeInsets.all(AppPadding.p14),
              child: GestureDetector(
                child: SizedBox(
                  height: AppSize.as20,
                  width: AppSize.as20,
                  child: SvgPicture.asset(ImageAssets.leftArrowIc),
                ),
                onTap: () {
                  _pageController.animateToPage(_viewModel.goPrevious(),
                      duration: Duration(milliseconds: DurationConstant.d300),
                      curve: Curves.bounceInOut);
                },
              )),

          //circles indicators
          Row(
            children: [
              for (int i = 0; i < sliderViewObject.numOfSlider; i++)
                Padding(
                  padding: EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i, sliderViewObject.currentIndex),
                )
            ],
          ),

          //right arrow
          Padding(
              padding: EdgeInsets.all(AppPadding.p14),
              child: GestureDetector(
                child: SizedBox(
                  height: AppSize.as20,
                  width: AppSize.as20,
                  child: SvgPicture.asset(ImageAssets.rightArrowIc),
                ),
                onTap: () {
                  _pageController.animateToPage(_viewModel.goNext(),
                      duration: Duration(milliseconds: DurationConstant.d300),
                      curve: Curves.bounceInOut);
                },
              ))
        ],
      ),
    );
  }



  Widget _getProperCircle(int index, int _currentIndex) {
    if (index == _currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc);
    } else {
      return SvgPicture.asset(ImageAssets.solidCircleIc);
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose of viewmodel.dispose()
    _viewModel.dispose();
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  SliderObject _sliderObject;
  OnBoardingPage(this._sliderObject);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: AppSize.as40,
        ),
        Padding(
          padding: EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SizedBox(
          height: AppSize.as60,
        ),
        SvgPicture.asset(_sliderObject.image),
      ],
    );
  }
}


