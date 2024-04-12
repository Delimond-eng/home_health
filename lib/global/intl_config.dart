class IntlConfig {
  static Future<List<Map<String, dynamic>>> days() async {
    List<Map<String, dynamic>> ds = [
      {
        "label": "Lundi",
        "code": "01",
      },
      {
        "label": "Mardi",
        "code": "02",
      },
      {
        "label": "Merc.",
        "code": "03",
      },
      {
        "label": "Jeudi",
        "code": "04",
      },
      {
        "label": "Vend.",
        "code": "05",
      },
      {
        "label": "Sam.",
        "code": "06",
      },
      {
        "label": "Dim.",
        "code": "07",
      },
    ];
    return ds;
  }

  static Future<List<Map<String, dynamic>>> months() async {
    List<Map<String, dynamic>> ms = [
      {
        "label": "Janv.",
        "code": "01",
      },
      {
        "label": "Fevr.",
        "code": "02",
      },
      {
        "label": "Mars",
        "code": "03",
      },
      {
        "label": "Avril",
        "code": "04",
      },
      {
        "label": "Mai",
        "code": "05",
      },
      {
        "label": "Juin",
        "code": "06",
      },
      {
        "label": "Juill.",
        "code": "07",
      },
      {
        "label": "Août",
        "code": "08",
      },
      {
        "label": "Sept.",
        "code": "09",
      },
      {
        "label": "Oct.",
        "code": "10",
      },
      {
        "label": "Nov.",
        "code": "11",
      },
      {
        "label": "Déc.",
        "code": "12",
      },
    ];
    return ms;
  }
}
