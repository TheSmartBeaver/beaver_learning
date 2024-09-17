import 'package:beaver_learning/src/models/db/database.dart';

class Topic2 {
  final int id;
  final String name;
  int? fileId;
  int? htmlContentId;
  int? groupId;
  final List<Topic2> childrenTopics;
  int? parentId;

  Topic2(this.id, this.name, this.childrenTopics, {this.parentId, this.fileId, this.groupId, this.htmlContentId});
}

List<Topic2> buildTopic2(List<Topic> topics) {

  List<Topic2> topics2 = [];

  void setDirectChildren(Topic2 parent, List<Topic> topics){
    for(var topic in topics.where((element) => element.parentId == parent.id)){
      parent.childrenTopics.add(Topic2(topic.id, topic.title, [], parentId: topic.parentId, fileId: topic.fileId, groupId: topic.groupId, htmlContentId: topic.htmlContentId));
      setDirectChildren(parent.childrenTopics.last, topics);
    }
  }

  for(var rootTopic in topics.where((element) => element.parentId == null)){
    var topic2 = Topic2(rootTopic.id ,rootTopic.title, [], parentId: rootTopic.parentId, fileId: rootTopic.fileId, groupId: rootTopic.groupId, htmlContentId: rootTopic.htmlContentId);
    setDirectChildren(topic2, topics);
    topics2.add(topic2);
  }

  return topics2;
}