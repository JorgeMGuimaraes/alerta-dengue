class Resultado {
  /// casos previstos (casos_est)
  double? casosEst;

  /// casos notificados (cases)
  int? casos;

  /// nível (level - 1 à 5)
  int? nivel;

  /// temperaturas mínimas (tempmin)
  double? tempmin;

  /// temperaturas máximas (tempmax)
  double? tempmax;

  Resultado(this.casosEst, this.casos, this.nivel, this.tempmin, this.tempmax);

  factory Resultado.fromJson(json) {
    return Resultado(json["casos_est"], json["casos"], json["nivel"],
        json["tempmin"], json["tempmax"]);
  }
}

/// {
/// "casos_est":67.0,
/// "casos":67,
/// "nivel":2,
/// "tempmin":22.7142857143,
/// "tempmax":24.8571428571,
/// }
