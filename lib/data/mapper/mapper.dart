// to convert the response to the nullable object

import 'package:mvvmproject/app/extensions.dart';

import '../../domain/model/model.dart';
import '../responses/responses.dart';

const String emptyString = '';
const int emptyInt = 0;
extension CustomerResponseMapper on CustomerResponse {
  Customer toDomain () {
    return Customer(id?.nonNull??emptyString, name?.nonNull??emptyString, numOfNotification.nonNull??emptyInt);
  }
}

extension ContactsResponseMapper on ContactsResponse {
  Contacts toDomain () {
    return Contacts(email?.nonNull??emptyString, link?.nonNull??emptyString, phone?.nonNull??emptyString);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse {
  Authentication toDomain () {
    return Authentication(customer?.toDomain()??Customer(emptyString, emptyString, emptyInt), contacts?.toDomain()??Contacts(emptyString, emptyString, emptyString));
  }
}