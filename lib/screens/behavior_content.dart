import 'package:flutter/material.dart';
import 'package:markdown_viewer/markdown_viewer.dart';

import '../temp/temp_markdown.dart';

class BehaviorContentPage extends StatefulWidget {
  const BehaviorContentPage({
    super.key,
  });

  @override
  State<BehaviorContentPage> createState() => _BehaviorContentPageState();
}

class _BehaviorContentPageState extends State<BehaviorContentPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  late String title;
  late String description;
  late String overViewMarkdown;
  late String howToAddressMarkdown;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);

    title = BehaviorMarkdownData.title;
    description = BehaviorMarkdownData.description;
    overViewMarkdown = BehaviorMarkdownData.overViewMarkdown;
    howToAddressMarkdown = BehaviorMarkdownData.howToAddressMarkdown;
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Behavior Dictionary'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pop(context);
          },
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 300,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://lighthouseautismcenter.com/wp-content/uploads/2022/11/Meltdown-Blog-Feature-Image.jpg',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: Column(
          children: [
            TabBar(
              tabs: const [
                Tab(
                  text: 'Overview',
                ),
                Tab(
                  text: 'How to address',
                )
              ],
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      child: MarkdownViewer(overViewMarkdown),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      child: MarkdownViewer(howToAddressMarkdown),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
