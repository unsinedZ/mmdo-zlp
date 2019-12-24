import 'package:app/business/operations/linear_task_context.dart';

import 'linear_task_adjuster.dart';
import 'extremum_to_minimum_adjuster.dart';
import 'dual_simplex_restrictions_to_equalities_adjuster.dart';
import 'dual_simplex_basis_creator.dart';

class DualSimplexAdjuster implements LinearTaskAdjuster {
  const DualSimplexAdjuster();
  
  List<LinearTaskAdjuster> _getAdjusters() => [
        ExtremumToMinimumAdjuster(),
        DualSimplexRestrictionsToEqualitiesAdjuster(),
        DualSimplexBasisCreator(),
      ];

  List<LinearTaskContext> getAdjustmentSteps(LinearTaskContext context) {
    return _generateAdjustmentSteps(context).toList();
  }

  Iterable<LinearTaskContext> _generateAdjustmentSteps(LinearTaskContext task) sync* {
    for (LinearTaskAdjuster adjuster in _getAdjusters()) {
      List<LinearTaskContext> adjusted = adjuster.getAdjustmentSteps(task);
      for (LinearTaskContext adjustedTask in adjusted) {
        yield adjustedTask;
      }
    }
  }
}
