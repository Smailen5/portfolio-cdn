#!/bin/bash

echo "🔄 Commit e push dei cambiamenti..."

# Aggiunge tutta la cartella public/ (contiene tutto il contenuto della CDN)
git add public/
git commit -m "🔄 Sync files from monorepo - $(date '+%Y-%m-%d %H:%M:%S')"
git push

echo "✅ Commit e push completati"
