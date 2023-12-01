class AppConfig {
  String baseUrl;
  String appName;
  bool isDev;

  AppConfig(
      {required this.baseUrl, required this.appName, required this.isDev});
}

AppConfig devMode = AppConfig(
  appName: 'Simplmet(Dev)',
  baseUrl: 'https://simplemoments.stanislavjochman.sk/',
  isDev: true,
);

AppConfig prodMode = AppConfig(
  appName: 'Simplmet',
  baseUrl: 'https://simplemoments.stanislavjochman.sk/',
  isDev: false,
);
