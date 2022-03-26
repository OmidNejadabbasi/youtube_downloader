
abstract class LinkExtractorDialogEvent {}

class ExtractLinkEvent extends LinkExtractorDialogEvent{
  final String link;

  ExtractLinkEvent(this.link);
}
