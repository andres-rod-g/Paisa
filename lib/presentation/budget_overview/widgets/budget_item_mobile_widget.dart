import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/routes.dart';
import '../../../common/constants/currency.dart';
import '../../../common/widgets/material_you_card_widget.dart';
import '../../../data/category/model/category.dart';
import '../../../data/expense/model/expense.dart';

class BudgetItemMobileWidget extends StatelessWidget {
  const BudgetItemMobileWidget({
    Key? key,
    required this.category,
    required this.expenses,
  }) : super(key: key);
  final Category category;
  final List<Expense> expenses;

  get isBudgetActive => category.budget == null;

  @override
  Widget build(BuildContext context) {
    double totalExpenses = totalExpense(expenses);
    final totalBudget = category.budget ?? -1;
    double difference;
    if (isBudgetActive) {
      difference = totalBudget - totalExpenses;
    } else {
      difference = totalExpenses;
    }

    return MaterialYouCard(
      child: InkWell(
        onTap: () => context.goNamed(addCategoryPath, extra: category),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(
                IconData(category.icon, fontFamily: 'MaterialIcons'),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                category.name,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Sparkline(
                  data: expenses.map((e) => e.currency).toList(),
                  useCubicSmoothing: true,
                  cubicSmoothingFactor: 0.2,
                  lineWidth: 3,
                  lineColor: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 16,
                left: 16,
                right: 16,
              ),
              child: Text(
                '${isBudgetActive ? 'Remainig' : ''} ${formattedCurrency(difference)}',
                style: GoogleFonts.manrope(
                  textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
