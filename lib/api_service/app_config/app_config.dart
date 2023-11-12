class AppConfig {
  String baseUrl;
  String appName;
  bool isDev;

  AppConfig(
      {required this.baseUrl, required this.appName, required this.isDev});
}

AppConfig devMode = AppConfig(
  appName: 'Simplmet(Dev)',
  baseUrl: 'http://localhost:80/',
  isDev: true,
);

AppConfig prodMode = AppConfig(
  appName: 'Simplmet',
  baseUrl: 'https://simplemoments.stanislavjochman.sk/',
  isDev: false,
);
