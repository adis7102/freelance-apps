class InterestPayload {
  List<String> interests;

  InterestPayload({
    this.interests,
  });

  Map<String, dynamic> toJson() => {
        "interests": interests,
      };
}
