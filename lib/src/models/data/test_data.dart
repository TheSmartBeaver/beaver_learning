import 'package:beaver_learning/data/constants.dart';

var emptyTemplate_name = "_empty_template.html";

var previewCardJson = '''
  {
  "${AppConstante.rectoFieldName}": {
    "${AppConstante.templateFieldName}": "$emptyTemplate_name"
  },
  "${AppConstante.versoFieldName}": {
    "${AppConstante.templateFieldName}": "$emptyTemplate_name"
  },
  "version": "1.0.0"
}
  ''';

var htmlEmptyTemplate = '''
  <div>
      <div class="texte">
        <p>{{field1}}</p>
      </div>
      <div class="texte">
        <p>{{field2}}</p>
      </div>
  ''';

var completeJsonCardTest = '''
  {
  "recto": {
    "template_name": "_item_template.html",
    "field1": "recto field1",
    "field2": {
      "template_name": "_item_template.html",
      "field1": "recto field2 field1"
    },
    "field3": [
      {
        "template_name": "_item_template.html",
        "field1": "recto field3 field1",
        "field2": [
          {
            "template_name": "_item_template.html",
            "field1": "recto field3 field2 field1"
          },
          {
            "template_name": "_item_template.html",
            "field1": {
              "template_name": "_item_template.html",
              "field1": "recto field3 field2 field1 field1"
            }
          }
        ]
      },
      {
        "template_name": "_item_template.html",
        "field1": {
          "template_name": "_item_template.html",
          "field1": "value1"
        }
      }
    ]
  },
  "verso": {
    "template_name": "_item_template.html",
    "field1": "value1"
  },
  "version": "1.0.0"
}

''';