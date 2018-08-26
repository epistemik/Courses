% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only


% PET.PL

%
% Contains a CONMAN knowledge base.
% Requires all utility procedures defined in file CONMAN.PL
%

:- ensure_loaded(conman).

%
% Any previously defined clauses for the predicates KB_INTRO,
% KB_THRESHOLD, KB_HYPOTHESIS, C_RULE, and KB_CAN_ASK should
% be removed from the knowledge base before loading the
% clauses below.
%

:- abolish(kb_intro/1).
:- abolish(kb_threshold/1).    % Should use retractall   
:- abolish(kb_hypothesis/1).   % instead of abolish      
:- abolish(c_rule/4).          % in some implementations 
:- abolish(kb_can_ask/1).      % of Prolog               

kb_intro(['',
          'Feeding Your Pet:',
          'A Whimsical Knowledge Base for CONMAN',
          '']).

kb_threshold(64).

kb_hypothesis('Your pet is a carnivore.').
kb_hypothesis('Your pet is a herbivore.').
kb_hypothesis('Feed your pet nerds.').
kb_hypothesis('Feed dog food to your pet.').
kb_hypothesis('Feed your aunt''s fern to your pet.').
kb_hypothesis('My pet is a carnivore.  Feed your pet to my pet.').

c_rule('Your pet is a carnivore.',
        100,
        [],
        [and,['Your pet has sharp claws.',yes],
             ['Your pet has sharp, pointed teeth.',yes]]).

c_rule('Your pet is a carnivore.',
        85,
        [],
        ['Your pet has sharp claws.',yes]).

c_rule('Your pet is a herbivore.',
        100,
        [],
        [and,['Your pet has sharp claws.',no],
             ['Your pet has sharp, pointed teeth.',no]]).

c_rule('Your pet is a carnivore.',
        85,
        [],
        ['Your pet has sharp, pointed teeth.',yes]).

c_rule('Feed your pet nerds.',
        100,
        ['Your pet is a carnivore.'],
        [or,['Nerds are available at a low price.',yes],
            ['Dog food is available at a low price.',no]]).

c_rule('Feed dog food to your pet.',
        100,
        ['Your pet is a carnivore.'],
        [and,['Dog food is available at a low price.',yes],
             ['Nerds are available at a low price.',no]]).

c_rule('Feed your aunt''s fern to your pet.',
        100,
        ['Your pet is a herbivore.'],
        ['Your aunt has a fern.',yes]).

c_rule('My pet is a carnivore.  Feed your pet to my pet.',
        100,
        ['Your pet is a herbivore.'],
        ['Your aunt has a fern.',no]).

kb_can_ask('Nerds are available at a low price.').
kb_can_ask('Dog food is available at a low price.').
kb_can_ask('Your pet has sharp claws.').
kb_can_ask('Your pet has sharp, pointed teeth.').
kb_can_ask('Your aunt has a fern.').

:- write('Type   conman.  to start.'), nl.


