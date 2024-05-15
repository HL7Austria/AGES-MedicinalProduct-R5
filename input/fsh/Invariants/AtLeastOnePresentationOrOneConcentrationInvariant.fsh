Invariant: atLeastOnePresentationOrOneConcentrationInvariant
Description: "There must be at least one presentation or one concentration."
Severity: #error
Expression: "presentation.count() >=1 or concentration.count() >=1"