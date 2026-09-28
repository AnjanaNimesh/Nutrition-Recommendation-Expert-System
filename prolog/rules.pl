% Rule catalogue used by forward chaining, backward chaining and explanation.

rule_conclusion(calorie_controlled_balanced_diet, [goal(weight_loss)]).
rule_conclusion(nutrient_dense_calorie_surplus, [goal(weight_gain)]).
rule_conclusion(balanced_maintenance_diet, [goal(weight_maintenance)]).
rule_conclusion(whole_foods_balanced_diet, [goal(healthy_eating)]).
rule_conclusion(plant_based_protein_focus, [diet_type(vegetarian)]).
rule_conclusion(plant_based_protein_focus, [diet_type(vegan)]).
rule_conclusion(lean_protein_focus, [diet_type(omnivore), goal(weight_loss)]).
rule_conclusion(energy_dense_nutrition, [activity_level(active), goal(weight_gain)]).
rule_conclusion(energy_dense_nutrition, [activity_level(very_active), goal(weight_gain)]).
rule_conclusion(careful_portion_control, [activity_level(sedentary), goal(weight_loss)]).
rule_conclusion(reduce_processed_foods, [low_sodium(true)]).
rule_conclusion(vegetable_volume, [goal(weight_loss)]).
rule_conclusion(whole_grain_emphasis, [goal(weight_loss)]).
rule_conclusion(whole_grain_emphasis, [goal(weight_maintenance)]).
rule_conclusion(healthy_fat_sources, [goal(healthy_eating)]).
rule_conclusion(plant_protein_for_meals, [diet_type(vegetarian), meal_count(3)]).
rule_conclusion(plant_protein_for_meals, [diet_type(vegan), meal_count(3)]).
rule_conclusion(consistent_meal_timing, [meal_count(3)]).
rule_conclusion(consistent_meal_timing, [meal_count(4)]).
rule_conclusion(consistent_meal_timing, [meal_count(5)]).
rule_conclusion(low_sugar_strategy, [goal(weight_loss)]).
rule_conclusion(increased_hydration, [activity_level(active)]).
rule_conclusion(increased_hydration, [activity_level(very_active)]).
rule_conclusion(leaner_choices, [diet_type(omnivore), goal(weight_loss)]).
rule_conclusion(no_animal_product_recommendation, [diet_type(vegan)]).
rule_conclusion(fish_included, [diet_type(pescatarian)]).
rule_conclusion(avoid_sugary_drinks, [goal(weight_loss)]).
rule_conclusion(limit_processed_snacks, [low_sodium(true)]).
rule_conclusion(more_fruits_and_vegetables, [goal(healthy_eating)]).

rule_text(calorie_controlled_balanced_diet, 'IF goal = weight_loss THEN recommend a calorie-controlled balanced diet.').
rule_text(nutrient_dense_calorie_surplus, 'IF goal = weight_gain THEN recommend a nutrient-dense calorie surplus.').
rule_text(balanced_maintenance_diet, 'IF goal = weight_maintenance THEN recommend a balanced maintenance diet.').
rule_text(whole_foods_balanced_diet, 'IF goal = healthy_eating THEN recommend a whole-foods balanced diet.').
rule_text(plant_based_protein_focus, 'IF diet is vegetarian or vegan THEN recommend plant-based protein sources.').
rule_text(lean_protein_focus, 'IF diet is omnivore and goal is weight_loss THEN prefer lean protein sources.').
rule_text(energy_dense_nutrition, 'IF activity is active and goal is weight_gain THEN recommend energy-dense nutritious foods.').
rule_text(careful_portion_control, 'IF activity is sedentary and goal is weight_loss THEN recommend smaller portions and whole-food choices.').
rule_text(reduce_processed_foods, 'IF low_sodium preference is enabled THEN reduce highly processed and high-sodium foods.').
rule_text(vegetable_volume, 'IF weight loss is the goal THEN increase vegetables and fiber-rich foods.').
rule_text(whole_grain_emphasis, 'IF the goal is weight loss or maintenance THEN emphasize whole grains and fiber.').
rule_text(healthy_fat_sources, 'IF healthy eating is the goal THEN emphasize fruits, vegetables, nuts, seeds and olive oil.').
rule_text(plant_protein_for_meals, 'IF the user follows a plant-based diet and has 3 meals THEN distribute protein across meals.').
rule_text(consistent_meal_timing, 'IF meal frequency is 3, 4 or 5 meals THEN maintain regular meals and snacks.').
rule_text(low_sugar_strategy, 'IF goal is weight_loss THEN reduce sugary drinks and processed snacks.').
rule_text(increased_hydration, 'IF activity is active or very active THEN advise higher daily hydration.').
rule_text(leaner_choices, 'IF diet is omnivore and goal is weight_loss THEN choose lean proteins and plenty of vegetables.').
rule_text(no_animal_product_recommendation, 'IF diet is vegan THEN avoid meat, fish, dairy and eggs.').
rule_text(fish_included, 'IF diet is pescatarian THEN include fish and plant proteins but avoid meat.').
rule_text(avoid_sugary_drinks, 'IF the goal is weight_loss THEN avoid sugar-sweetened drinks.').
rule_text(limit_processed_snacks, 'IF low_sodium is selected THEN limit processed snacks and convenience foods.').
rule_text(more_fruits_and_vegetables, 'IF healthy eating is the goal THEN increase fruits and vegetables.').

goal_conclusion(weight_loss, calorie_controlled_balanced_diet).
goal_conclusion(weight_gain, nutrient_dense_calorie_surplus).
goal_conclusion(weight_maintenance, balanced_maintenance_diet).
goal_conclusion(healthy_eating, whole_foods_balanced_diet).


