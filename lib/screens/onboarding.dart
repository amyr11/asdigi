import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../components/custom_carousel_item.dart';
import '../models/slide.dart';

List<Slide> slideItems = [
  Slide(
    title: "A Single Point of Access",
    description:
        "for parents to continue their ASD-diagnosed child's development even at home",
    image: Image.asset('assets/images/onBoardLogo.png'),
  ),
  Slide(
    title: "Monitor Multiple Children",
    description:
        "Users can add multiple children and get a personalized experience for each child.",
    image: Image.asset('assets/images/addChild.png'),
  ),
  Slide(
    title: "Developmental Milestones Checklist",
    description:
        "A checklist on different developmental milestones that summarizes the child's development at their age.",
    image: Image.asset('assets/images/milestone.png'),
  ),
  Slide(
    title: "Behavior Dictionary",
    description:
        "Compiles unusual behaviors of children with ASD to better understand and address them.",
    image: Image.asset('assets/images/dict.jpg'),
  ),
  Slide(
    title: "Developmental Resources",
    description:
        "Based on the checklist answered, recommend an activity or resource to make progress on a specific milestone.",
    image: Image.asset('assets/images/devResources.jpg'),
  ),
  Slide(
    title: "Doctors/Therapists Directory",
    description:
        "Provide a list of doctors or therapists on a specific location and expertise.",
    image: Image.asset('assets/images/doctor.jpg'),
  ),
  Slide(
    title: "Unlocking Barriers\nReaching Potential",
    description: "Augmenting Autism Therapy with Digital Technology",
    image: Image.asset('assets/images/onBoardLogo.png'),
  ),
];

final List<Widget> imageSliders = slideItems
    .map((item) => CustomCarouselItem(
          img: item.image,
          title: item.title,
          description: item.description,
        ))
    .toList();

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: CarouselSlider(
              items: imageSliders,
              carouselController: _controller,
              options: CarouselOptions(
                  initialPage: 0,
                  autoPlay: _current == imageSliders.length - 1 ? false : true,
                  aspectRatio: 0.5,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (_current > 0)
                TextButton(
                  onPressed: () {
                    _controller.previousPage();
                  },
                  child: Text(
                    'Previous',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              if (_current < imageSliders.length - 1)
                TextButton(
                  onPressed: () {
                    _controller.nextPage();
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              if (_current == imageSliders.length - 1)
                TextButton(
                  onPressed: () {
                    _controller.nextPage();
                  },
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                  ),
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: slideItems.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
