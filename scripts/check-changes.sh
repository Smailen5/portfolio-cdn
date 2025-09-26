#!/bin/bash

echo "🔄 Controllando per cambiamenti..."

# Controlla se ci sono modifiche ai file tracciati E nessun file nuovo
# git diff --quiet: exit code 0 = nessun diff, exit code 1 = ci sono modifiche
# git ls-files --others --exclude-standard: lista file nuovi non ignorati
# [ -z "$(...)" ]: true se la stringa è vuota (nessun file nuovo)
if git diff --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
  # Nessun cambiamento rilevato
  echo "changes=false" >> $GITHUB_OUTPUT
  echo "Nessun cambiamento rilevato"
else
  # Ci sono modifiche o file nuovi
  echo "changes=true" >> $GITHUB_OUTPUT
  echo "Cambiamenti rilevati, procedo con il commit"
fi

echo "✅ Controllo completato"
