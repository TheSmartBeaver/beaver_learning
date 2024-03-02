import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/image_table.dart';
import 'package:drift/drift.dart';

part 'image_dao.g.dart';

@DriftAccessor(tables: [Images])
class ImageDao extends DatabaseAccessor<AppDatabase> with _$ImageDaoMixin {
  final AppDatabase db;

  ImageDao(this.db) : super(db);

  Future<List<Image>> getAllImages() => select(images).get();
  Stream<List<Image>> watchAllImages() => select(images).watch();
  Future insertImage(Image image) => into(images).insert(image);
  Future updateImage(Image image) => update(images).replace(image);
  Future deleteImage(Image image) => delete(images).delete(image);
}
