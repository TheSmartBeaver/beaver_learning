import 'package:drift/drift.dart';

class LoggingExecutor extends QueryExecutor {
  final QueryExecutor _inner;

  LoggingExecutor(this._inner);

  static QueryExecutor wrap(QueryExecutor inner) {
    if (inner is DatabaseConnection) {
      return inner.withExecutor(LoggingExecutor(inner.executor));
    } else {
      return LoggingExecutor(inner);
    }
  }

  Future<T> _log<T>(String description, Future<T> Function() inner) async {
    try {
      print('starting with $description');
      return await inner();
    } catch (e) {
      // todo: Log again
      rethrow;
    }
  }

  @override
  TransactionExecutor beginTransaction() {
    return _LoggingTransactionExecutor(_inner.beginTransaction());
  }

  @override
  SqlDialect get dialect => _inner.dialect;

  @override
  Future<bool> ensureOpen(QueryExecutorUser user) {
    return _inner.ensureOpen(user);
  }

  @override
  Future<void> runBatched(BatchedStatements statements) {
    return _log(
        'Batched statements $statements', () => _inner.runBatched(statements));
  }

  @override
  Future<void> runCustom(String statement, [List<Object?>? args]) {
    return _log('Running $statement with $args',
        () => _inner.runCustom(statement, args));
  }

  @override
  Future<int> runDelete(String statement, List<Object?> args) {
    return _inner.runDelete(statement, args);
  }

  @override
  Future<int> runInsert(String statement, List<Object?> args) {
    return _inner.runInsert(statement, args);
  }

  @override
  Future<List<Map<String, Object?>>> runSelect(
      String statement, List<Object?> args) {
    _log('Running $statement with $args',
        () => _inner.runCustom(statement, args));
    return _inner.runSelect(statement, args);
  }

  @override
  Future<int> runUpdate(String statement, List<Object?> args) {
    return _inner.runUpdate(statement, args);
  }

  // You can implement runDelete, runInsert, runSelect and runUpdate in a
  // similar fashion.
}

class _LoggingTransactionExecutor extends LoggingExecutor
    implements TransactionExecutor {
  final TransactionExecutor _innerTransaction;

  _LoggingTransactionExecutor(TransactionExecutor inner)
      : _innerTransaction = inner,
        super(inner);

  @override
  Future<void> rollback() {
    return _log('Rollback', () => _innerTransaction.rollback());
  }

  @override
  Future<void> send() {
    return _log('Commit', () => _innerTransaction.send());
  }

  @override
  bool get supportsNestedTransactions =>
      _innerTransaction.supportsNestedTransactions;

  @override
  Future<int> runDelete(String statement, List<Object?> args) {
    return _inner.runDelete(statement, args);
  }

  @override
  Future<int> runInsert(String statement, List<Object?> args) {
    return _inner.runInsert(statement, args);
  }

  @override
  Future<List<Map<String, Object?>>> runSelect(
      String statement, List<Object?> args) {
    return _inner.runSelect(statement, args);
  }

  @override
  Future<int> runUpdate(String statement, List<Object?> args) {
    return _inner.runUpdate(statement, args);
  }
}
