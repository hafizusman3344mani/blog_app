import 'package:blog_app/core/app/presentation/pages/blog_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BlogApp());
  });
}
