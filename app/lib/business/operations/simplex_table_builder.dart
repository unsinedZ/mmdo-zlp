import 'fraction.dart';
import 'linear_task.dart';
import 'simplex_table.dart';

class SimplexTableBuilder {
  SimplexTable createSimplexTable(LinearTask task) {
    const Fraction minus1 = const Fraction.fromNumber(-1);
    return SimplexTable(
      rows: task.restrictions
          .map(
            (x) => SimplexTableRow(
              coefficients: x.coefficients,
              freeMember: x.freeMember,
            ),
          )
          .toList(),
      estimations: SimplexTableEstimations(
        variableEstimations:
            task.targetFunction.coefficients.map((x) => x * minus1).toList(),
        functionValue: task.targetFunction.freeMember,
      ),
    );
  }
}
