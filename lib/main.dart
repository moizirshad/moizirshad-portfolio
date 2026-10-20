import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data/projects.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});
  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode mode = ThemeMode.dark;
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Moiz Irshad — Mobile Engineering Lead',
        debugShowCheckedModeBanner: false,
        themeMode: mode,
        theme: _theme(Brightness.light),
        darkTheme: _theme(Brightness.dark),
        home: PortfolioHome(
            onTheme: () => setState(() => mode =
                mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark)),
        onGenerateRoute: (settings) {
          if (settings.name?.startsWith('/case/') ?? false) {
            final key = settings.name!.substring(6);
            final matches = projects.where((p) => p.id == key);
            final project = matches.isEmpty ? null : matches.first;
            if (project != null)
              return MaterialPageRoute<void>(
                  builder: (_) => CaseStudyPage(project: project));
          }
          return null;
        },
      );

  ThemeData _theme(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    const accent = Color(0xFFC7F36B);
    final scheme = ColorScheme.fromSeed(
        seedColor: accent,
        brightness: brightness,
        surface: dark ? const Color(0xFF111310) : const Color(0xFFF7F8F4));
    return ThemeData(
        colorScheme: scheme,
        brightness: brightness,
        useMaterial3: true,
        scaffoldBackgroundColor:
            dark ? const Color(0xFF111310) : const Color(0xFFF7F8F4),
        fontFamily: 'Arial',
        textTheme: ThemeData(brightness: brightness).textTheme.apply(
            bodyColor: dark ? const Color(0xFFE9EAE4) : const Color(0xFF1D2119),
            displayColor:
                dark ? const Color(0xFFE9EAE4) : const Color(0xFF1D2119)),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent, elevation: 0),
        dividerColor: dark ? const Color(0xFF30342C) : const Color(0xFFE1E4DB));
  }
}

const filters = [
  'All work',
  'Native iOS',
  'Native Android',
  'Flutter',
  'React Native',
  'Backend & APIs',
  'Leadership'
];

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key, required this.onTheme});
  final VoidCallback onTheme;
  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  String selected = 'All work';
  final projectsKey = GlobalKey();
  final experienceKey = GlobalKey();
  final aboutKey = GlobalKey();
  List<Project> get visible => projects.where((p) {
        if (selected == 'All work') return true;
        if (selected == 'Native Android')
          return p.platforms.any((s) => s.toLowerCase().contains('android'));
        if (selected == 'Native iOS')
          return p.platforms.any((s) => s.toLowerCase().contains('ios'));
        if (selected == 'Flutter')
          return p.platforms.any((s) => s.toLowerCase().contains('flutter')) ||
              p.stack.any((s) => s.toLowerCase() == 'flutter');
        if (selected == 'Backend & APIs')
          return p.stack.any((s) => [
                'rest',
                'rest apis',
                'websockets',
                'stripe'
              ].contains(s.toLowerCase()));
        if (selected == 'React Native')
          return false; // no verified production case study yet
        if (selected == 'Leadership') return p.type == 'Leadership';
        return p.type == selected;
      }).toList();

  void scrollTo(GlobalKey key) => Scrollable.ensureVisible(key.currentContext!,
      duration: MediaQuery.of(context).disableAnimations
          ? Duration.zero
          : const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic);

  @override
  Widget build(BuildContext context) =>
      Scaffold(body: LayoutBuilder(builder: (context, constraints) {
        final wide = constraints.maxWidth >= 880;
        return CustomScrollView(slivers: [
          SliverToBoxAdapter(child: _nav(context, wide)),
          SliverToBoxAdapter(child: _hero(context, wide)),
          SliverToBoxAdapter(child: _proofStrip(context)),
          SliverToBoxAdapter(
              key: projectsKey,
              child: _section(
                  context,
                  'SELECTED WORK',
                  'Products built for real people.',
                  'A cross-platform body of work spanning consumer apps, mobility, marketplaces and engineering leadership.')),
          SliverToBoxAdapter(child: _filters(context)),
          if (visible.isEmpty)
            SliverToBoxAdapter(
                child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                        child: Text(
                            'No verified projects are listed for $selected yet.'))))
          else
            SliverPadding(
                padding: EdgeInsets.symmetric(
                    horizontal: wide ? 64 : 22, vertical: 12),
                sliver: SliverLayoutBuilder(builder: (context, geometry) {
                  final cross = geometry.crossAxisExtent > 860
                      ? 3
                      : geometry.crossAxisExtent > 560
                          ? 2
                          : 1;
                  return SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) =>
                              _projectCard(context, visible[index]),
                          childCount: visible.length),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: cross,
                          mainAxisSpacing: 18,
                          crossAxisSpacing: 18,
                          childAspectRatio: cross == 1 ? 1.12 : .83));
                })),
          SliverToBoxAdapter(child: _architecture(context, wide)),
          SliverToBoxAdapter(
              key: experienceKey, child: _experience(context, wide)),
          SliverToBoxAdapter(child: _profileDetails(context, wide)),
          SliverToBoxAdapter(child: _expertise(context, wide)),
          SliverToBoxAdapter(child: _publicCode(context, wide)),
          SliverToBoxAdapter(key: aboutKey, child: _about(context, wide)),
          SliverToBoxAdapter(child: _contact(context, wide)),
          SliverToBoxAdapter(child: _footer(context)),
        ]);
      }));

  Widget _nav(BuildContext c, bool wide) => Padding(
      padding: EdgeInsets.fromLTRB(wide ? 64 : 22, 24, wide ? 64 : 22, 10),
      child: Row(children: [
        Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
                color: Theme.of(c).colorScheme.primary,
                borderRadius: BorderRadius.circular(12)),
            child: Center(
                child: Text('MI',
                    style: TextStyle(
                        color: Theme.of(c).scaffoldBackgroundColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 13)))),
        const SizedBox(width: 12),
        Text('MOIZ IRSHAD',
            style: Theme.of(c)
                .textTheme
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.w800, letterSpacing: 1.2)),
        const Spacer(),
        if (wide) ...[
          _navLink(c, 'Work', projectsKey),
          _navLink(c, 'Experience', experienceKey),
          _navLink(c, 'About', aboutKey),
          const SizedBox(width: 16)
        ],
        IconButton(
            tooltip: 'View my LinkedIn profile',
            onPressed: () => _launch('https://www.linkedin.com/in/moizirshad/'),
            icon: const Icon(Icons.person_outline)),
        IconButton(
            tooltip: 'Toggle color theme',
            onPressed: widget.onTheme,
            icon: const Icon(Icons.light_mode_outlined)),
        if (wide)
          OutlinedButton.icon(
              onPressed: () => _email(),
              icon: const Icon(Icons.arrow_outward, size: 16),
              label: const Text('Get in touch'))
      ]));
  Widget _navLink(BuildContext c, String text, GlobalKey key) =>
      TextButton(onPressed: () => scrollTo(key), child: Text(text));

  Widget _hero(BuildContext c, bool wide) => Padding(
      padding: EdgeInsets.fromLTRB(
          wide ? 64 : 22, wide ? 74 : 42, wide ? 64 : 22, 55),
      child: wide
          ? Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(flex: 11, child: _heroCopy(c, wide)),
              const SizedBox(width: 42),
              const Expanded(flex: 9, child: _HeroArtwork()),
            ])
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _heroCopy(c, wide),
              const SizedBox(height: 25),
              const _HeroArtwork()
            ]));

  Widget _heroCopy(BuildContext c, bool wide) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      color: Theme.of(c).colorScheme.primary,
                      shape: BoxShape.circle)),
              const SizedBox(width: 10),
              Text('MOBILE ENGINEERING LEAD  ·  DUBAI, UAE',
                  style: Theme.of(c).textTheme.labelSmall?.copyWith(
                      letterSpacing: 1.5, fontWeight: FontWeight.w700))
            ]),
            const SizedBox(height: 26),
            Text('Leading mobile\nengineering.\nBuilding products\nthat scale.',
                style: Theme.of(c).textTheme.displayLarge?.copyWith(
                    fontSize: wide ? 68 : 48,
                    height: .99,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -2.6)),
            const SizedBox(height: 22),
            ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 590),
                child: Text(
                    '12+ years building mobile products from idea to production across native iOS, Android and Flutter. I turn complex product needs into clear experiences, make architecture decisions and lead delivery.',
                    style: Theme.of(c).textTheme.titleMedium?.copyWith(
                        height: 1.65,
                        color: Theme.of(c)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: .72)))),
            const SizedBox(height: 28),
            Wrap(spacing: 12, runSpacing: 12, children: [
              FilledButton.icon(
                  onPressed: () => scrollTo(projectsKey),
                  icon: const Icon(Icons.arrow_downward, size: 17),
                  label: const Text('Explore my work')),
              OutlinedButton.icon(
                  onPressed: _email,
                  icon: const Icon(Icons.mail_outline, size: 17),
                  label: const Text("Let's connect")),
              OutlinedButton.icon(
                  onPressed: _cv,
                  icon: const Icon(Icons.download_outlined, size: 17),
                  label: const Text('Download CV'))
            ]),
            const SizedBox(height: 22),
            Text(
                'iOS  ·  ANDROID  ·  FLUTTER  ·  REACT NATIVE  ·  API INTEGRATION  ·  TECHNICAL LEADERSHIP',
                style: Theme.of(c).textTheme.labelSmall?.copyWith(
                    letterSpacing: .55,
                    color: Theme.of(c)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: .55)))
          ]);

  Widget _proofStrip(BuildContext c) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 22),
      padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 25),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(c).dividerColor),
          borderRadius: BorderRadius.circular(18)),
      child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: 30,
          runSpacing: 20,
          children: const [
            _Proof('12+', 'years in mobile'),
            _Proof('4', 'mobile platforms'),
            _Proof('9', 'engineers led'),
            _Proof('40%', 'faster cross-platform feature delivery')
          ]));
  Widget _section(BuildContext c, String eyebrow, String title, String body) =>
      Padding(
          padding: const EdgeInsets.fromLTRB(22, 90, 22, 27),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(eyebrow,
                style: Theme.of(c).textTheme.labelSmall?.copyWith(
                    letterSpacing: 2,
                    color: Theme.of(c).colorScheme.primary,
                    fontWeight: FontWeight.w800)),
            const SizedBox(height: 14),
            Text(title,
                style: Theme.of(c).textTheme.headlineMedium?.copyWith(
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1)),
            const SizedBox(height: 10),
            ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: Text(body,
                    style: Theme.of(c).textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                        color: Theme.of(c)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: .7))))
          ]));
  Widget _filters(BuildContext c) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: filters
              .map((f) => ChoiceChip(
                  label: Text(f),
                  selected: selected == f,
                  onSelected: (_) => setState(() => selected = f)))
              .toList()));
  Widget _projectCard(BuildContext c, Project p) => InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () => Navigator.of(c).pushNamed('/case/${p.id}'),
      child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: Theme.of(c).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Theme.of(c).dividerColor)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                child: Container(
                    width: double.infinity,
                    color: p.color.withValues(alpha: .12),
                    child: Stack(children: [
                      Positioned(top: 18, left: 20, child: _Badge(p.type)),
                      Positioned(
                          right: 22,
                          bottom: 16,
                          child: _ProductArt(project: p)),
                      Positioned(
                          left: 20,
                          bottom: 23,
                          right: 148,
                          child: Text(p.platforms.join('  /  ').toUpperCase(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: p.color,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 11,
                                  letterSpacing: 1.3)))
                    ]))),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(c)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Text(p.period,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(c).textTheme.labelSmall),
                      const SizedBox(height: 9),
                      Text(p.summary,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(c).textTheme.bodyMedium?.copyWith(
                              height: 1.5,
                              color: Theme.of(c)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: .72))),
                      const SizedBox(height: 14),
                      Row(children: [
                        Text('View case study',
                            style: Theme.of(c).textTheme.labelLarge?.copyWith(
                                color: Theme.of(c).colorScheme.primary)),
                        const SizedBox(width: 6),
                        Icon(Icons.arrow_outward,
                            size: 15, color: Theme.of(c).colorScheme.primary)
                      ])
                    ]))
          ])));

  Widget _architecture(BuildContext c, bool wide) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _section(
            c,
            'THE SYSTEM BEHIND THE APP',
            'Mobile is one part of the product.',
            'I connect client-side decisions with the services and delivery systems around them. My verified backend work is API integration and product collaboration; I do not claim backend ownership where the records do not support it.'),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: wide ? 64 : 22),
            child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Theme.of(c).colorScheme.surfaceContainer,
                    border: Border.all(color: Theme.of(c).dividerColor)),
                child: wide
                    ? const Row(children: [
                        _ArchitectureNode(
                            '01', 'Mobile clients', 'iOS · Android · Flutter',
                            horizontal: true),
                        _Arrow(),
                        _ArchitectureNode(
                            '02', 'API contracts', 'REST · GraphQL · realtime',
                            horizontal: true),
                        _Arrow(),
                        _ArchitectureNode('03', 'Identity & services',
                            'OAuth · JWT · payments',
                            horizontal: true),
                        _Arrow(),
                        _ArchitectureNode('04', 'Data & operations',
                            'Firebase · monitoring · CI/CD',
                            horizontal: true)
                      ])
                    : const Column(children: [
                        _ArchitectureNode(
                            '01', 'Mobile clients', 'iOS · Android · Flutter'),
                        _DownArrow(),
                        _ArchitectureNode(
                            '02', 'API contracts', 'REST · GraphQL · realtime'),
                        _DownArrow(),
                        _ArchitectureNode('03', 'Identity & services',
                            'OAuth · JWT · payments'),
                        _DownArrow(),
                        _ArchitectureNode('04', 'Data & operations',
                            'Firebase · monitoring · CI/CD')
                      ])))
      ]);

  Widget _experience(BuildContext c, bool wide) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _section(c, 'EXPERIENCE', 'A career built across platforms.',
            'Roles and dates follow the CV record. Several roles overlapped; the timeline preserves that context instead of implying a single uninterrupted sequence.'),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: wide ? 64 : 22),
            child: Column(children: const [
              _ExperienceItem(
                  'Mar 2026 — Present',
                  'Senior Flutter Mobile Application Developer',
                  'FITT Meals',
                  'Built iOS and Android apps from scratch as the sole Flutter developer. Integrated payments, analytics, crash reporting, caching and release automation.'),
              _ExperienceItem(
                  'Apr 2021 — Mar 2026',
                  'Senior Software Engineer · iOS, Android & Flutter',
                  'DubiCars',
                  'Worked across Native iOS, Native Android and Flutter. Improved app startup and memory performance, shortened release workflows, and received the Dubi Hero of the Month award in February 2025.'),
              _ExperienceItem(
                  'May 2022 — Mar 2023',
                  'Senior iOS Developer',
                  'Bykea',
                  'Sole iOS engineer working on real-time mobility, location, matching and payment experiences.'),
              _ExperienceItem(
                  'Oct 2017 — May 2022',
                  'Mobile Development Lead',
                  'Danat FZ LLC',
                  'Led a nine-person mobile and QA team; owned technical standards, reviews, delivery planning and client architecture.'),
              _ExperienceItem(
                  'Feb 2016 — Oct 2017',
                  'Mobile Development Engineer',
                  'Danat FZ LLC',
                  'Built client applications and developed into a technical lead role.'),
              _ExperienceItem(
                  'Dec 2014 — Jan 2016',
                  'iOS Developer',
                  'Innovative Solutions',
                  'Native iOS application development.'),
              _ExperienceItem(
                  'Aug 2014 — Nov 2014',
                  'Junior iOS Developer',
                  'SysTellex Inc.',
                  'Started a career in mobile application engineering.'),
            ]))
      ]);

  Widget _profileDetails(BuildContext c, bool wide) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _section(c, 'PROFILE DETAILS', 'Education, learning and languages.',
            'Additional details listed on my LinkedIn profile.'),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: wide ? 64 : 22),
            child: Wrap(spacing: 12, runSpacing: 12, children: const [
              _Principle('EDUCATION', 'University of Karachi',
                  '2015–2016 · Major subjects include software engineering, artificial intelligence, computer graphics and structured programming.'),
              _Principle(
                  'CERTIFICATE',
                  'Claude Code 101: From Prompt to Product',
                  'Certificate listed on LinkedIn.'),
              _Principle('LANGUAGES', 'English and Urdu',
                  'Languages listed on LinkedIn.'),
            ])),
      ]);

  Widget _expertise(BuildContext c, bool wide) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _section(c, 'ENGINEERING PRACTICE', 'Depth across the mobile stack.',
            'A mobile-first foundation, broadened through architecture, integrations, delivery systems and team leadership.'),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: wide ? 64 : 22),
            child: Wrap(spacing: 14, runSpacing: 14, children: const [
              _SkillCard('Native iOS', [
                'Swift',
                'SwiftUI',
                'UIKit',
                'Objective-C',
                'Concurrency',
                'Core Data',
                'MapKit',
                'Keychain'
              ]),
              _SkillCard('Native Android', [
                'Kotlin',
                'Java',
                'Android SDK',
                'App lifecycle',
                'API integration',
                'Release management'
              ]),
              _SkillCard('Cross-platform', [
                'Flutter',
                'Dart',
                'Riverpod',
                'BLoC',
                'Provider',
                'React Native*',
                'Native SDK integration'
              ]),
              _SkillCard('Architecture', [
                'Clean Architecture',
                'MVVM',
                'VIPER',
                'Repository',
                'SOLID',
                'Dependency injection',
                'Modular design'
              ]),
              _SkillCard('APIs & reliability', [
                'REST',
                'GraphQL',
                'WebSockets',
                'OAuth 2.0',
                'JWT',
                'Error handling',
                'Firebase',
                'Sentry'
              ]),
              _SkillCard('Delivery & leadership', [
                'Fastlane',
                'GitHub Actions',
                'Testing',
                'Code review',
                'Mentoring',
                'Roadmaps',
                'AI-assisted workflows'
              ]),
            ])),
        Padding(
            padding: const EdgeInsets.fromLTRB(22, 18, 22, 0),
            child: Text(
                '* React Native is listed in the CV, but no verified production case study is available yet. Backend experience shown here is API integration, not unverified backend implementation.',
                style: Theme.of(c).textTheme.bodySmall?.copyWith(
                    color: Theme.of(c)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: .62))))
      ]);

  Widget _about(BuildContext c, bool wide) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _section(c, 'HOW I WORK', 'Make the architecture serve the product.',
            'I began with native iOS, expanded into Android and cross-platform development, then grew into leading mobile teams and owning delivery end to end. I think across the client, its APIs and the release process, while keeping responsibility clear across team boundaries.'),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: wide ? 64 : 22),
            child: Wrap(spacing: 12, runSpacing: 12, children: const [
              _Principle('01', 'Maintainability',
                  'Prefer clear boundaries and code the next engineer can safely change.'),
              _Principle('02', 'Reliability',
                  'Treat performance, observability, security and recovery as product features.'),
              _Principle('03', 'Practical architecture',
                  'Choose patterns to solve a real constraint, not to decorate a diagram.'),
              _Principle('04', 'Thoughtful AI',
                  'Use coding agents to accelerate implementation and debugging; keep review and accountability human.')
            ]))
      ]);

  Widget _publicCode(BuildContext c, bool wide) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _section(c, 'PUBLIC CODE', 'A few public repositories.',
            'The featured product work is largely private. These public repositories can be explored as code samples; they are not presented as client or employer deliverables.'),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: wide ? 64 : 22),
            child: Wrap(spacing: 12, runSpacing: 12, children: [
              _RepositoryLink(
                  'how_to_set_app_architecture',
                  'Flutter architecture sample',
                  'https://github.com/moizirshad/how_to_set_app_architecture',
                  _launch),
              _RepositoryLink(
                  'flutter_facebook_login_page',
                  'Flutter UI sample',
                  'https://github.com/moizirshad/flutter_facebook_login_page',
                  _launch),
              _RepositoryLink('Argaam_Flutter', 'Public Flutter repository',
                  'https://github.com/moizirshad/Argaam_Flutter', _launch)
            ]))
      ]);

  Widget _contact(BuildContext c, bool wide) {
    final copy =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('LET’S BUILD SOMETHING RELIABLE',
          style: Theme.of(c).textTheme.labelSmall?.copyWith(
              letterSpacing: 1.8,
              color: Theme.of(c).colorScheme.primary,
              fontWeight: FontWeight.w800)),
      const SizedBox(height: 15),
      Text('Good products need\nthoughtful engineering.',
          style: Theme.of(c).textTheme.headlineMedium?.copyWith(
              fontSize: wide ? 42 : 34,
              fontWeight: FontWeight.w700,
              letterSpacing: -1)),
      const SizedBox(height: 12),
      Text('Open to remote and international opportunities.',
          style: Theme.of(c).textTheme.bodyLarge)
    ]);
    final actions = Wrap(spacing: 10, runSpacing: 10, children: [
      FilledButton.icon(
          onPressed: _email,
          icon: const Icon(Icons.mail_outline),
          label: const Text('Email me')),
      OutlinedButton.icon(
          onPressed: () => _launch('https://www.linkedin.com/in/moizirshad/'),
          icon: const Icon(Icons.open_in_new, size: 17),
          label: const Text('View my LinkedIn profile')),
      OutlinedButton.icon(
          onPressed: () => _launch('https://github.com/moizirshad'),
          icon: const Icon(Icons.code, size: 17),
          label: const Text('GitHub'))
    ]);
    return Padding(
        padding: EdgeInsets.fromLTRB(wide ? 64 : 22, 95, wide ? 64 : 22, 50),
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(wide ? 48 : 28),
            decoration: BoxDecoration(
                color: Theme.of(c).colorScheme.primary.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(26),
                border: Border.all(
                    color: Theme.of(c)
                        .colorScheme
                        .primary
                        .withValues(alpha: .28))),
            child: wide
                ? Row(
                    children: [Expanded(child: copy), const Spacer(), actions])
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [copy, const SizedBox(height: 22), actions])));
  }

  Widget _footer(BuildContext c) => Padding(
      padding: const EdgeInsets.fromLTRB(22, 10, 22, 30),
      child: Row(children: [
        Text('© 2026 Moiz Irshad', style: Theme.of(c).textTheme.labelSmall),
        const Spacer(),
        const Text('Dubai, UAE  ·  Available for remote opportunities',
            style: TextStyle(fontSize: 11))
      ]));
  void _email() => _launch('mailto:moiz.14jan@gmail.com');
  void _cv() => _launch(Uri.base
      .resolve('assets/cv/Moiz_Irshad_CV_Mobile_Engineering_Lead.pdf')
      .toString());
  Future<void> _launch(String value) async {
    final uri = Uri.parse(value);
    if (!await launchUrl(uri, webOnlyWindowName: '_blank')) {
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open that link.')));
    }
  }
}

class _HeroArtwork extends StatelessWidget {
  const _HeroArtwork();
  @override
  Widget build(BuildContext context) => AspectRatio(
      aspectRatio: 1.13,
      child: Stack(alignment: Alignment.center, children: [
        Container(
            width: 370,
            height: 370,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).dividerColor),
                gradient: RadialGradient(colors: [
                  Theme.of(context).colorScheme.primary.withValues(alpha: .13),
                  Colors.transparent
                ]))),
        Positioned(
            left: 20,
            top: 85,
            child: Transform.rotate(
                angle: -.10,
                child: _MockDevice(
                    label: 'iOS',
                    title: 'Find your\nnext drive',
                    accent: const Color(0xFFB7C6FF)))),
        Positioned(
            right: 25,
            top: 45,
            child: Transform.rotate(
                angle: .08,
                child: _MockDevice(
                    label: 'FLUTTER',
                    title: 'Meals that\nfit your day',
                    accent: const Color(0xFFC7F36B)))),
        Positioned(
            bottom: 25,
            left: 95,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Theme.of(context).dividerColor)),
                child: const Row(children: [
                  Icon(Icons.hub_outlined, size: 18, color: Color(0xFFC7F36B)),
                  SizedBox(width: 8),
                  Text('CLIENT  ·  API  ·  DELIVERY',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1))
                ])))
      ]));
}

class _MockDevice extends StatelessWidget {
  const _MockDevice(
      {required this.label, required this.title, required this.accent});
  final String label, title;
  final Color accent;
  @override
  Widget build(BuildContext context) => Container(
      width: 155,
      height: 266,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
          color: const Color(0xFF20231D),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white24, width: 2),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, blurRadius: 35, offset: Offset(0, 18))
          ]),
      child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
              color: const Color(0xFF10120F),
              borderRadius: BorderRadius.circular(21)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
                child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(5)))),
            const SizedBox(height: 8),
            Text(label,
                style: TextStyle(
                    color: accent,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2)),
            const SizedBox(height: 8),
            Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 1.1)),
            const SizedBox(height: 8),
            Container(
                height: 42,
                decoration: BoxDecoration(
                    color: accent.withValues(alpha: .17),
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child:
                        Icon(Icons.widgets_outlined, color: accent, size: 30))),
            const SizedBox(height: 8),
            Container(
                height: 9,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(5))),
            const SizedBox(height: 5),
            Container(
                height: 7,
                width: 110,
                decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(5))),
            const Spacer(),
            Container(
                height: 18,
                decoration: BoxDecoration(
                    color: accent, borderRadius: BorderRadius.circular(7)),
                child: Center(
                    child: Text('Continue',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 8,
                            fontWeight: FontWeight.w800))))
          ])));
}

class _Proof extends StatelessWidget {
  const _Proof(this.value, this.label);
  final String value, label;
  @override
  Widget build(BuildContext c) =>
      Row(mainAxisSize: MainAxisSize.min, children: [
        Text(value,
            style: Theme.of(c)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(width: 8),
        Text(label, style: Theme.of(c).textTheme.bodySmall)
      ]);
}

class _Badge extends StatelessWidget {
  const _Badge(this.text);
  final String text;
  @override
  Widget build(BuildContext c) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
          color: Theme.of(c).scaffoldBackgroundColor.withValues(alpha: .8),
          borderRadius: BorderRadius.circular(30)),
      child: Text(text,
          style: Theme.of(c)
              .textTheme
              .labelSmall
              ?.copyWith(fontWeight: FontWeight.w700)));
}

class _ProductArt extends StatelessWidget {
  const _ProductArt({required this.project});
  final Project project;
  @override
  Widget build(BuildContext c) => Container(
      width: 112,
      height: 150,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: Theme.of(c).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: project.color.withValues(alpha: .7), width: 2),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))
          ]),
      child: project.imageUrl == null
          ? _fallback(c)
          : Image.network(project.imageUrl!,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              semanticLabel: '${project.name} project image',
              loadingBuilder: (context, child, progress) => progress == null
                  ? child
                  : Container(
                      color: project.color.withValues(alpha: .15),
                      child: Center(
                          child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: project.color)))),
              errorBuilder: (context, error, stack) => _fallback(c)));
  Widget _fallback(BuildContext c) => Container(
      color: project.color.withValues(alpha: .12),
      padding: const EdgeInsets.all(10),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.phone_iphone, color: project.color, size: 31),
        const SizedBox(height: 8),
        Text(project.name,
            style: Theme.of(c)
                .textTheme
                .labelSmall
                ?.copyWith(fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis),
        const SizedBox(height: 10),
        Icon(
            project.type == 'Native iOS' ? Icons.apple : Icons.widgets_outlined,
            color: project.color,
            size: 20)
      ]));
}

class CaseStudyPage extends StatelessWidget {
  const CaseStudyPage({super.key, required this.project});
  final Project project;
  @override
  Widget build(BuildContext c) => Scaffold(
      appBar: AppBar(
          title: const Text('MOIZ IRSHAD'),
          leading: IconButton(
              tooltip: 'Back',
              onPressed: () => Navigator.maybePop(c),
              icon: const Icon(Icons.arrow_back))),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Center(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Badge(project.type),
                        const SizedBox(height: 22),
                        Text(project.name,
                            style: Theme.of(c)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -2)),
                        const SizedBox(height: 14),
                        Text(project.summary,
                            style: Theme.of(c)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(height: 1.4)),
                        const SizedBox(height: 24),
                        _ProjectShowcase(project: project),
                        const SizedBox(height: 30),
                        _CaseSection('Project overview',
                            '${project.period} · ${project.platforms.join(' and ')}'),
                        _CaseSection('My role', project.role),
                        _CaseSection('Technology', project.stack.join(' · ')),
                        _CaseSection(
                            'Architecture and decisions', project.architecture),
                        _CaseSection(
                            'Technical challenges', project.challenges),
                        _CaseSection('Reliability, performance and security',
                            project.quality),
                        _CaseSection('Collaboration and leadership',
                            project.collaboration),
                        _CaseSection(
                            'Features and engineering',
                            project.highlights
                                .map((x) => '•  $x')
                                .join('\n\n')),
                        _CaseSection('Verified outcome', project.outcome),
                        _CaseSection('Source availability', project.source),
                        const SizedBox(height: 24),
                        if (project.storeUrl != null) ...[
                          OutlinedButton.icon(
                              onPressed: () => launchUrl(
                                  Uri.parse(project.storeUrl!),
                                  webOnlyWindowName: '_blank'),
                              icon: const Icon(Icons.open_in_new),
                              label: const Text('View app listing')),
                          const SizedBox(height: 12)
                        ],
                        OutlinedButton.icon(
                            onPressed: () => Navigator.maybePop(c),
                            icon: const Icon(Icons.arrow_back),
                            label: const Text('Back to projects'))
                      ])))));
}

class _CaseSection extends StatelessWidget {
  const _CaseSection(this.title, this.body);
  final String title, body;
  @override
  Widget build(BuildContext c) => Padding(
      padding: const EdgeInsets.only(bottom: 26),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title.toUpperCase(),
            style: Theme.of(c).textTheme.labelSmall?.copyWith(
                letterSpacing: 1.4,
                color: Theme.of(c).colorScheme.primary,
                fontWeight: FontWeight.w800)),
        const SizedBox(height: 9),
        Text(body,
            style: Theme.of(c).textTheme.bodyLarge?.copyWith(height: 1.65))
      ]));
}

/// Uses a public app image when available and always shows project artwork
/// when a remote image is absent or blocked by the host.
class _ProjectShowcase extends StatelessWidget {
  const _ProjectShowcase({required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: double.infinity,
          height: 320,
          child: project.imageUrl == null
              ? _art(context)
              : Image.network(
                  project.imageUrl!,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  semanticLabel: '${project.name} app image',
                  loadingBuilder: (context, child, progress) =>
                      progress == null ? child : _art(context, loading: true),
                  errorBuilder: (context, error, stack) => _art(context),
                ),
        ),
      );

  Widget _art(BuildContext context, {bool loading = false}) {
    final theme = Theme.of(context);
    return Container(
      color: project.color.withValues(alpha: .13),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 28),
      child: Stack(children: [
        Positioned(
          right: 4,
          top: -70,
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: project.color.withValues(alpha: .13),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('PROJECT VISUAL',
                style: theme.textTheme.labelSmall?.copyWith(
                    letterSpacing: 2,
                    fontWeight: FontWeight.w800,
                    color: project.color)),
            const SizedBox(height: 16),
            Text(project.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800, letterSpacing: -1.2)),
            const SizedBox(height: 10),
            Text(project.platforms.join('  ·  '),
                style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: .72))),
            const SizedBox(height: 22),
            Row(children: [
              Icon(_projectIcon(project), color: project.color, size: 25),
              const SizedBox(width: 9),
              Text(
                  loading
                      ? 'Loading project image…'
                      : 'Illustrative project artwork',
                  style: theme.textTheme.labelMedium?.copyWith(
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: .68))),
            ]),
          ],
        ),
      ]),
    );
  }

  IconData _projectIcon(Project project) {
    if (project.id.contains('fitt')) return Icons.restaurant_outlined;
    if (project.id.contains('dubi')) return Icons.directions_car_outlined;
    if (project.id.contains('bykea')) return Icons.two_wheeler_outlined;
    if (project.id.contains('wallet')) return Icons.lock_outline;
    if (project.id.contains('send')) return Icons.chat_bubble_outline;
    if (project.id.contains('quotes')) return Icons.format_quote;
    if (project.id.contains('akhbaar')) return Icons.newspaper_outlined;
    if (project.id.contains('argaam')) return Icons.show_chart;
    return Icons.business_outlined;
  }
}

class _ArchitectureNode extends StatelessWidget {
  const _ArchitectureNode(this.n, this.title, this.sub,
      {this.horizontal = false});
  final String n, title, sub;
  final bool horizontal;
  @override
  Widget build(BuildContext c) {
    final node = Container(
        width: horizontal ? null : double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(c).dividerColor),
            borderRadius: BorderRadius.circular(14)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(n,
              style: Theme.of(c)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: Theme.of(c).colorScheme.primary)),
          const SizedBox(height: 9),
          Text(title,
              style: Theme.of(c)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 5),
          Text(sub, style: Theme.of(c).textTheme.labelSmall)
        ]));
    return horizontal ? Expanded(child: node) : node;
  }
}

class _Arrow extends StatelessWidget {
  const _Arrow();
  @override
  Widget build(BuildContext c) => const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Icon(Icons.arrow_forward, size: 17));
}

class _DownArrow extends StatelessWidget {
  const _DownArrow();
  @override
  Widget build(BuildContext c) => const Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Icon(Icons.keyboard_arrow_down));
}

class _ExperienceItem extends StatelessWidget {
  const _ExperienceItem(this.date, this.role, this.company, this.body);
  final String date, role, company, body;
  @override
  Widget build(BuildContext c) => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Theme.of(c).dividerColor))),
      child: LayoutBuilder(builder: (context, box) {
        final detail =
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(role,
              style: Theme.of(c)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(company, style: Theme.of(c).textTheme.bodyMedium),
          const SizedBox(height: 8),
          Text(body,
              style: Theme.of(c).textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color:
                      Theme.of(c).colorScheme.onSurface.withValues(alpha: .72)))
        ]);
        return box.maxWidth > 700
            ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                    width: 170,
                    child: Text(date,
                        style: Theme.of(c).textTheme.labelMedium?.copyWith(
                            color: Theme.of(c).colorScheme.primary))),
                Expanded(child: detail)
              ])
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(date,
                    style: Theme.of(c)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Theme.of(c).colorScheme.primary)),
                const SizedBox(height: 8),
                detail
              ]);
      }));
}

class _SkillCard extends StatelessWidget {
  const _SkillCard(this.title, this.items);
  final String title;
  final List<String> items;
  @override
  Widget build(BuildContext c) => SizedBox(
      width: 300,
      child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Theme.of(c).colorScheme.surfaceContainer,
              border: Border.all(color: Theme.of(c).dividerColor)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title,
                style: Theme.of(c)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 14),
            Wrap(
                spacing: 7,
                runSpacing: 7,
                children: items.map((i) => _Badge(i)).toList())
          ])));
}

class _Principle extends StatelessWidget {
  const _Principle(this.n, this.title, this.body);
  final String n, title, body;
  @override
  Widget build(BuildContext c) => SizedBox(
      width: 290,
      child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Theme.of(c).dividerColor)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(n,
                style: Theme.of(c)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: Theme.of(c).colorScheme.primary)),
            const SizedBox(height: 10),
            Text(title,
                style: Theme.of(c)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(body,
                style: Theme.of(c).textTheme.bodyMedium?.copyWith(height: 1.5))
          ])));
}

class _RepositoryLink extends StatelessWidget {
  const _RepositoryLink(this.name, this.description, this.url, this.open);
  final String name, description, url;
  final Future<void> Function(String) open;
  @override
  Widget build(BuildContext c) => SizedBox(
      width: 300,
      child: InkWell(
          onTap: () => open(url),
          borderRadius: BorderRadius.circular(16),
          child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Theme.of(c).dividerColor)),
              child: Row(children: [
                Icon(Icons.code, color: Theme.of(c).colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(name,
                          style: Theme.of(c)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 5),
                      Text(description, style: Theme.of(c).textTheme.bodySmall)
                    ])),
                const Icon(Icons.open_in_new, size: 15)
              ]))));
}
