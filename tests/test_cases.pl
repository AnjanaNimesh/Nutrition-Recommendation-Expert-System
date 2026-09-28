:- use_module(library(plunit)).
:- consult('../prolog/knowledge_base.pl').

:- begin_tests(diet_expert_system).

test(test_1_young_adult_weight_loss_omnivore, [true(Result = 'A calorie-controlled balanced diet is recommended.')]) :-
    Profile = _{age: 22, gender: male, height: 175, weight: 70, activity: moderate, goal: weight_loss, diet: omnivore, meals: 3, low_sodium: false},
    generate_recommendation(Profile, ResultDict),
    get_dict(recommendation, ResultDict, Result).

test(test_2_active_weight_gain_omnivore, [true(Result = 'A nutrient-dense calorie surplus is recommended.')]) :-
    Profile = _{age: 30, gender: male, height: 180, weight: 78, activity: active, goal: weight_gain, diet: omnivore, meals: 4, low_sodium: false},
    generate_recommendation(Profile, ResultDict),
    get_dict(recommendation, ResultDict, Result).

test(test_3_vegetarian_weight_loss, [true(Result = 'A calorie-controlled balanced diet is recommended.')]) :-
    Profile = _{age: 25, gender: female, height: 165, weight: 62, activity: moderate, goal: weight_loss, diet: vegetarian, meals: 3, low_sodium: false},
    generate_recommendation(Profile, ResultDict),
    get_dict(recommendation, ResultDict, Result).

test(test_4_vegan_weight_maintenance, [true(Result = 'A balanced maintenance diet is recommended.')]) :-
    Profile = _{age: 27, gender: female, height: 170, weight: 68, activity: light, goal: weight_maintenance, diet: vegan, meals: 4, low_sodium: true},
    generate_recommendation(Profile, ResultDict),
    get_dict(recommendation, ResultDict, Result).

test(test_5_low_sodium_vegetarian, [true(Limits = [excessive_added_sugar, highly_processed_foods, sugary_drinks])]) :-
    Profile = _{age: 26, gender: female, height: 168, weight: 60, activity: moderate, goal: weight_loss, diet: vegetarian, meals: 3, low_sodium: true},
    generate_recommendation(Profile, ResultDict),
    get_dict(foods_to_limit, ResultDict, Limits).

test(test_6_sedentary_weight_loss, [true(Result = 'A calorie-controlled balanced diet is recommended.')]) :-
    Profile = _{age: 40, gender: female, height: 160, weight: 68, activity: sedentary, goal: weight_loss, diet: omnivore, meals: 3, low_sodium: false},
    generate_recommendation(Profile, ResultDict),
    get_dict(recommendation, ResultDict, Result).

test(test_7_active_weight_gain, [true(Result = 'A nutrient-dense calorie surplus is recommended.')]) :-
    Profile = _{age: 29, gender: male, height: 176, weight: 74, activity: active, goal: weight_gain, diet: omnivore, meals: 5, low_sodium: false},
    generate_recommendation(Profile, ResultDict),
    get_dict(recommendation, ResultDict, Result).

test(test_8_meal_frequency, [true(MealCount = 5)]) :-
    Profile = _{age: 33, gender: male, height: 182, weight: 82, activity: active, goal: healthy_eating, diet: omnivore, meals: 5, low_sodium: false},
    generate_recommendation(Profile, ResultDict),
    get_dict(meal_plan, ResultDict, MealPlan),
    length(MealPlan, MealCount).

test(test_9_bmi_classification, [true(Category = normal)]) :-
    Profile = _{age: 24, gender: male, height: 175, weight: 70, activity: moderate, goal: weight_maintenance, diet: omnivore, meals: 3, low_sodium: false},
    generate_recommendation(Profile, ResultDict),
    get_dict(bmi_category, ResultDict, Category).

test(test_10_low_sodium_false, [true(Limits = [excessive_added_sugar, highly_processed_foods, sugary_drinks])]) :-
    Profile = _{age: 31, gender: female, height: 167, weight: 66, activity: moderate, goal: weight_loss, diet: omnivore, meals: 3, low_sodium: false},
    generate_recommendation(Profile, ResultDict),
    get_dict(foods_to_limit, ResultDict, Limits).

:- end_tests(diet_expert_system).

:- run_tests(diet_expert_system).
:- halt.
