import 'package:flutter/material.dart';

class Project {
  const Project(
      {required this.id,
      required this.name,
      required this.type,
      required this.period,
      required this.summary,
      required this.role,
      required this.platforms,
      required this.stack,
      required this.highlights,
      required this.outcome,
      required this.color,
      this.source = 'Private source',
      this.architecture =
          'Project-specific architecture decisions are not available in the current verified record.',
      this.challenges =
          'Project-specific technical challenges are not available in the current verified record.',
      this.quality =
          'Project-specific testing and security details are not available in the current verified record.',
      this.collaboration =
          'Project-specific collaboration details are not available in the current verified record.',
      this.storeUrl,
      this.imageUrl,
      this.imageAsset});
  final String id,
      name,
      type,
      period,
      summary,
      role,
      outcome,
      source,
      architecture,
      challenges,
      quality,
      collaboration;
  final List<String> platforms, stack, highlights;
  final Color color;
  final String? storeUrl, imageUrl, imageAsset;
}

// Project names, summaries, platforms and public store links are reconciled to Moiz's LinkedIn Projects section.
// Where LinkedIn does not disclose dates, detailed role, or architecture, this file intentionally leaves them broad.
const projects = <Project>[
  Project(
      id: 'fitt-meals',
      name: 'FITT Meals',
      type: 'Flutter',
      period: 'LinkedIn project · Jan 2026 — Aug 2026',
      summary:
          'Meal plans, weekly menus and food delivery, designed for busy lives.',
      role:
          'Mobile application development; exact project role and dates are not stated in the LinkedIn project entry.',
      platforms: ['iOS', 'Android'],
      stack: [
        'Flutter',
        'Dart',
        'Swift',
        'SwiftUI',
        'Kotlin',
        'Firebase',
        'MVVM',
        'CI/CD',
        'REST APIs'
      ],
      highlights: [
        'Browse meal plans and weekly menus',
        'Choose meals and manage a subscription',
        'Track upcoming deliveries and preferences'
      ],
      outcome:
          'Built from scratch as the sole Flutter developer. The company reports serving 2,500+ customers and preparing more than 40,000 meals per week; these are business scale figures, not app usage metrics.',
      color: Color(0xFFC7F36B),
      imageAsset: 'assets/projects/fitt-meals.png',
      storeUrl: 'https://apps.apple.com/ae/app/fitt-meals/id6446091379',
      imageUrl:
          'https://fittmeals.ae/wp-content/uploads/2023/07/1a-1024x1024.png',
      architecture:
          'The LinkedIn project associates Flutter, MVVM, Firebase and REST APIs. Feature-level architecture is not specified.',
      challenges:
          'Convenient meal selection, plans and deliveries are described; implementation challenges are not published.',
      quality:
          'The LinkedIn entry associates Firebase and CI/CD; testing and security detail is not provided.'),
  Project(
      id: 'dubicars',
      name: 'DubiCars',
      type: 'Flutter',
      period: 'Apr 2021 — Mar 2026',
      summary:
          'A UAE car marketplace with dealer and private-seller listings, HD photos, videos and 360° vehicle views.',
      role:
          'Senior Software Engineer working across Native iOS, Native Android and Flutter. The CV describes cross-platform feature delivery, app performance work and release automation.',
      platforms: ['Native iOS', 'Native Android', 'Flutter'],
      stack: ['Swift', 'Kotlin', 'Flutter', 'Dart', 'iOS', 'Android'],
      highlights: [
        'Browse new and used car listings',
        'View premium video and HD photography',
        'Explore 360° exterior and interior views'
      ],
      outcome:
          'CV-reported individual outcomes: 40% faster cross-platform feature delivery, 50% faster iOS startup, 35% lower memory use, and release time reduced from 4 hours to 30 minutes. The Dubi Hero of the Month award was received in February 2025. Product-wide figures—500K+ downloads, a 4.5+ rating and 99%+ crash-free sessions—are not attributed to one contributor.',
      color: Color(0xFFB7C6FF),
      imageAsset: 'assets/projects/dubicars.png',
      storeUrl:
          'https://apps.apple.com/us/app/dubicars-used-new-cars-uae/id1087256071',
      imageUrl:
          'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/89/41/68/8941682e-2011-7122-2d2a-4e9b11ee034c/7633e754-7d53-4ebb-bc88-bbf737a8b420_3_-_find_your_next.jpg/750x750bb.jpeg'),
  Project(
      id: 'bykea',
      name: 'Bykea',
      type: 'Native iOS',
      period: 'LinkedIn project · May 2022 — Feb 2026',
      summary:
          'On-demand rides on motorbikes, rickshaws and cars across major cities in Pakistan.',
      role:
          'iOS development; exact project dates are not stated in the LinkedIn project entry.',
      platforms: ['iOS'],
      stack: ['Swift', 'iOS Development'],
      highlights: [
        'Ride options across bikes, rickshaws and cars',
        'Everyday ride and delivery platform'
      ],
      outcome:
          'The CV describes a sole iOS engineering role on a platform with 2M+ daily active users. That is a platform-wide figure, not a result attributed to one engineer.',
      color: Color(0xFFFFC27A),
      imageAsset: 'assets/projects/bykea.png',
      storeUrl:
          'https://apps.apple.com/us/app/bykea-cab-rides-delivery/id1351179184',
      imageUrl:
          'https://fastly.mwm-storage.mwmcdn.com/raw_files/5651c3a5-81a6-414e-9d62-94601d8f2005?format=webp&height=1280'),
  Project(
      id: 'argaam',
      name: 'Argaam',
      type: 'Native iOS',
      period: 'LinkedIn project · Feb 2016',
      summary:
          'Financial news, economic events, reports, financial charts and live stock-market data.',
      role: 'iOS development associated with Danat FZ LLC.',
      platforms: ['iOS'],
      stack: ['Swift', 'iOS Development'],
      highlights: [
        'News and financial events',
        'Reports and financial charts',
        'Live market data',
        'In-app purchases for locked articles'
      ],
      outcome:
          'LinkedIn project description; no project-specific outcome figures are listed.',
      color: Color(0xFF85D6C5),
      imageAsset: 'assets/projects/argaam.png',
      storeUrl: 'https://apps.apple.com/eg/app/argaam-legacy/id412588115',
      imageUrl:
          'https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/f8/79/16/f87916fa-60d1-d2e6-e8a0-964195793b0c/5d7910d2-6d61-433b-9b0e-b5afc81340da_Group_2.png/471x1024.jpeg'),
  Project(
      id: 'srmg',
      name: 'SRMG Investor Relations',
      type: 'Native iOS',
      period: 'LinkedIn project',
      summary:
          'Investor relations app for Saudi Research and Marketing Group, with market data and corporate updates.',
      role: 'iOS development associated with Danat FZ LLC.',
      platforms: ['iOS'],
      stack: ['Swift', 'iOS Development'],
      highlights: [
        'Share price, financial reports and IR calendar',
        'Company news, disclosures and financial indicators',
        'Arabic and English support',
        'Calendar events and corporate updates'
      ],
      outcome:
          'Features are described in LinkedIn; no project-specific outcome figures are listed.',
      color: Color(0xFFB7C6FF),
      imageAsset: 'assets/projects/srmg.jpeg',
      storeUrl: 'https://apps.apple.com/eg/app/srmg-ir-app/id1354322787'),
  Project(
      id: 'akhbaar24',
      name: 'Akhbaar24 · أخبار24',
      type: 'Native iOS',
      period: 'LinkedIn project · Feb 2016 — Jan 2018',
      summary:
          'Saudi and international news with live coverage across politics, business, sports and more.',
      role: 'iOS development associated with Danat FZ LLC.',
      platforms: ['iOS'],
      stack: ['Swift', 'iOS Development'],
      highlights: [
        'News across business, politics, sports and culture',
        'Live sports data and event updates'
      ],
      outcome:
          'LinkedIn project description; no project-specific outcome figures are listed.',
      color: Color(0xFFFF9A88),
      imageAsset: 'assets/projects/akhbaar24.jpeg',
      storeUrl:
          'https://apps.apple.com/pk/app/%D8%A3%D8%AE%D8%A8%D8%A724/id595306572',
      imageUrl:
          'https://fastly.mwm-storage.mwmcdn.com/raw_files/de729ed0-f541-40aa-9e69-b3d3ed4f6365?format=webp&height=1280'),
  Project(
      id: 'al-aseel',
      name: 'Al-Aseel · ثوب الأصيل',
      type: 'Native iOS',
      period: 'LinkedIn project',
      summary:
          'Investor relations information for Al-Aseel Thobe Co., including financial performance and company updates.',
      role: 'iOS development associated with Danat FZ LLC.',
      platforms: ['iOS'],
      stack: ['Swift', 'iOS Development'],
      highlights: [
        'Share data, financials and corporate fundamentals',
        'Company news and press releases',
        'Bilingual Arabic and English experience'
      ],
      outcome:
          'LinkedIn project description; no project-specific outcome figures are listed.',
      color: Color(0xFFC6A8F5),
      imageAsset: 'assets/projects/al-aseel.jpeg',
      storeUrl:
          'https://apps.apple.com/pk/app/al-aseel-%D8%AB%D9%88%D8%A8-%D8%A7%D9%84%D8%A3%D8%B5%D9%8A%D9%84/id1362473926'),
  Project(
      id: 'saudi-re',
      name: 'Saudi Re · إعادة',
      type: 'Native iOS',
      period: 'LinkedIn project · Feb 2019 — Mar 2019',
      summary:
          'Investor relations app with share data, financials, corporate fundamentals and company updates.',
      role: 'iOS development associated with Danat FZ LLC.',
      platforms: ['iOS'],
      stack: ['Swift', 'iOS Development'],
      highlights: [
        'Interactive share data and key financials',
        'Corporate fundamentals and press releases',
        'Latest corporate updates'
      ],
      outcome:
          'LinkedIn project description; no project-specific outcome figures are listed.',
      color: Color(0xFF85D6C5),
      imageAsset: 'assets/projects/saudi-re.jpg',
      storeUrl:
          'https://apps.apple.com/eg/app/saudi-re-%D8%A5%D8%B9%D8%A7%D8%AF%D8%A9/id1446568968'),
  Project(
      id: 'advanced-petrochemical',
      name: 'Advanced Petrochemical',
      type: 'Native iOS',
      period: 'LinkedIn project · May 2019 — Sep 2019',
      summary:
          'Investor relations app for Advanced Petrochemical Company with market and corporate information.',
      role: 'iOS development associated with Danat FZ LLC.',
      platforms: ['iOS'],
      stack: ['Swift', 'iOS Development'],
      highlights: [
        'Share price, news and financial reports',
        'Financial indicators and investor information',
        'Board, shareholder and calendar details'
      ],
      outcome:
          'LinkedIn project description; no project-specific outcome figures are listed.',
      color: Color(0xFFFFC27A),
      imageAsset: 'assets/projects/advanced-petrochemical.jpeg',
      imageUrl:
          'https://advancedpetrochem.eurolandir.com/media/kc3d23qn/appscreen.png'),
  Project(
      id: 'al-jouf',
      name: 'Al Jouf Cement · اسمنت الجوف',
      type: 'Native iOS',
      period: 'LinkedIn project · Mar 2018',
      summary:
          'Investor relations app delivering Al Jouf Cement news, financial information and shareholder resources.',
      role: 'iOS development associated with Danat FZ LLC.',
      platforms: ['iOS'],
      stack: ['Swift', 'iOS Development'],
      highlights: [
        'Share information, news and financial reports',
        'Interactive share data and corporate fundamentals',
        'Arabic and English support',
        'Calendar and corporate updates'
      ],
      outcome:
          'LinkedIn project description; no project-specific outcome figures are listed.',
      color: Color(0xFFB7C6FF),
      imageAsset: 'assets/projects/al-jouf.jpeg'),
  Project(
      id: 'taiba',
      name: 'Taiba for Investment',
      type: 'Native iOS',
      period: 'LinkedIn project',
      summary:
          'Investor relations app providing company information and performance across devices.',
      role: 'iOS development associated with Danat FZ LLC.',
      platforms: ['iOS'],
      stack: ['Swift', 'iOS Development'],
      highlights: [
        'Company news and interactive share data',
        'Key financials and performance ratios',
        'Arabic and English support',
        'Press releases, notifications and communication'
      ],
      outcome:
          'LinkedIn project description; no project-specific outcome figures are listed.',
      color: Color(0xFFC7F36B),
      imageAsset: 'assets/projects/taiba.jpeg'),
  Project(
      id: 'tasnee',
      name: 'Tasnee · التصنيع',
      type: 'Native iOS',
      period: 'LinkedIn project · Jan 2017',
      summary:
          'Investor relations app for Tasnee, the National Industrialization Company.',
      role:
          'iOS development associated with Danat FZ LLC. The LinkedIn project media is titled “Tasnee iOS & Flutter App.”',
      platforms: ['iOS', 'Flutter'],
      stack: ['Swift', 'iOS Development', 'Flutter (LinkedIn media title)'],
      highlights: [
        'Share price and financial reports',
        'Company news and investor information',
        'Financial indicators, board and shareholder details'
      ],
      outcome:
          'LinkedIn project description; no project-specific outcome figures are listed.',
      color: Color(0xFFFF9A88),
      imageAsset: 'assets/projects/tasnee.jpeg'),
  Project(
      id: 'the-quotes',
      name: 'The Quotes',
      type: 'Native iOS',
      period: 'LinkedIn project',
      summary:
          'A daily quote app with personalized backgrounds and sharing tools.',
      role: 'iOS development associated with InnovativeSolutions.',
      platforms: ['iOS'],
      stack: ['Swift', 'iOS Development'],
      highlights: [
        'Daily quote delivered at 9 a.m.',
        'Customizable backgrounds',
        'Share to Facebook and Twitter',
        'Today extension'
      ],
      outcome:
          'LinkedIn project description; no project-specific outcome figures are listed.',
      color: Color(0xFFC6A8F5),
      imageAsset: 'assets/projects/the-quotes.png'),
  Project(
      id: 'the-send-app',
      name: 'The Send App',
      type: 'Native iOS',
      period: 'LinkedIn project · Jul 2011',
      summary: 'Messaging application built on the XMPP protocol.',
      role: 'Objective-C development associated with InnovativeSolutions.',
      platforms: ['iOS'],
      stack: ['Objective-C', 'XMPP', 'iOS Development'],
      highlights: [
        'Text, picture and voice messaging',
        'Location and contact sharing',
        'Contact search and group chat',
        'User profiles and availability'
      ],
      outcome:
          'LinkedIn project description; no project-specific outcome figures are listed.',
      color: Color(0xFF85D6C5)),
  Project(
      id: 'iswallet',
      name: 'ISWallet',
      type: 'Native iOS',
      period: 'LinkedIn project · Jul 2014',
      summary:
          'A password-protected wallet for storing and sharing personal images and videos.',
      role: 'Objective-C development associated with InnovativeSolutions.',
      platforms: ['iOS'],
      stack: ['Objective-C', 'iOS Development'],
      highlights: [
        'Password-protected image and video storage',
        'Sharing via Bluetooth, web server and email',
        'Social sharing integrations'
      ],
      outcome:
          'LinkedIn project description; no project-specific outcome figures are listed.',
      color: Color(0xFFFFC27A)),
];
