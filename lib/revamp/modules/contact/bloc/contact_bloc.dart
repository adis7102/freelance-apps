import 'package:flutter/material.dart';
import 'package:soedja_freelance/revamp/modules/contact/bloc/contact_state.dart';
import 'package:soedja_freelance/revamp/modules/contact/models/contact_models.dart';
import 'package:soedja_freelance/revamp/modules/contact/services/contact_services.dart';
import 'package:rxdart/rxdart.dart';

class KontakBloc extends KontakService {
  KontakService kontakService = new KontakService();
  BehaviorSubject<ListKontakState> _subjectListKontak =
      BehaviorSubject<ListKontakState>();

  BehaviorSubject<CreateContactState> _subjectCreateContact =
      BehaviorSubject<CreateContactState>();

  BehaviorSubject<DeleteContactState> _subjectDeleteContact =
      BehaviorSubject<DeleteContactState>();

  BehaviorSubject<EditContactState> _subjectEditContact =
      BehaviorSubject<EditContactState>();

  Stream<ListKontakState> get getKontak => _subjectListKontak.stream;
  Stream<CreateContactState> get postContact => _subjectCreateContact.stream;
  Stream<DeleteContactState> get deleteContactStream =>
      _subjectDeleteContact.stream;
  Stream<EditContactState> get editContactStream => _subjectEditContact.stream;

  BehaviorSubject<bool> _stanby = BehaviorSubject<bool>.seeded(false);

  requestGetListKontak(BuildContext context, String payload) {
    try {
      _subjectListKontak.sink
          .add(ListKontakState.onLoading("Loading get list ..."));

      KontakService().getContact(context, payload).then((response) {
        if (response.code == "success") {
          _subjectListKontak.sink.add(ListKontakState.onSuccess(response));
        } else {
          _subjectListKontak.sink
              .add(ListKontakState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectListKontak.sink.add(ListKontakState.onError(e.toString()));
    }
  }

  requestCreateContact(BuildContext context, CreateContactPayload payload) {
    try {
      _subjectCreateContact.sink
          .add(CreateContactState.onLoading("Loading get list ..."));

      KontakService().createContact(context, payload).then((response) {
        if (response.code == "success") {
          _subjectCreateContact.sink
              .add(CreateContactState.onSuccess(response));
        } else {
          _subjectCreateContact.sink
              .add(CreateContactState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectCreateContact.sink.add(CreateContactState.onError(e.toString()));
    }
  }

  requestDeleteContact(BuildContext context, String id) {
    try {
      _subjectDeleteContact.sink
          .add(DeleteContactState.onLoading("Loading get list ..."));

      KontakService().deleteContact(context, id).then((response) {
        if (response.code == "success") {
          _subjectDeleteContact.sink
              .add(DeleteContactState.onSuccess(response));
        } else {
          _subjectDeleteContact.sink
              .add(DeleteContactState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectDeleteContact.sink.add(DeleteContactState.onError(e.toString()));
    }
  }

  requestEditContact(BuildContext context, CreateContactPayload payload, String id) {
    try {
      _subjectEditContact.sink
          .add(EditContactState.onLoading("Loading get list ..."));

      KontakService().editContact(context, payload, id).then((response) {
        if (response.code == "success") {
          _subjectEditContact.sink
              .add(EditContactState.onSuccess(response));
        } else {
          _subjectEditContact.sink
              .add(EditContactState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectEditContact.sink.add(EditContactState.onError(e.toString()));
    }
  }

  unStandByEdit() async {
    _subjectEditContact.sink.add(EditContactState.unStanby());
  }
  
  unStandByDelete() async {
    _subjectDeleteContact.sink.add(DeleteContactState.unStanby());
  }

  unStandBy() async {
    _stanby.sink.add(false);
    _subjectListKontak.sink.add(ListKontakState.unStanby());
    _subjectCreateContact.sink.add(CreateContactState.unStanby());
    _subjectDeleteContact.sink.add(DeleteContactState.unStanby());
    _subjectEditContact.sink.add(EditContactState.unStanby());
  }

  void dispose() {
    _subjectListKontak?.close();
    _subjectCreateContact?.close();
    _subjectDeleteContact?.close();
    _subjectEditContact?.close();
    _stanby?.drain(false);
  }
}
