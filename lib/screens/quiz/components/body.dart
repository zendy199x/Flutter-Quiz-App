import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/screens/quiz/components/progress_bar.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          "assets/icons/bg.svg",
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProgressBar(),
                const SizedBox(height: kDefaultPadding),
                Text.rich(
                  TextSpan(
                    text: "Question 1",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: kSecondaryColor,
                        ),
                    children: [
                      TextSpan(
                        text: "/10",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: kSecondaryColor),
                      ),
                    ],
                  ),
                ),
                const Divider(thickness: 1.5),
                const SizedBox(height: kDefaultPadding),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
