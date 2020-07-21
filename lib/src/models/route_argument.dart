class RouteArgument {
  final String title;
  dynamic id;
  final List<dynamic> argumentsList;

  RouteArgument({this.title, this.id, this.argumentsList});

  @override
  String toString() {
    return '{id: $id, heroTag:${argumentsList.toString()}}';
  }
}
