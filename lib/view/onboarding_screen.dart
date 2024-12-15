import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/viewmodel/onboarding_viewmodel.dart';

import '../utils/onboardning_component.dart';
import '../utils/sharedpreference.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
  }
  OnboardingViewModelProvider _provider =  OnboardingViewModelProvider();

  @override
  Widget build(BuildContext context) {

    final PageController controller = PageController();
    controller.addListener(() {
      context.read<OnboardingViewModelProvider>().scrollPage(controller.page);
    });
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/app_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            PageView(
              controller: controller,
              children: const [
                OnboardingComponent(
                  image: 'assets/images/Object_1.png',
                  text_1: 'Behavioral Health Service',
                  text_2:
                      'Transforming lives by offering hope and opportunities for recovery, wellness, and independence.',
                ),
                OnboardingComponent(
                  image: 'assets/images/Object_2.png',
                  text_1: 'Mental Health Service',
                  text_2:
                      'If you think that you or someone you know has a mental health problem, there are a number of ways that you can seek advice.',
                ),
                OnboardingComponent(
                  image: 'assets/images/Object_3.png',
                  text_1: 'Get Started',
                  text_2:
                      'Take the first step on your journey to better mental health. Get started today!',
                )
              ],
            ),
            Positioned(
                bottom: 40,
                right: 40,
                child: MaterialButton(
                  onPressed: () async {
                    final SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.setBool('isFresher', false);
                    if (controller.page != 2) {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInOut);
                    }else{
                      _provider.gotoHome(context);
                    }
                  },
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 22,
                    color: Colors.black,
                  ),
                )),
            Positioned(
                bottom: 50,
                left: 150,
                child: Row(
                  children: List.generate(3, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: CircleAvatar(
                        backgroundColor:
                            context.watch<OnboardingViewModelProvider>().page ==
                                    index
                                ? Colors.white
                                : Colors.white.withOpacity(0.2),
                        radius:
                            context.watch<OnboardingViewModelProvider>().page ==
                                    index
                                ? 6
                                : 4,
                      ),
                    );
                  }),
                )),
            Positioned(
                bottom: 50,
                left: 30,
                child: InkWell(
                  onTap: (){
                    _provider.gotoHome(context);
                  },
                  child: SizedBox(
                    width: 40,
                    child: Text('Skip', style: GoogleFonts.poppins(fontSize: 12,color: Colors.white,fontWeight: FontWeight.normal),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
