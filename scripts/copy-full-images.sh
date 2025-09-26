#!/bin/bash

echo "📸 Copiando immagini full..."

# Pulisce la cartella full da file orfani
find public/images/full/ -name "*.webp" -delete 2>/dev/null || true

# Copia tutte le immagini in full
cp temp-monorepo/screen-capture/full/*.webp public/images/full/ 2>/dev/null || echo "⚠️ Nessuna immagine full"

echo "✅ Immagini full copiate"
