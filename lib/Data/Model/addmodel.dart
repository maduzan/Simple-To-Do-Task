import 'package:to_do_app/Domain/Entity/add.dart';

class Addmodel extends addtask {
  Addmodel({
    required super.task,
    required super.Disctiption,
    required super.id,
  });

  factory Addmodel.fromMap(Map<String, dynamic> map) {
    return Addmodel(
      id: map['id'],
      task: map['task'],
      Disctiption: map['Disctiption'],
    );
  }

  Map<String, Object?> toMap() {
    return {
      'task': task,
      'Disctiption': Disctiption,
    };
  }
}
