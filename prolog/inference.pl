:- use_module(library(lists)).

% BMI and calorie calculations are performed in Prolog.
calculate_bmi(WeightKg, HeightCm, BMI) :-
    HeightM is HeightCm / 100,
    BMI is WeightKg / (HeightM * HeightM).

classify_bmi(BMI, Category) :-
    BMI < 18.5, !, Category = underweight.
classify_bmi(BMI, Category) :-
    BMI < 25.0, !, Category = normal.
classify_bmi(BMI, Category) :-
    BMI < 30.0, !, Category = overweight.
classify_bmi(_, Category) :-
    Category = obesity.

bmr_for_profile(Profile, BMR) :-
    get_dict(gender, Profile, Gender),
    get_dict(weight, Profile, Weight),
    get_dict(height, Profile, Height),
    get_dict(age, Profile, Age),
    ( Gender = male ->
        BMR is (10 * Weight) + (6.25 * Height) - (5 * Age) + 5
    ; BMR is (10 * Weight) + (6.25 * Height) - (5 * Age) - 161
    ).

estimated_calories(Profile, EstimatedCalories) :-
    bmr_for_profile(Profile, BMR),
    get_dict(activity, Profile, Activity),
    calorie_multiplier(Activity, Multiplier),
    get_dict(goal, Profile, Goal),
    goal_adjustment(Goal, Adjustment),
    EstimatedCalories is round(BMR * Multiplier + Adjustment).

goal_adjustment(weight_loss, -400).
goal_adjustment(weight_gain, 300).
goal_adjustment(weight_maintenance, 0).
goal_adjustment(healthy_eating, -100).

user_facts(Profile, Facts) :-
    get_dict(age, Profile, Age),
    get_dict(gender, Profile, Gender),
    get_dict(height, Profile, Height),
    get_dict(weight, Profile, Weight),
    get_dict(activity, Profile, Activity),
    get_dict(goal, Profile, Goal),
    get_dict(diet, Profile, Diet),
    get_dict(meals, Profile, Meals),
    get_dict(low_sodium, Profile, LowSodium),
    Facts = [user_age(Age), user_gender(Gender), user_height(Height), user_weight(Weight), activity_level(Activity), goal(Goal), diet_type(Diet), meal_count(Meals), low_sodium(LowSodium)].

all_conditions_hold([], _).
all_conditions_hold([Condition|Rest], Facts) :-
    member(Condition, Facts),
    all_conditions_hold(Rest, Facts).

forward_chain(Facts, Conclusions, Trace) :-
    findall(Conclusion-RuleText-Conditions,
            ( rule_conclusion(Conclusion, Conditions),
              all_conditions_hold(Conditions, Facts),
              rule_text(Conclusion, RuleText)
            ),
            Pairs),
    unique_conclusions(Pairs, Conclusions),
    maplist(trace_from_pair, Pairs, TraceTerms),
    maplist(trace_to_dict, TraceTerms, Trace).

trace_from_pair(Conclusion-RuleText-Conditions, trace(Conclusion, RuleText, Conditions)).
trace_to_dict(trace(Conclusion, RuleText, Conditions), _{conclusion: Conclusion, rule: RuleText, conditions: Conditions}).

unique_conclusions(Pairs, Unique) :-
    maplist(arg(1), Pairs, Conclusions),
    sort(Conclusions, Unique).

backward_chain(Goal, Facts, Result, Trace) :-
    ( member(Goal, Facts) ->
        Result = supported_by_fact,
        Trace = [_{goal: Goal, rule: 'User fact directly supports this recommendation.', conditions: [Goal]}]
    ; rule_conclusion(Goal, Conditions),
      all_conditions_hold(Conditions, Facts),
      rule_text(Goal, RuleText),
      Result = supported_by_rule,
      Trace = [_{goal: Goal, rule: RuleText, conditions: Conditions}]
    ; Result = unsupported,
      Trace = [_{goal: Goal, rule: 'No rule or fact in the current profile supports this goal.', conditions: []}]
    ).

overall_recommendation(Profile, Recommendation) :-
    get_dict(goal, Profile, Goal),
    goal_conclusion(Goal, Recommendation).

recommended_foods(Profile, Foods) :-
    get_dict(diet, Profile, Diet),
    get_dict(goal, Profile, Goal),
    findall(Food,
            ( recommended_food(Diet, Food), goal_food(Goal, Food)
            ; goal_food(Goal, Food), diet_allows(Diet, Food)
            ),
            Foods0),
    sort(Foods0, Foods).

goal_food(weight_loss, vegetables).
goal_food(weight_loss, fruits).
goal_food(weight_loss, oats).
goal_food(weight_loss, lentils).
goal_food(weight_loss, beans).
goal_food(weight_loss, leafy_greens).
goal_food(weight_loss, yogurt).
goal_food(weight_loss, chicken).
goal_food(weight_gain, oats).
goal_food(weight_gain, sweet_potato).
goal_food(weight_gain, nuts).
goal_food(weight_gain, avocado).
goal_food(weight_gain, yogurt).
goal_food(weight_gain, brown_rice).
goal_food(weight_gain, quinoa).
goal_food(weight_maintenance, vegetables).
goal_food(weight_maintenance, fruits).
goal_food(weight_maintenance, brown_rice).
goal_food(weight_maintenance, beans).
goal_food(weight_maintenance, nuts).
goal_food(healthy_eating, vegetables).
goal_food(healthy_eating, fruits).
goal_food(healthy_eating, oats).
goal_food(healthy_eating, legumes).
goal_food(healthy_eating, avocado).

diet_allows(omnivore, Food) :- healthy_food(Food).
diet_allows(vegetarian, Food) :- healthy_food(Food), \+ forbidden_vegetarian(Food).
diet_allows(vegan, Food) :- healthy_food(Food), \+ forbidden_vegan(Food).
diet_allows(pescatarian, Food) :- healthy_food(Food), \+ forbidden_pescatarian(Food).

forbidden_vegetarian(chicken).
forbidden_vegetarian(fish).
forbidden_vegan(chicken).
forbidden_vegan(fish).
forbidden_vegan(eggs).
forbidden_vegan(yogurt).
forbidden_pescatarian(chicken).

foods_to_limit(Profile, Limits) :-
    get_dict(goal, Profile, Goal),
    get_dict(diet, Profile, Diet),
    findall(Limit,
            ( goal_limit(Goal, Limit) ; diet_limit(Diet, Limit)
            ),
            Limits0),
    sort(Limits0, Limits).

goal_limit(weight_loss, sugary_drinks).
goal_limit(weight_loss, highly_processed_foods).
goal_limit(weight_loss, excessive_added_sugar).
goal_limit(weight_maintenance, sugary_drinks).
goal_limit(weight_gain, energy_drinks).
goal_limit(healthy_eating, highly_processed_foods).
diet_limit(vegetarian, excessive_added_sugar).
diet_limit(vegan, high_sodium_processed_foods).
diet_limit(omnivore, excessive_added_sugar).

default_meal_plan(Profile, Meals) :-
    get_dict(meals, Profile, MealsCount),
    meal_structure(MealsCount, Meals).

meal_plan(Profile, MealPlan) :-
    get_dict(goal, Profile, Goal),
    get_dict(meals, Profile, MealsCount),
    meal_structure(MealsCount, BasePlan),
    meal_adjustment(Goal, BasePlan, MealPlan).

meal_adjustment(weight_loss, Plan, Plan).
meal_adjustment(weight_gain, Plan, Plan).
meal_adjustment(weight_maintenance, Plan, Plan).
meal_adjustment(healthy_eating, Plan, Plan).

hydration_guidance(Profile, Guideline) :-
    get_dict(activity, Profile, Activity),
    hydration_guideline(Activity, Guideline).

macronutrient_guidance(Profile, Macronutrients) :-
    get_dict(goal, Profile, Goal),
    get_dict(weight, Profile, Weight),
    protein_target(Goal, ProteinMultiplier),
    carb_target(Goal, CarbMultiplier),
    fat_target(Goal, FatMultiplier),
    ProteinGrams is round(Weight * ProteinMultiplier),
    CarbGrams is round(Weight * CarbMultiplier),
    FatGrams is round(Weight * FatMultiplier),
    Macronutrients = _{protein: ProteinGrams, carbohydrates: CarbGrams, fats: FatGrams}.

build_user_profile(Data, Profile) :-
    get_dict(age, Data, Age),
    get_dict(gender, Data, GenderValue),
    get_dict(height, Data, Height),
    get_dict(weight, Data, Weight),
    get_dict(activity, Data, ActivityValue),
    get_dict(goal, Data, GoalValue),
    get_dict(diet, Data, DietValue),
    get_dict(meals, Data, Meals),
    normalize_atom(GenderValue, Gender),
    normalize_atom(ActivityValue, Activity),
    normalize_atom(GoalValue, Goal),
    normalize_atom(DietValue, Diet),
    ( get_dict(low_sodium, Data, LowSodium) -> true ; LowSodium = false ),
    Profile = _{age: Age, gender: Gender, height: Height, weight: Weight, activity: Activity, goal: Goal, diet: Diet, meals: Meals, low_sodium: LowSodium}.

normalize_atom(Value, Atom) :-
    atom(Value),
    !,
    Atom = Value.
normalize_atom(Value, Atom) :-
    string(Value),
    atom_string(Atom, Value).

recommendation_text(calorie_controlled_balanced_diet, 'A calorie-controlled balanced diet is recommended.').
recommendation_text(nutrient_dense_calorie_surplus, 'A nutrient-dense calorie surplus is recommended.').
recommendation_text(balanced_maintenance_diet, 'A balanced maintenance diet is recommended.').
recommendation_text(whole_foods_balanced_diet, 'A whole-foods balanced diet is recommended.').

generate_recommendation(Profile, Result) :-
    calculate_bmi(Profile.weight, Profile.height, BMI),
    classify_bmi(BMI, BMIClass),
    bmr_for_profile(Profile, BMR),
    estimated_calories(Profile, EstimatedCalories),
    overall_recommendation(Profile, MainRecommendation),
    recommendation_text(MainRecommendation, MainText),
    recommended_foods(Profile, Foods),
    foods_to_limit(Profile, Limits),
    meal_plan(Profile, MealPlan),
    hydration_guidance(Profile, Hydration),
    macronutrient_guidance(Profile, Macro),
    user_facts(Profile, Facts),
    forward_chain(Facts, Conclusions, ForwardTrace),
    backward_chain(MainRecommendation, Facts, BackwardResult, BackwardTrace),
    explain(Profile, Explanations),
    Result = _{bmi: BMI, bmi_category: BMIClass, bmr: BMR, estimated_calories: EstimatedCalories, recommendation: MainText, recommendation_code: MainRecommendation, recommendation_text: MainText, recommendations: [MainRecommendation|Conclusions], foods: Foods, foods_to_limit: Limits, meal_plan: MealPlan, hydration: Hydration, macronutrients: Macro, explanations: Explanations, forward_chain_trace: ForwardTrace, backward_chain_trace: BackwardTrace, backward_result: BackwardResult}.

