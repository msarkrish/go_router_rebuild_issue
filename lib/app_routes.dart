/// [AppRoute] defines the possible routes we can use with GoRouter
enum AppRoute {
  /// login page
  login(
    name: 'Login',
    location: '/login_page',
  ),

  /// Dashboard page
  dashboard(
    name: 'Dashboard',
    location: '/dashboard',
    navigationIndex: 0,
  ),

  list(
    name: 'list',
    location: '/list',
    navigationIndex: 1,
  ),

  detail(
    name: 'Detail',
    location: 'detail/:id',
    subroute: '/list/detail',
  ),

  subdetail(
    name: 'Subdetail',
    location: 'subdetail',
    subroute: '/list/detail/subdetail',
  );

  /// initializes [location], [name], [navigationIndex] and [subroute]
  const AppRoute({
    required this.location,
    required this.name,
    this.navigationIndex,
    this.subroute,
  });

  /// location of the page ex: '/Dashboard'
  final String location;

  /// route of the page ex: 'Dashboard'
  final String name;

  /// index of the page in the navigation page
  final int? navigationIndex;

  /// subroute used for nested navigation
  final String? subroute;
}
