# Diet/Nutrition Recommendation Expert System

## Project Overview
This project implements a rule-based expert system for general nutrition recommendations using SWI-Prolog and a lightweight HTML/CSS/JavaScript frontend. The system uses predefined facts and rules to derive BMI, BMR, energy needs, food suggestions, meal structure, hydration guidance, and explanation traces.

## Features
- BMI calculation and classification in Prolog
- Mifflin-St Jeor style calorie estimation
- Goal-based nutrition advice
- Dietary preference handling
- Meal frequency recommendations
- Foods-to-limit guidance
- Forward chaining trace
- Backward chaining trace
- Explanation facility
- Local web UI and JSON API
- Prolog test suite

## Technologies
- SWI-Prolog 10+
- HTML5
- CSS3
- Vanilla JavaScript
- HTTP JSON API in Prolog

## Project Structure
- prolog/main.pl - HTTP server and API handler
- prolog/knowledge_base.pl - fact and rule loader
- prolog/facts.pl - nutrition and user-domain facts
- prolog/rules.pl - rule catalogue and rule text
- prolog/inference.pl - BMI, calorie, forward/backward chaining and recommendation logic
- prolog/explanation.pl - explanation generation
- web/index.html - dashboard UI
- web/style.css - layout and styling
- web/script.js - validation and communication logic
- tests/test_cases.pl - Prolog unit tests

## Requirements
Install SWI-Prolog from the official project website or package manager.

## Installation
1. Download and install SWI-Prolog for Windows from https://www.swi-prolog.org/
2. Confirm the installation with:
   swipl --version
3. Open a terminal in the project root.

## Running the Application
Start the backend server:

swipl -q -s prolog/main.pl

Then open the frontend in a browser at:

http://localhost:8080/

If you want to serve the web files locally, copy or host the web folder with a static web server. For a simple local workflow, use a local web server such as Python's http.server or a browser file open, but ensure the fetch calls point to the Prolog server.

## How to Use
1. Open the application.
2. Enter personal information.
3. Select activity level.
4. Select goal.
5. Select diet preference.
6. Click Generate Recommendation.
7. Review the recommendation cards.
8. Review explanation, forward chaining, and backward chaining traces.

## Testing
Run the Prolog test suite with:

swipl -q -s tests/test_cases.pl

