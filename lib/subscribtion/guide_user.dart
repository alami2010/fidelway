import 'dart:ui';

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
          body: Stack(
            children: [
              const _DecorativeBackground(),
              SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeroSection(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionContainer(
                              title: AppLocalizations.of(context)!
                                  .whyChooseFidelway,
                              icon: Icons.check_circle_outline,
                              child: const BenefitsGrid(),
                            ),
                            SectionContainer(
                              title: AppLocalizations.of(context)!.keyFeatures,
                              icon: Icons.smartphone,
                              child: const FeaturesTabView(),
                            ),
                            SectionContainer(
                              title: AppLocalizations.of(context)!
                                  .concreteExamples,
                              icon: Icons.lightbulb_outline,
                              child: const ExamplesCarousel(),
                            ),
                            if (!isAppFree)
                              SectionContainer(
                                title: AppLocalizations.of(context)!
                                    .howMuchDoesItCost,
                                icon: Icons.euro,
                                child: const PricingComparisonWidget(),
                              ),
                            SectionContainer(
                              title: AppLocalizations.of(context)!.howToStart,
                              icon: Icons.rocket_launch,
                              child: const StepsWidget(),
                            ),
                            const SizedBox(height: 12),
                            const CtaPanel(),
                            SectionContainer(
                              title: AppLocalizations.of(context)!
                                  .frequentlyAskedQuestions,
                              icon: Icons.help_outline,
                              child: const FaqExpandableList(),
                            ),
                            const SizedBox(height: 40),
                            Center(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .fidelwayIntelligentSustainableLoyalty,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Hero section with gradient background and floating card
class HeroSection extends StatelessWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2255FF), Color(0xFF4779FF)],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 36, 20, 46),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      loc.discoverFidelway,
                      style: kTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                loc.modernLoyaltySolution,
                style: kTextStyle.copyWith(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.85),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 28),
              _HeroCard(loc: loc),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  final AppLocalizations loc;

  const _HeroCard({required this.loc});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.95),
                  Colors.white.withOpacity(0.85),
                ],
              ),
            ),
          ),
          Positioned(
            top: -50,
            right: -30,
            child: _GlowOrb(
              size: 180,
              color: kMainColor.withOpacity(0.12),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: kMainColor.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          Icons.card_membership,
                          color: kMainColor,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loc.simplifyLoyaltyBoostRevenue,
                              style: kTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              loc.fidelwayDescription,
                              style: const TextStyle(
                                color: Colors.black54,
                                height: 1.45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 16,
                    runSpacing: 12,
                    children: [
                      _HeroStat(
                        icon: Icons.analytics_outlined,
                        value: "+42%",
                        label: loc.significantSavings,
                      ),
                      _HeroStat(
                        icon: Icons.verified_user_outlined,
                        value: "99%",
                        label: loc.increasedReliability,
                      ),
                      _HeroStat(
                        icon: Icons.eco_outlined,
                        value: "0 paper",
                        label: loc.ecologicalSolution,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _HeroStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kMainColor.withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kMainColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: kMainColor, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                width: 140,
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Section Container with consistent styling
class SectionContainer extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final String? description;
  final Widget? trailing;

  const SectionContainer({
    required this.title,
    required this.icon,
    required this.child,
    this.description,
    this.trailing,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 18),
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.white.withOpacity(0.85),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 30,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: -60,
                right: -40,
                child: _GlowOrb(
                  size: 160,
                  color: kMainColor.withOpacity(0.08),
                ),
              ),
              Positioned(
                bottom: -70,
                left: -20,
                child: _GlowOrb(
                  size: 180,
                  color: kMainColor.withOpacity(0.06),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: kMainColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(icon, color: kMainColor, size: 22),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              if (description != null) ...[
                                const SizedBox(height: 6),
                                Text(
                                  description!,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.black54,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        if (trailing != null) trailing!,
                      ],
                    ),
                    const SizedBox(height: 20),
                    child,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Benefits Grid with visual cards
class BenefitsGrid extends StatelessWidget {
  const BenefitsGrid({Key? key}) : super(key: key);

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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.85),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: kMainColor.withOpacity(0.08)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kMainColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, size: 26, color: kMainColor),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Features Tab View
class FeaturesTabView extends StatefulWidget {
  const FeaturesTabView({Key? key}) : super(key: key);

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
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: kMainColor.withOpacity(0.12)),
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: kMainColor,
            indicator: BoxDecoration(
              color: kMainColor,
              borderRadius: BorderRadius.circular(14),
            ),
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            tabs: [
              Tab(text: AppLocalizations.of(context)!.forMerchants),
              Tab(text: AppLocalizations.of(context)!.forCustomers),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 220,
          child: TabBarView(
            controller: _tabController,
            children: [
              FeaturesList(features: [
                FeatureData(
                    Icons.dashboard_customize,
                    AppLocalizations.of(context)!.intuitiveDashboard,
                    AppLocalizations.of(context)!.viewStatsAtGlance),
                FeatureData(
                    Icons.color_lens_outlined,
                    AppLocalizations.of(context)!.totalCustomization,
                    AppLocalizations.of(context)!.adaptProgramsToNeeds),
                FeatureData(
                    Icons.smartphone,
                    AppLocalizations.of(context)!.simplifiedManagement,
                    AppLocalizations.of(context)!.manageFromMobile),
              ]),
              FeaturesList(features: [
                FeatureData(
                    Icons.credit_card,
                    AppLocalizations.of(context)!.digitalCardOrPaperQr,
                    AppLocalizations.of(context)!.chooseYourOption),
                FeatureData(
                    Icons.notifications_active_outlined,
                    AppLocalizations.of(context)!.progressNotifications,
                    AppLocalizations.of(context)!.trackRewardProgress),
                FeatureData(
                    Icons.all_inclusive,
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
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: kMainColor.withOpacity(0.08)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 14,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kMainColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(features[index].icon, color: kMainColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      features[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      features[index].description,
                      style: const TextStyle(
                        color: Colors.black54,
                        height: 1.4,
                      ),
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
  const ExamplesCarousel({Key? key}) : super(key: key);

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
        SizedBox(
          height: 230,
          child: PageView.builder(
            controller: _pageController,
            itemCount: examples.length,
            itemBuilder: (context, index) {
              final isActive = index == _currentPage;
              return AnimatedPadding(
                duration: const Duration(milliseconds: 250),
                padding: EdgeInsets.symmetric(
                    horizontal: isActive ? 4 : 16, vertical: isActive ? 0 : 12),
                child: ExampleCardRedesigned(
                  icon: examples[index].icon,
                  title: examples[index].title,
                  imagePath: examples[index].imagePath,
                  items: examples[index].items,
                  isActive: isActive,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            examples.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              height: 8,
              width: _currentPage == index ? 28 : 10,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? kMainColor
                    : kMainColor.withOpacity(0.25),
                borderRadius: BorderRadius.circular(6),
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
  final bool isActive;

  const ExampleCardRedesigned({
    required this.icon,
    required this.title,
    required this.imagePath,
    required this.items,
    required this.isActive,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isActive
              ? [kMainColor.withOpacity(0.18), Colors.white]
              : [Colors.white, Colors.white],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isActive ? 0.08 : 0.04),
            blurRadius: isActive ? 26 : 14,
            offset: const Offset(0, 14),
          ),
        ],
        border: Border.all(
          color: isActive
              ? kMainColor.withOpacity(0.35)
              : kMainColor.withOpacity(0.1),
          width: isActive ? 1.4 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: kMainColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: kMainColor, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
                const Icon(Icons.swipe, color: Colors.black26, size: 18),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: kMainColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            items[index],
                            style: const TextStyle(
                              fontSize: 14.5,
                              height: 1.4,
                            ),
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
  const PricingComparisonWidget({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isRecommended
                  ? [Colors.white, Colors.green.withOpacity(0.18)]
                  : [Colors.white, color.withOpacity(0.55)],
            ),
            border: Border.all(
              color: isRecommended
                  ? Colors.green.withOpacity(0.55)
                  : kMainColor.withOpacity(0.08),
              width: isRecommended ? 1.6 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 24,
                offset: const Offset(0, 14),
              ),
            ],
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
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      benefits,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  color: isRecommended
                      ? Colors.green
                      : kMainColor.withOpacity(0.65),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  cost,
                  style: const TextStyle(
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
            top: 12,
            right: 18,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                AppLocalizations.of(context)!.recommended,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
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
  const StepsWidget({Key? key}) : super(key: key);

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
        Column(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [kMainColor, kMainColor.withOpacity(0.75)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: kMainColor.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  number.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      kMainColor.withOpacity(0.35),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: isLast ? 0 : 18),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: kMainColor.withOpacity(0.08)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 16,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black54,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// CTA Button
class CtaPanel extends StatelessWidget {
  const CtaPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2B6CFF), Color(0xFF1E4EDD)],
              ),
            ),
          ),
          Positioned(
            top: -80,
            right: -50,
            child: _GlowOrb(
              size: 220,
              color: Colors.white.withOpacity(0.18),
            ),
          ),
          Positioned(
            bottom: -60,
            left: -30,
            child: _GlowOrb(
              size: 180,
              color: Colors.white.withOpacity(0.12),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          loc.fidelwayCallToAction,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(width: 18),
                      const Icon(Icons.rocket_launch, color: Colors.white70),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 16,
                    runSpacing: 12,
                    children: [
                      _CtaHighlight(
                        icon: Icons.auto_graph,
                        label: '3x',
                        description: loc.increasedReliability,
                      ),
                      _CtaHighlight(
                        icon: Icons.savings_outlined,
                        label: '520€',
                        description: loc.saveMoney,
                      ),
                      _CtaHighlight(
                        icon: Icons.eco_outlined,
                        label: loc.ecologicalSolution,
                        description: loc.ecologicalSolution,
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      const CtaButton(),
                      const SizedBox(width: 14),
                      TextButton.icon(
                        onPressed: () =>
                            Utils.showSucces(loc.contactTeam, context: context),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.chat_bubble_outline),
                        label: Text(loc.contactUs),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CtaButton extends StatelessWidget {
  const CtaButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: kMainColor,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
        elevation: 0,
      ),
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.subscribeNow,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.arrow_forward_rounded, size: 20),
        ],
      ),
    );
  }
}

// FAQ Expandable List
class FaqExpandableList extends StatefulWidget {
  const FaqExpandableList({Key? key}) : super(key: key);

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

class _CtaHighlight extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;

  const _CtaHighlight({
    required this.icon,
    required this.label,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                width: 140,
                child: Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowOrb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, Colors.transparent],
        ),
      ),
    );
  }
}

class _DecorativeBackground extends StatelessWidget {
  const _DecorativeBackground();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                kMainColor.withOpacity(0.08),
                Colors.white,
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -140,
                left: -90,
                child: _GlowOrb(
                  size: 260,
                  color: kMainColor.withOpacity(0.14),
                ),
              ),
              Positioned(
                bottom: -160,
                right: -80,
                child: _GlowOrb(
                  size: 300,
                  color: kMainColor.withOpacity(0.1),
                ),
              ),
              Positioned(
                top: 280,
                right: 40,
                child: _GlowOrb(
                  size: 140,
                  color: kMainColor.withOpacity(0.08),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}