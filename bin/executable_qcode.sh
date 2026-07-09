#! /usr/bin/env sh

if [ ! -f qcode.md ]; then
	printf "
# Problème:

# But:

# Entrées:

# Sorties attendues:

# Contraintes:

# Structures de données pertinentes:

# Sous-problèmes:

# Cas limites:

# Risques d'erreurs:

# Stratégie de tests:

" >qcode.md
fi
