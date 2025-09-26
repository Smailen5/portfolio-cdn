#!/bin/bash

echo "📸 Copiando immagini screenshot..."

# Pulisce la cartella screenshots da file orfani
find public/images/screenshots/* -delete 2>/dev/null || true

# Copia ricorsivamente tutta la cartella screenshots
cp -r temp-monorepo/screen-capture/screenshots/* public/images/screenshots/ 2>/dev/null || echo "⚠️ Nessuna immagine screenshot"

echo "✅ Immagini screenshot copiate"
