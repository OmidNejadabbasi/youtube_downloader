

class LinksListLoading {}

class LinksLoadedState {
  final List<String> links;

  LinksLoadedState(this.links);
}

class LoadingUnsuccessful {
  final Error e;

  LoadingUnsuccessful(this.e);
}
