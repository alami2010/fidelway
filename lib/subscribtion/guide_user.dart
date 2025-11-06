import 'package:fidelway/shared/constant.dart';
import 'package:fidelway/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../shared/language_provider.dart';
import '../shared/menu.dart';

class ImprovedLoyaltyScreen extends StatelessWidget {
  const ImprovedLoyaltyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Scaffold(
          drawer: MyDrawer(),
      appBar: Utils.buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero section with gradient background
            HeroSection(),

            // Main content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Why Choose Section with visual cards
                  SectionContainer(
                        title: AppLocalizations.of(context)!.whyChooseFidelway,
                        icon: Icons.check_circle_outline,
                    child: BenefitsGrid(),
                  ),

                  // Features Section with tabs
                  SectionContainer(
                        title: AppLocalizations.of(context)!.keyFeatures,
                        icon: Icons.smartphone,
                    child: FeaturesTabView(),
                  ),

                  // Examples Section with carousel
                  SectionContainer(
                        title: AppLocalizations.of(context)!.concreteExamples,
                        icon: Icons.lightbulb_outline,
                    child: ExamplesCarousel(),
                  ),

                  // Pricing Comparison with visual elements
                  SectionContainer(
                        title: AppLocalizations.of(context)!.howMuchDoesItCost,
                        icon: Icons.euro,
                    child: PricingComparisonWidget(),
                  ),

                  // How to Start Section with step indicators
                  SectionContainer(
                        title: AppLocalizations.of(context)!.howToStart,
                        icon: Icons.rocket_launch,
                    child: StepsWidget(),
                  ),

                  // CTA Button
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: CtaButton(),
                  ),

                  // FAQ Section with expandable items
                  SectionContainer(
                        title: AppLocalizations.of(context)!
                            .frequentlyAskedQuestions,
                        icon: Icons.help_outline,
                    child: FaqExpandableList(),
                  ),

                  // Footer
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Text(
                            AppLocalizations.of(context)!
                                .fidelwayIntelligentSustainableLoyalty,
                            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
      },
    );
  }
}

// Hero section with gradient background and floating card
class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kMainColor, kMainColor.withOpacity(0.8)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.discoverFidelway,
                style: kTextStyle.copyWith(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              16.height,
              Text(
                AppLocalizations.of(context)!.modernLoyaltySolution,
                style: kTextStyle.copyWith(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              32.height,
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.card_giftcard,
                      size: 48,
                      color: kMainColor,
                    ),
                    16.height,
                    Text(
                      AppLocalizations.of(context)!.simplifyLoyaltyBoostRevenue,
                      style: kTextStyle.copyWith(
                        fontSize: 16,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              32.height,
            ],
          ),
        ),
      ),
    );
  }
}

// Section Container with consistent styling
class SectionContainer extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const SectionContainer({
    required this.title,
    required this.icon,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: kMainColor, size: 24),
              12.width,
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          Divider(height: 24, thickness: 1, color: Colors.grey.withOpacity(0.2)),
          child,
        ],
      ),
    );
  }
}

// Benefits Grid with visual cards
class BenefitsGrid extends StatelessWidget {
  List<BenefitData> getBenefits(BuildContext context) {
    return [
      BenefitData(Icons.eco, AppLocalizations.of(context)!.ecological,
          AppLocalizations.of(context)!.noPaperWaste),
      BenefitData(Icons.attach_money, AppLocalizations.of(context)!.economical,
          AppLocalizations.of(context)!.upTo42Savings),
      BenefitData(Icons.settings, AppLocalizations.of(context)!.flexible,
          AppLocalizations.of(context)!.customizablePrograms),
      BenefitData(Icons.security, AppLocalizations.of(context)!.reliable,
          AppLocalizations.of(context)!.uniqueSecureQrCodes),
      BenefitData(Icons.phone_iphone, AppLocalizations.of(context)!.modern,
          AppLocalizations.of(context)!.digitalCustomerExperience),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final benefits = getBenefits(context);
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: benefits.length,
      itemBuilder: (context, index) {
        return BenefitCard(
          icon: benefits[index].icon,
          title: benefits[index].title,
          subtitle: benefits[index].subtitle,
        );
      },
    );
  }
}

class BenefitData {
  final IconData icon;
  final String title;
  final String subtitle;

  BenefitData(this.icon, this.title, this.subtitle);
}

class BenefitCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const BenefitCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 28, color: kMainColor),
              8.height,
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              4.height,
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Features Tab View
class FeaturesTabView extends StatefulWidget {
  @override
  _FeaturesTabViewState createState() => _FeaturesTabViewState();
}

class _FeaturesTabViewState extends State<FeaturesTabView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: kMainColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: kMainColor,
          tabs: [
            Tab(text: AppLocalizations.of(context)!.forMerchants),
            Tab(text: AppLocalizations.of(context)!.forCustomers),
          ],
        ),
        16.height,
        Container(
          height: 180,
          child: TabBarView(
            controller: _tabController,
            children: [
              // Merchants Features
              FeaturesList(features: [
                FeatureData(
                    Icons.dashboard,
                    AppLocalizations.of(context)!.intuitiveDashboard,
                    AppLocalizations.of(context)!.viewStatsAtGlance),
                FeatureData(
                    Icons.brush,
                    AppLocalizations.of(context)!.totalCustomization,
                    AppLocalizations.of(context)!.adaptProgramsToNeeds),
                FeatureData(
                    Icons.phone_android,
                    AppLocalizations.of(context)!.simplifiedManagement,
                    AppLocalizations.of(context)!.manageFromMobile),
              ]),

              // Customers Features
              FeaturesList(features: [
                FeatureData(
                    Icons.credit_card,
                    AppLocalizations.of(context)!.digitalCardOrPaperQr,
                    AppLocalizations.of(context)!.chooseYourOption),
                FeatureData(
                    Icons.notifications,
                    AppLocalizations.of(context)!.progressNotifications,
                    AppLocalizations.of(context)!.trackRewardProgress),
                FeatureData(
                    Icons.loop,
                    AppLocalizations.of(context)!.reusableForLife,
                    AppLocalizations.of(context)!.oneCardForAllVisits),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}

class FeatureData {
  final IconData icon;
  final String title;
  final String description;

  FeatureData(this.icon, this.title, this.description);
}

class FeaturesList extends StatelessWidget {
  final List<FeatureData> features;

  const FeaturesList({required this.features, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: features.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kMainColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(features[index].icon, color: kMainColor, size: 20),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      features[index].title,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    4.height,
                    Text(
                      features[index].description,
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Examples Carousel
class ExamplesCarousel extends StatefulWidget {
  @override
  _ExamplesCarouselState createState() => _ExamplesCarouselState();
}

class _ExamplesCarouselState extends State<ExamplesCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  List<ExampleData> getExamples(BuildContext context) {
    return [
      ExampleData(
        Icons.local_pizza,
        AppLocalizations.of(context)!.pizzeria,
        'assets/pizza_icon.png',
        [
          AppLocalizations.of(context)!.tenOrdersOneDrink,
          AppLocalizations.of(context)!.fifteenOrdersOneJuniorPizza,
          AppLocalizations.of(context)!.twentyOrdersOneSeniorPizza,
        ],
      ),
      ExampleData(
        Icons.cut,
        AppLocalizations.of(context)!.hairdressingSalon,
        'assets/salon_icon.png',
        [
          AppLocalizations.of(context)!.fiveVisitsOneFreeTreatment,
          AppLocalizations.of(context)!.tenVisitsTwentyPercentDiscount,
        ],
      ),
      ExampleData(
        Icons.coffee,
        AppLocalizations.of(context)!.cafe,
        'assets/cafe_icon.png',
        [
          AppLocalizations.of(context)!.eightCoffeesOneFreeCoffee,
          AppLocalizations.of(context)!.fifteenCoffeesOnePastry,
        ],
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final examples = [
      ExampleData(
        Icons.local_pizza,
        AppLocalizations.of(context)!.pizzeria,
        'assets/pizza_icon.png',
        [
          AppLocalizations.of(context)!.tenOrdersOneDrink,
          AppLocalizations.of(context)!.fifteenOrdersOneJuniorPizza,
          AppLocalizations.of(context)!.twentyOrdersOneSeniorPizza,
        ],
      ),
      ExampleData(
        Icons.cut,
        AppLocalizations.of(context)!.hairdressingSalon,
        'assets/salon_icon.png',
        [
          AppLocalizations.of(context)!.fiveVisitsOneFreeTreatment,
          AppLocalizations.of(context)!.tenVisitsTwentyPercentDiscount,
        ],
      ),
      ExampleData(
        Icons.coffee,
        AppLocalizations.of(context)!.cafe,
        'assets/cafe_icon.png',
        [
          AppLocalizations.of(context)!.eightCoffeesOneFreeCoffee,
          AppLocalizations.of(context)!.fifteenCoffeesOnePastry,
        ],
      ),
    ];

    return Column(
      children: [
        Container(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: examples.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 8),
                child: ExampleCardRedesigned(
                  icon: examples[index].icon,
                  title: examples[index].title,
                  imagePath: examples[index].imagePath,
                  items: examples[index].items,
                ),
              );
            },
          ),
        ),
        16.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            examples.length,
            (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index ? kMainColor : Colors.grey.withOpacity(0.3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ExampleData {
  final IconData icon;
  final String title;
  final String imagePath;
  final List<String> items;

  ExampleData(this.icon, this.title, this.imagePath, this.items);
}

class ExampleCardRedesigned extends StatelessWidget {
  final IconData icon;
  final String title;
  final String imagePath;
  final List<String> items;

  const ExampleCardRedesigned({
    required this.icon,
    required this.title,
    required this.imagePath,
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kMainColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: kMainColor, size: 24),
                ),
                12.width,
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            Divider(height: 24),
            Expanded(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_right, color: kMainColor, size: 20),
                        8.width,
                        Expanded(
                          child: Text(
                            items[index],
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Pricing Comparison Widget
class PricingComparisonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.saveHundredsEurosPerMonth,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        16.height,
        PricingOptionCard(
          title: AppLocalizations.of(context)!.classicPaperCards,
          cost: AppLocalizations.of(context)!.fiftyEuros,
          benefits: AppLocalizations.of(context)!.expensiveNotPractical,
          isRecommended: false,
          color: Colors.grey.shade200,
        ),
        12.height,
        PricingOptionCard(
          title: AppLocalizations.of(context)!.fidelwayHybrid,
          cost: AppLocalizations.of(context)!.fortyEuros,
          benefits: AppLocalizations.of(context)!.economicalPlusPhysicalQr,
          isRecommended: false,
          color: Colors.blue.shade50,
        ),
        12.height,
        PricingOptionCard(
          title: AppLocalizations.of(context)!.fidelway100Digital,
          cost: AppLocalizations.of(context)!.nine99Euros,
          benefits: AppLocalizations.of(context)!.mostAdvantageousSolution,
          isRecommended: true,
          color: Colors.green.shade50,
        ),
        16.height,
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: kMainColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.savings, color: Colors.green),
              12.width,
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!
                      .choosingDigitalSaves220EurosPerYear,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PricingOptionCard extends StatelessWidget {
  final String title;
  final String cost;
  final String benefits;
  final bool isRecommended;
  final Color color;

  const PricingOptionCard({
    required this.title,
    required this.cost,
    required this.benefits,
    required this.isRecommended,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            border: isRecommended ? Border.all(color: Colors.green, width: 2) : Border.all(color: Colors.transparent),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    8.height,
                    Text(
                      benefits,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isRecommended ? Colors.green : Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  cost,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isRecommended)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.recommended,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// Steps Widget
class StepsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final steps = [
      StepData(AppLocalizations.of(context)!.downloadApp,
          AppLocalizations.of(context)!.availableOnAppStoreAndGooglePlay),
      StepData(AppLocalizations.of(context)!.createMerchantAccount,
          AppLocalizations.of(context)!.simpleAndQuickInMinutes),
      StepData(AppLocalizations.of(context)!.configureYourProgram,
          AppLocalizations.of(context)!.defineYourLoyaltyRules),
      StepData(AppLocalizations.of(context)!.communicateToYourClients,
          AppLocalizations.of(context)!.useIntegratedMarketingTools),
    ];

    return Container(
      child: Column(
        children: List.generate(
          steps.length,
          (index) => StepItemRedesigned(
            number: index + 1,
            title: steps[index].title,
            subtitle: steps[index].subtitle,
            isLast: index == steps.length - 1,
          ),
        ),
      ),
    );
  }
}

class StepData {
  final String title;
  final String subtitle;

  StepData(this.title, this.subtitle);
}

class StepItemRedesigned extends StatelessWidget {
  final int number;
  final String title;
  final String subtitle;
  final bool isLast;

  const StepItemRedesigned({
    required this.number,
    required this.title,
    required this.subtitle,
    this.isLast = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Number circle
        Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kMainColor,
              ),
              child: Center(
                child: Text(
                  number.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            // Connector line
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: Colors.grey.withOpacity(0.3),
              ),
          ],
        ),
        12.width,
        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              4.height,
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              if (!isLast) 20.height,
            ],
          ),
        ),
      ],
    );
  }
}

// CTA Button
class CtaButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: kMainColor,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 5,
      ),
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.subscribeNow,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          12.width,
          Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}

// FAQ Expandable List
class FaqExpandableList extends StatefulWidget {
  @override
  _FaqExpandableListState createState() => _FaqExpandableListState();
}

class _FaqExpandableListState extends State<FaqExpandableList> {
  List<FaqItemData> getFaqItems(BuildContext context) {
    return [
      FaqItemData(
        AppLocalizations.of(context)!.customerLosesPaperCard,
        AppLocalizations.of(context)!.canEasilyRetrieveViaApp,
      ),
      FaqItemData(
        AppLocalizations.of(context)!.modifiableAtAnyTime,
        AppLocalizations.of(context)!.yesCanAdjustRulesFromDashboard,
      ),
      FaqItemData(
        AppLocalizations.of(context)!.isItSecure,
        AppLocalizations.of(context)!.absolutelyUniqueQrCodes,
      ),
      FaqItemData(
        AppLocalizations.of(context)!.canIPersonalizeAppearance,
        AppLocalizations.of(context)!.ofCourseCanAdaptColors,
      ),
    ];
  }

  List<bool> _expandedList = [];

  @override
  void initState() {
    super.initState();
    _expandedList = [];
  }

  @override
  Widget build(BuildContext context) {
    final faqItems = getFaqItems(context);
    if (_expandedList.length != faqItems.length) {
      _expandedList = List.generate(faqItems.length, (index) => false);
    }

    return Column(
      children: List.generate(
        faqItems.length,
        (index) => FaqItemRedesigned(
          question: faqItems[index].question,
          answer: faqItems[index].answer,
          isExpanded: _expandedList[index],
          onTap: () {
            setState(() {
              _expandedList[index] = !_expandedList[index];
            });
          },
        ),
      ),
    );
  }
}

class FaqItemData {
  final String question;
  final String answer;

  FaqItemData(this.question, this.answer);
}

class FaqItemRedesigned extends StatelessWidget {
  final String question;
  final String answer;
  final bool isExpanded;
  final VoidCallback onTap;

  const FaqItemRedesigned({
    required this.question,
    required this.answer,
    required this.isExpanded,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      question,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.remove : Icons.add,
                    color: kMainColor,
                  ),
                ],
              ),
              if (isExpanded) ...[
                Divider(height: 24),
                Text(
                  answer,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}