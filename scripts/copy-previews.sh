#!/bin/bash

echo "📸 Copiando immagini preview..."

# Pulisce la cartella previews da file orfani
find public/images/previews/ -name "*.webp" -delete 2>/dev/null || true

cp temp-monorepo/screen-capture/preview/*.webp public/images/previews/ 2>/dev/null || echo "⚠️ Nessuna immagine preview"

echo "✅ Immagini preview copiate"
