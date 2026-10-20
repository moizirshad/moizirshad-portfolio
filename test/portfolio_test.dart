import 'package:flutter_test/flutter_test.dart';
import 'package:moiz_irshad_portfolio/data/projects.dart';
import 'package:moiz_irshad_portfolio/main.dart';

void main() {
  test('portfolio features evidence-backed, unified case studies', () {
    expect(projects.length, 15);
    expect(
        projects.map((project) => project.id).toSet().length, projects.length);
    expect(projects.any((project) => project.name == 'Bykea'), isTrue);
    expect(projects.any((project) => project.name == 'DubiCars'), isTrue);
    expect(projects.any((project) => project.id == 'fitt-meals'), isTrue);
    final dubiCars =
        projects.singleWhere((project) => project.id == 'dubicars');
    expect(dubiCars.platforms,
        containsAll(['Native iOS', 'Native Android', 'Flutter']));
    expect(
        projects.map((project) => project.id),
        containsAll([
          'srmg',
          'akhbaar24',
          'al-aseel',
          'saudi-re',
          'advanced-petrochemical',
          'al-jouf',
          'taiba',
          'tasnee',
          'the-quotes',
          'the-send-app',
          'iswallet',
        ]));
  });

  testWidgets('homepage communicates mobile engineering lead positioning',
      (tester) async {
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();
    expect(find.textContaining('Leading mobile'), findsOneWidget);
    expect(find.text('Explore my work'), findsOneWidget);
  });
}
