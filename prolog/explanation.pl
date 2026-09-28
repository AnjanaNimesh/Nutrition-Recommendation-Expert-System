% Explanations provide a human-readable reasoning trace in a format suitable for the UI.

explain(Profile, ExplanationList) :-
    findall(Entry,
            (
              explain_goal(Profile, GoalEntry),
              Entry = GoalEntry
            ; explain_diet(Profile, DietEntry),
              Entry = DietEntry
            ; explain_sodium(Profile, SodiumEntry),
              Entry = SodiumEntry
            ),
            ExplanationList).

explain_goal(Profile, Entry) :-
    get_dict(goal, Profile, Goal),
    goal_conclusion(Goal, Recommendation),
    rule_text(Recommendation, RuleText),
    Entry = _{fact: Goal, rule: RuleText, conclusion: Recommendation}.

explain_diet(Profile, Entry) :-
    get_dict(diet, Profile, Diet),
    ( Diet = vegetarian ->
        RuleText = 'IF diet = vegetarian THEN recommend plant-based protein and fiber-rich meals.'
    ; Diet = vegan ->
        RuleText = 'IF diet = vegan THEN recommend legumes, tofu, nuts, seeds and vegetables.'
    ; Diet = pescatarian ->
        RuleText = 'IF diet = pescatarian THEN include fish and plant proteins while limiting meat.'
    ; RuleText = 'IF diet is omnivore THEN use a balanced protein pattern with vegetables and whole grains.'
    ),
    Entry = _{fact: Diet, rule: RuleText, conclusion: 'Diet-specific recommendation generated.'}.

explain_sodium(Profile, Entry) :-
    get_dict(low_sodium, Profile, LowSodium),
    LowSodium = true,
    Entry = _{fact: low_sodium(true), rule: 'IF low_sodium preference is enabled THEN reduce processed foods and choose fresh ingredients.', conclusion: 'Foods high in sodium should be limited.'}.

explain_sodium(Profile, Entry) :-
    get_dict(low_sodium, Profile, LowSodium),
    LowSodium = false,
    Entry = _{fact: low_sodium(false), rule: 'No sodium restriction was selected.', conclusion: 'Standard sodium awareness applies only to processed foods.'}.

