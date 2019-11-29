import 'package:flutter/foundation.dart';

import 'fraction.dart';
import 'simplex_table.dart';

class SimplexTableContext {
  static const int _NO_BASIS = -1;
  
  final SimplexTable simplexTable;
  final List<int> basisVariableIndices;
  final bool hasBasis;

  const SimplexTableContext._({
    this.simplexTable,
    this.basisVariableIndices,
    this.hasBasis,
  });

  static SimplexTableContext create({
    @required SimplexTable simplexTable,
  }) {
    var basisVariableIndices = simplexTable.rows.map((row) {
      for (int i = 0; i < row.coefficients.length; i++) {
        Fraction item = row.coefficients[i];
        if (!item.equalsNumber(1))
          continue;

        bool isBasis = simplexTable.rows
          .where((x) => x != row)
          .every((x) => x.coefficients[i].equalsNumber(0));
        if (isBasis)
          return i;
      }

      return _NO_BASIS;
    });

    var hasBasis = !basisVariableIndices.contains(_NO_BASIS);
    return SimplexTableContext._(
      simplexTable: simplexTable,
      basisVariableIndices: basisVariableIndices,
      hasBasis: hasBasis,
    );
  }
}