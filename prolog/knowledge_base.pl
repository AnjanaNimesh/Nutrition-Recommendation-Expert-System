% Expert-system database loader.
% Works whether the current working directory is the project root or the prolog subdirectory.
:- if(exists_file('prolog/facts.pl')).
	:- consult('prolog/facts.pl').
:- elif(exists_file('facts.pl')).
	:- consult('facts.pl').
:- else.
	:- absolute_file_name('prolog/facts.pl', FactsPath), consult(FactsPath).
:- endif.

:- if(exists_file('prolog/rules.pl')).
	:- consult('prolog/rules.pl').
:- elif(exists_file('rules.pl')).
	:- consult('rules.pl').
:- else.
	:- absolute_file_name('prolog/rules.pl', RulesPath), consult(RulesPath).
:- endif.

:- if(exists_file('prolog/inference.pl')).
	:- consult('prolog/inference.pl').
:- elif(exists_file('inference.pl')).
	:- consult('inference.pl').
:- else.
	:- absolute_file_name('prolog/inference.pl', InferencePath), consult(InferencePath).
:- endif.

:- if(exists_file('prolog/explanation.pl')).
	:- consult('prolog/explanation.pl').
:- elif(exists_file('explanation.pl')).
	:- consult('explanation.pl').
:- else.
	:- absolute_file_name('prolog/explanation.pl', ExplanationPath), consult(ExplanationPath).
:- endif.

% This file centralizes the domain facts and the reasoning engine.
