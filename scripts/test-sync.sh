#!/bin/bash

echo "🧪 Test locale della sincronizzazione CDN"
echo "========================================"

# Configurazione
MONOREPO_NAME="Frontend-Mentor-Challenge"
MONOREPO_OWNER="Smailen5"

echo "📁 Clonando monorepo: $MONOREPO_NAME"
# Pulisce la cartella temporanea se esiste
if [ -d "temp-monorepo" ]; then
    rm -rf temp-monorepo
fi

# Clona la monorepo
git clone https://github.com/$MONOREPO_OWNER/$MONOREPO_NAME.git temp-monorepo
cd temp-monorepo
git checkout main
cd ..

echo "✅ Monorepo clonata"

# Copia il file projects.json
echo "📁 Copiando projects.json"
cp temp-monorepo/public/projects.json public/

# Aggiorna i link delle immagini per usare la CDN
echo "🔄 Aggiornando imageUrl per CDN..."
node -e "
const fs = require('fs');
const projects = JSON.parse(fs.readFileSync('public/projects.json', 'utf8'));

projects.forEach(project => {
  const projectName = project.nameFolder;
  project.imageUrl = \`https://portfolio-cdn.netlify.app/images/previews/\${projectName}.webp\`;
});

fs.writeFileSync('public/projects.json', JSON.stringify(projects, null, 2));
console.log('✅ Link immagini aggiornati per CDN');
"

echo "✅ projects.json copiato e aggiornato"

echo "📸 Copiando immagini full size"
mkdir -p public/images/full
cp -r temp-monorepo/screen-capture/full-images/* public/images/full/ 2>/dev/null || echo "⚠️ Nessuna immagine full trovata"
echo "✅ Immagini full copiate"

echo "📸 Copiando immagini di anteprima"
mkdir -p public/images/previews
cp -r temp-monorepo/screen-capture/preview/* public/images/previews/ 2>/dev/null || echo "⚠️ Nessuna immagine di anteprima trovata"
echo "✅ Immagini preview copiate"

echo "🧹 Pulizia"
rm -rf temp-monorepo

echo "✅ Test completato!"
echo "📁 Controlla i file in public/"
ls -la public/
echo ""
echo "📸 Controlla le immagini:"
ls -la public/images/
