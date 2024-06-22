/// A class representing a draft.
///
/// A draft contains information about a document being created or modified.
class Draft {
  /// The unique identifier of the draft.
  final String id;

  /// The name of the employee working on the draft.
  final String employee;

  /// The estimated duration to complete the draft.
  final String duration;

  /// The creation date of the draft.
  final String creationDate;

  /// Constructs a Draft object.
  ///
  /// [id], [employee], [duration], and [creationDate] are required parameters.
  Draft({
    required this.id,
    required this.employee,
    required this.duration,
    required this.creationDate,
  });
}
