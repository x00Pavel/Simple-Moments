class AppConfig {
  String baseUrl;
  String appName;
  bool isDev;

  AppConfig(
      {required this.baseUrl, required this.appName, required this.isDev});
}

AppConfig devMode = AppConfig(
  appName: 'Dado Food(Dev)',
  baseUrl: 'https://dadofoods.herokuapp.com/api/v1',
  isDev: true,
);

AppConfig prodMode = AppConfig(
  appName: 'Dado Food',
  baseUrl: 'https://api.dado.ng/api/v1',
  isDev: false,
);
