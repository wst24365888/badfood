class ReportForm {
  String titleText;
  String dateText;
  String timeText;
  String placeText;
  String placeID;
  String symptomText;
  String noteText;
  List<String> photoPaths = [];

  ReportForm({
    this.titleText = "",
    this.dateText = "",
    this.timeText = "",
    this.placeText = "",
    this.placeID = "",
    this.symptomText = "",
    this.noteText = "",
    this.photoPaths,
  });
}
