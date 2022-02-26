


class SearchResult {

  final bool cancel;
  final bool? manual;

  SearchResult({
    required this.cancel, 
    this.manual=false
    });

  // TODO: name, description, latlng


  @override
  String toString() {
    // TODO: implement toString
    return 'SearchResult = cancel: $cancel, manual: $manual';
  }


}