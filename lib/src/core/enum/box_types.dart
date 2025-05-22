enum BoxType {
  settings('settings'),
  profile('profile'),
  account('account'),
  transactions('transactions'),
  cache('cache');

  final String name;

  const BoxType(this.name);
}
