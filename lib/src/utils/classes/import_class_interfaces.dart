import 'package:archive/archive_io.dart';
import 'package:beaver_learning/src/utils/classes/export_classes.dart';
import 'package:beaver_learning/src/utils/classes/import_classes.dart';
import 'package:beaver_learning/src/utils/export_functions.dart';

abstract class ImportInterface {
  Map<String, CardExport> cardExports = {};
  Map<String, GroupExport> groupExports = {};
  Map<String, EntityNature> entityNatures = {};
  Map<String, TopicExport> topicExports = {};
  Map<String, HtmlTemplateExport> htmlTemplateExports = {};

  String? sku;

  void createCardInCardExportsIfNotExists(String name, bool isTemplated);

  // On définit la nature de chaque entité (fichier) que l'on importe
  void fillEntityNatures(ArchiveFile archEntity);

  void fillAllGroupExports();
  
  void fillAllHtmlTemplatesExports();
  void fillAllCardExports();
  void fillAllCardRegularExportsRecto();
  void fillAllCardRegularExportsVerso();
  void fillAllJsonCardExportsTemplated();
  void fillAllCardExportsFiles();

  void linkAllCardExportsToGroupExports();
  void fillAllTopicExports();
  void linkAllGroupExportsToTopicExports();
  void linkAllSupportsToTopicExports();
  void linkAllTopicExportsToParentTopicExports();
  void linkAllGroupExportsToParentGroupExports();
  
  Future<void> createHtmlTemplatesInDb();
  Future<void> createGroupsInDB();
  Future<int> createCourseInDB();
  Future<void> createTopicsInDB(int courseId);
  
}
