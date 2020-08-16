class Task {
  final int id;
  final String title;
  final String description;
  final String date;
  final String time;
  final String category;
  final int color;

  Task(
      {this.id,
      this.title,
      this.description,
      this.category,
      this.date,
      this.time,
      this.color});

//  for creating new entry
  Map<String, dynamic> toMapWithoutId() {
    final map = Map<String, dynamic>();

    map['title'] = title;
    map['description'] = description;
    map['category'] = category;
    map['date'] = date;
    map['time'] = time;
    map['color'] = color;
    return map;
  }

  //for updating entry
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();

    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['category'] = category;
    map['date'] = date;
    map['time'] = time;
    map['color'] = color;
    return map;
  }

  //to convert map into task object
  factory Task.fromMap(Map<String, dynamic> map) => Task(
     id: map['id'],
     title: map['title'],
     description: map['description'],
     category: map['category'],
     date:  map['date'],
     time: map['time'],
     color: map['color']

 );
}
