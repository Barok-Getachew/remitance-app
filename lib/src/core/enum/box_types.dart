enum BoxType {
  settings('settings'),
  profile('profile'),
  account('account'),
  cache('cache');

  final String name;

  const BoxType(this.name);
}
