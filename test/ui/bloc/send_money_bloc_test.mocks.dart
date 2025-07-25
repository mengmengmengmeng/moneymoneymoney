// Mocks generated by Mockito 5.4.6 from annotations
// in moneymoneymoney/test/ui/bloc/send_money_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:moneymoneymoney/domain/repositories/transaction_repository.dart'
    as _i2;
import 'package:moneymoneymoney/domain/usecases/send_money_usecase.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTransactionRepository_0 extends _i1.SmartFake
    implements _i2.TransactionRepository {
  _FakeTransactionRepository_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [SendMoneyUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockSendMoneyUseCase extends _i1.Mock implements _i3.SendMoneyUseCase {
  MockSendMoneyUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TransactionRepository get transactionRepository =>
      (super.noSuchMethod(
            Invocation.getter(#transactionRepository),
            returnValue: _FakeTransactionRepository_0(
              this,
              Invocation.getter(#transactionRepository),
            ),
          )
          as _i2.TransactionRepository);

  @override
  _i4.Future<void> execute(double? amount) =>
      (super.noSuchMethod(
            Invocation.method(#execute, [amount]),
            returnValue: _i4.Future<void>.value(),
            returnValueForMissingStub: _i4.Future<void>.value(),
          )
          as _i4.Future<void>);
}
