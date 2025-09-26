#!/bin/bash

echo "🔄 Aggiornando projects.json..."

node -e "
const fs = require('fs');
const projects = JSON.parse(fs.readFileSync('public/projects.json', 'utf8'));

projects.forEach(project =>{
// Estrae il nome del progetto dal file projects.json
const projectName = projects.nameFolder;

// Sovrascrive il link dell'immagine con il link della CDN
project.imageUrl = `https://portfolio-cdn.netlify.app/images/previews/\${projectName}.webp\`;
});

// Sovrascrive il file projects.json
fs.writeFileSync('public/projects.json', JSON.stringify(projects, null, 2));
"

echo "✅ projects.json aggiornato"
