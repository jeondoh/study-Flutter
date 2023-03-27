import 'package:rxdart/rxdart.dart';

/// 앱의 모든 fakeRepository 에 대한 데이터를 저장하는 데 사용할 수 있는
/// BehaviorSubject 가 지원하는 메모리 내 저장소
class InMemoryStore<T> {
  InMemoryStore(T initial) : _subject = BehaviorSubject<T>.seeded(initial);

  /// 데이터를 저장하는 BehaviorSubject
  final BehaviorSubject<T> _subject;

  Stream<T> get stream => _subject.stream;
  T get value => _subject.value;
  set value(T value) => _subject.add(value);

  void close() => _subject.close();
}
