activity_level(sedentary).
activity_level(light).
activity_level(moderate).
activity_level(active).
activity_level(very_active).

goal(weight_loss).
goal(weight_maintenance).
goal(weight_gain).
goal(healthy_eating).

diet_type(omnivore).
diet_type(vegetarian).
diet_type(vegan).
diet_type(pescatarian).

food(oats).
food(brown_rice).
food(quinoa).
food(vegetables).
food(fruits).
food(lentils).
food(beans).
food(tofu).
food(nuts).
food(seeds).
food(leafy_greens).
food(sweet_potato).
food(whole_grains).
food(olive_oil).
food(yogurt).
food(eggs).
food(chicken).
food(fish).
food(legumes).
food(berries).
food(avocado).
food(greek_yogurt).

meal_count(2).
meal_count(3).
meal_count(4).
meal_count(5).

food_to_limit(sugary_drinks).
food_to_limit(highly_processed_foods).
food_to_limit(fried_foods).
food_to_limit(excessive_added_sugar).
food_to_limit(high_sodium_processed_foods).
food_to_limit(energy_drinks).

meal_structure(2, [breakfast, lunch]).
meal_structure(3, [breakfast, lunch, dinner]).
meal_structure(4, [breakfast, snack, lunch, dinner]).
meal_structure(5, [breakfast, morning_snack, lunch, evening_snack, dinner]).

calorie_multiplier(sedentary, 1.2).
calorie_multiplier(light, 1.375).
calorie_multiplier(moderate, 1.55).
calorie_multiplier(active, 1.725).
calorie_multiplier(very_active, 1.9).

bmi_category(underweight, 'underweight').
bmi_category(normal, 'normal').
bmi_category(overweight, 'overweight').
bmi_category(obesity, 'obesity').

hydration_guideline(sedentary, '2.0-2.5 liters per day').
hydration_guideline(light, '2.0-2.5 liters per day').
hydration_guideline(moderate, '2.2-3.0 liters per day').
hydration_guideline(active, '2.5-3.5 liters per day').
hydration_guideline(very_active, '2.8-3.8 liters per day').

protein_target(weight_loss, 1.2).
protein_target(weight_maintenance, 1.3).
protein_target(weight_gain, 1.4).
protein_target(healthy_eating, 1.2).

carb_target(weight_loss, 0.45).
carb_target(weight_maintenance, 0.5).
carb_target(weight_gain, 0.55).
carb_target(healthy_eating, 0.5).

fat_target(weight_loss, 0.25).
fat_target(weight_maintenance, 0.3).
fat_target(weight_gain, 0.3).
fat_target(healthy_eating, 0.3).

recommended_food(omnivore, chicken).
recommended_food(omnivore, fish).
recommended_food(omnivore, eggs).
recommended_food(omnivore, yogurt).
recommended_food(vegetarian, lentils).
recommended_food(vegetarian, beans).
recommended_food(vegetarian, tofu).
recommended_food(vegetarian, nuts).
recommended_food(vegetarian, eggs).
recommended_food(vegetarian, yogurt).
recommended_food(vegan, lentils).
recommended_food(vegan, beans).
recommended_food(vegan, tofu).
recommended_food(vegan, nuts).
recommended_food(vegan, seeds).
recommended_food(vegan, leafy_greens).
recommended_food(pescatarian, fish).
recommended_food(pescatarian, lentils).
recommended_food(pescatarian, tofu).
recommended_food(pescatarian, yogurt).

food_group(whole_grains, oats).
food_group(whole_grains, brown_rice).
food_group(whole_grains, quinoa).
food_group(vegetables, vegetables).
food_group(vegetables, leafy_greens).
food_group(fruits, fruits).
food_group(fruits, berries).
food_group(plant_protein, lentils).
food_group(plant_protein, beans).
food_group(plant_protein, tofu).
food_group(healthy_fats, nuts).
food_group(healthy_fats, seeds).
food_group(healthy_fats, olive_oil).
food_group(healthy_fats, avocado).

low_sodium_preference(true).
low_sodium_preference(false).

preference(vegetarian).
preference(vegan).
preference(low_sodium).
preference(gluten_free).
preference(high_protein).

healthy_food(oats).
healthy_food(brown_rice).
healthy_food(quinoa).
healthy_food(vegetables).
healthy_food(fruits).
healthy_food(lentils).
healthy_food(beans).
healthy_food(tofu).
healthy_food(nuts).
healthy_food(seeds).
healthy_food(leafy_greens).
healthy_food(sweet_potato).
healthy_food(olive_oil).
healthy_food(berries).
healthy_food(avocado).

