class RouteArgument {
  final String title;
  dynamic id;
  final List<dynamic> argumentsList;

  RouteArgument({this.title, this.id, this.argumentsList});

  @override
  String toString() {
    return 'RouteArgument{title: $title, id: $id, argumentsList: $argumentsList}';
  }
}
