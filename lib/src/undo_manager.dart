part of ace;

/// Manages the undo stack for an [EditSession].
abstract class UndoManager extends _Disposable {
  
  /// Returns `true` if there are [redo] operations left to perform.
  bool get hasRedo;
  
  /// Returns `true` if there are [undo] operations left to perform.
  bool get hasUndo;
  
  /// Performs a redo operation on the associated document, reinstating the last 
  /// change.
  /// 
  /// If [dontSelect] is _true_ then the range of the change will not be 
  /// selected.  Returns the range of the operation that is performed, or `null`
  /// if [hasRedo] is _false_.
  Range redo(bool dontSelect);
  
  /// Destroys the stack of [undo] and [redo] operations.
  void reset();
  
  /// Performs an undo operation on the associated document, reverting the last 
  /// change.
  /// 
  /// If [dontSelect] is _true_ then the range of the change will not be 
  /// selected.  Returns the range of the operation that is performed, or `null`
  /// if [hasUndo] is _false_.
  Range undo(bool dontSelect);
}
