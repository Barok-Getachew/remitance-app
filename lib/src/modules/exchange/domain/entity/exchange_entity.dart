class ExchangeRate {
  final String fromCurrency;
  final String toCurrency;
  final double rate;
  final DateTime lastUpdated;

  ExchangeRate({
    required this.fromCurrency,
    required this.toCurrency,
    required this.rate,
    required this.lastUpdated,
  });
}

enum Currency {
  usd('USD'),
  eur('EUR'),
  gbp('GBP'),
  jpy('JPY'),
  aud('AUD'),
  cad('CAD'),
  chf('CHF'),
  cny('CNY');
  // etb('ETB');

  final String code;
  const Currency(this.code);
}
