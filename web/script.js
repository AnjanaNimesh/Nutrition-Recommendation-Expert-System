const form = document.getElementById('nutrition-form');
const errorBox = document.getElementById('error-box');
const resultsPanel = document.getElementById('results-panel');
const explanationPanel = document.getElementById('explanation-panel');

const setError = (message) => {
  errorBox.textContent = message;
  errorBox.classList.remove('hidden');
};

const clearError = () => {
  errorBox.textContent = '';
  errorBox.classList.add('hidden');
};

const renderList = (target, items) => {
  target.innerHTML = '';
  if (!items || items.length === 0) {
    const li = document.createElement('li');
    li.textContent = 'No specific items in this category.';
    target.appendChild(li);
    return;
  }
  items.forEach((item) => {
    const li = document.createElement('li');
    li.textContent = item;
    target.appendChild(li);
  });
};

const renderActiveTab = (tabName) => {
  const buttons = document.querySelectorAll('.tab-button');
  const contents = document.querySelectorAll('.tab-content');

  buttons.forEach((button) => {
    button.classList.toggle('active', button.dataset.tab === tabName);
  });
  contents.forEach((section) => {
    section.classList.toggle('active', section.id === `${tabName}-tab`);
  });
};

document.querySelectorAll('.tab-button').forEach((button) => {
  button.addEventListener('click', () => renderActiveTab(button.dataset.tab));
});

const validateInput = (data) => {
  if (!data.age || Number(data.age) < 10 || Number(data.age) > 120) {
    throw new Error('Age must be a number between 10 and 120.');
  }
  if (!data.height || Number(data.height) <= 0 || Number(data.height) > 300) {
    throw new Error('Height must be a positive value under 300 cm.');
  }
  if (!data.weight || Number(data.weight) <= 0 || Number(data.weight) > 300) {
    throw new Error('Weight must be a positive value under 300 kg.');
  }
  if (!data.activity) throw new Error('Please select an activity level.');
  if (!data.goal) throw new Error('Please select a goal.');
  if (!data.diet) throw new Error('Please select a dietary preference.');
  if (!data.meals || Number(data.meals) < 2 || Number(data.meals) > 5) {
    throw new Error('Meals must be between 2 and 5.');
  }
};

const renderData = (result) => {
  document.getElementById('bmi-value').textContent = `${Number(result.bmi).toFixed(2)} kg/m\u00B2`;
  document.getElementById('bmi-category').textContent = `Category: ${result.bmi_category}`;
  document.getElementById('bmr-value').textContent = `BMR: ${result.bmr} kcal/day`;
  document.getElementById('calorie-value').textContent = `Estimated daily calories: ${result.estimated_calories} kcal`;
  document.getElementById('overall-recommendation').textContent = result.recommendation_text || result.recommendation || 'No recommendation available';

  renderList(document.getElementById('foods-list'), result.foods || []);
  renderList(document.getElementById('limit-list'), result.foods_to_limit || []);
  renderList(document.getElementById('meal-list'), (result.meal_plan || []).map((meal) => meal.toString().replace(/_/g, ' ')));
  document.getElementById('hydration-value').textContent = result.hydration || 'Approximate hydration guidance not available';

  const macro = result.macronutrients || {};
  const macroItems = [
    `Protein: ${macro.protein || '-'} g/day`,
    `Carbohydrates: ${macro.carbohydrates || '-'} g/day`,
    `Fats: ${macro.fats || '-'} g/day`
  ];
  renderList(document.getElementById('macro-list'), macroItems);

  const forward = (result.forward_chain_trace || []).map((step) => {
    const conclusion = step.conclusion || step[0] || 'Conclusion';
    const rule = step.rule || step[1] || 'Rule';
    const conditions = step.conditions || step[2] || [];
    return `Fact/Conclusion: ${conclusion} | Rule: ${rule} | Conditions: ${Array.isArray(conditions) ? conditions.join(', ') : conditions}`;
  });
  const backward = (result.backward_chain_trace || []).map((step) => {
    const goal = step.goal || step[0] || 'Goal';
    const rule = step.rule || step[1] || 'Rule';
    const conditions = step.conditions || step[2] || [];
    return `Goal: ${goal} | Rule: ${rule} | Conditions: ${Array.isArray(conditions) ? conditions.join(', ') : conditions}`;
  });
  const explain = (result.explanations || []).map((step) => {
    return `${step.fact} \u2192 ${step.rule} \u2192 ${step.conclusion}`;
  });

  renderList(document.getElementById('forward-list'), forward);
  renderList(document.getElementById('backward-list'), backward);
  renderList(document.getElementById('explain-list'), explain);

  resultsPanel.classList.remove('hidden');
  explanationPanel.classList.remove('hidden');
};

form.addEventListener('submit', async (event) => {
  event.preventDefault();
  clearError();

  try {
    const payload = {
      age: Number(document.getElementById('age').value),
      gender: document.getElementById('gender').value,
      height: Number(document.getElementById('height').value),
      weight: Number(document.getElementById('weight').value),
      activity: document.getElementById('activity').value,
      goal: document.getElementById('goal').value,
      diet: document.getElementById('diet').value,
      meals: Number(document.getElementById('meals').value),
      low_sodium: document.getElementById('lowSodium').value === 'true'
    };

    validateInput(payload);

    const response = await fetch('http://localhost:8080/recommend', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload)
    });

    if (!response.ok) {
      const errorText = await response.text();
      throw new Error(`Server error: ${errorText}`);
    }

    const result = await response.json();
    renderData(result);
  } catch (error) {
    setError(error.message || 'Unable to generate recommendation.');
  }
});

renderActiveTab('forward');
