import 'package:flutter/services.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/auth_models.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/payment/models/payment_models.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';

const CHANNEL = "com.soedja.soedja_freelance";
const KEY_NATIVE = 'showPayment';

class PaymentComponents{

  static const platform = const MethodChannel(CHANNEL);

  Future<Null> showPayment({ProfileDetail profile, PaymentPayload payload}) async {

    await platform.invokeMethod(KEY_NATIVE, {
      "email": profile.email,
      "phone": profile.phone,
      "full_name": profile.name,
      "payment_id": payload.paymentId,
      "price": payload.price,
      "quantity": payload.quantity,
      "name": payload.name
    });
  }
}