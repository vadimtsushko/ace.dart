part of ace;

/// A region within an [Editor].
/// 
/// A [Range] can be thought of as a rectangle from a [start] point to an [end]
/// point.
class Range implements Comparable<Range> {
  final Point start;
  final Point end;

  /// Returns _true_ if this range's [start] point equals its [end] point.
  bool get isEmpty => start.row == end.row && start.column == end.column;
  
  /// Returns _true_ if this range spans across multiple lines.
  bool get isMultiLine => start.row != end.row;
  
  Range(int startRow, int startColumn, int endRow, int endColumn)
      : this.fromPoints(new Point(startRow, startColumn), 
                        new Point(endRow, endColumn));
  
  Range.fromPoints(this.start, this.end);
  
  Range._(proxy) : this(proxy.start.row, proxy.start.column, 
                        proxy.end.row, proxy.end.column);
  
  bool operator ==(Object other) {
    if(identical(this, other)) return true;
    if(other is! Range) return false; 
    final o = other;
    return start == o.start && end == o.end;
  }
  
  int get hashCode => start.hashCode ^ end.hashCode;
  
  /// Compares the given [row] and [column] with this range.
  /// 
  /// This algorithm will return the following values:
  /// 
  ///     -1  if the point comes before this range
  ///     0   if the point comes within this range
  ///     1   if the point comes after this range   
  int compare(int row, int column) {
    if (!isMultiLine) {
      if (row == start.row) {        
        return column < start.column ? -1 : (column > end.column ? 1 : 0);
      };
    }
    if (row < start.row)  return -1;
    if (row > end.row)    return 1;
    if (start.row == row) return column >= start.column ? 0 : -1;
    if (end.row == row)   return column <= end.column ? 0 : 1;
    return 0;
  }
  
  int compareEnd(int row, int column) {
    if (end.row == row && end.column == column) return 1;
    else return compare(row, column);
  }
  
  int compareInside(int row, int column) {
    if (end.row == row && end.column == column)           return 1;
    else if (start.row == row && start.column == column)  return -1;
    else return compare(row, column);
  }
  
  int comparePoint(Point point) => compare(point.row, point.column);
  
  int compareRange(Range range) {
    var cmp,
        end = range.end,
        start = range.start;

    cmp = compare(end.row, end.column);
    if (cmp == 1) {
      cmp = compare(start.row, start.column);
      if (cmp == 1) {
        return 2;
      } else if (cmp == 0) {
        return 1;
      } else {
        return 0;
      }
    } else if (cmp == -1) {
      return -2;
    } else {
      cmp = compare(start.row, start.column);
      if (cmp == -1) {
        return -1;
      } else if (cmp == 1) {
        return 42;
      } else {
        return 0;
      }
    }
  }
  
  int compareStart(int row, int column) {
    if (start.row == row && start.column == column) return -1;
    else return compare(row, column);
  }
  
  int compareTo(Range other) => compareRange(other);
  
  js.Proxy _toProxy() => 
      new js.Proxy(_context.ace.define.modules['ace/range'].Range, 
          start.row, start.column, end.row, end.column);
  
  String toString() => 
      'Range: [${start.row}/${start.column}] -> [${end.row}/${end.column}]';
}
