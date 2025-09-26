# Portfolio CDN

Repository dedicata alla distribuzione dei file statici del portfolio tramite CDN Netlify.

## 🎯 Scopo

Questa repository serve come CDN per [smailenvargas.com](https://smailenvargas.com):

- `projects.json` - Dettagli di tutti i progetti con metadati completi
- Immagini di anteprima (`previews/`) - Screenshot ridimensionati per le card
- Immagini full size (`full/`) - Screenshot ad alta risoluzione per i dettagli
- Immagini screenshot (`screenshots/`) - Screenshot per i file readme

## 🏗️ Architettura

```
Frontend-Mentor-Challenge (Monorepo)
    ↓ (GitHub Actions)
Portfolio CDN (Questa repo)
    ↓ (Netlify Deploy)
CDN Globale (Netlify)
    ↓ (HTTP/HTTPS)
smailenvargas.com
```

## 🔄 Sincronizzazione Automatica

I file vengono sincronizzati automaticamente dalla monorepo principale tramite GitHub Actions quando:

- Viene fatto push su `main` della monorepo
- Vengono modificati file in `**/projects.json` o `**/images/previews/**`

## 📁 Struttura

```
public/
├── projects.json                # Dettagli progetti con metadati
└── images/
    ├── full/                    # Immagini ad alta risoluzione
    │   └── *.webp               # Screenshot full size
    ├── previews/                # Immagini di anteprima
    │   └── *.webp               # Screenshot ridimensionati
    └── screenshots/             # Immagini screenshot
        └── progetto-1/
            ├── desktop.jpeg     # Screenshot per il file readme
            └── smartphone.jpeg  # Screenshot per il file readme
```

### File di Configurazione

```
.github/workflows/
└── sync-files.yml               # Workflow principale di sincronizzazione

scripts/
├── check-changes.sh             # Script per controllare i cambiamenti
├── clone-monorepo.sh            # Script per clonare la monorepo
├── commit-push.sh               # Script per commitare e pushare i cambiamenti
├── copy-full-images.sh          # Script per copiare le immagini full size
├── copy-previews.sh             # Script per copiare le immagini di anteprima
├── copy-projects.sh             # Script per copiare il file projects.json
├── copy-screenshots.sh          # Script per copiare le immagini screenshot
├── create-folder.sh             # Script per creare la struttura delle cartelle
├── test-sync.sh                 # Script per testare la sincronizzazione
└── update-projects.sh           # Script per aggiornare il file projects.json

example/
└── trigger-cdn-sync.example.yml # Esempio di trigger per la sincronizzazione

netlify.toml                     # Configurazione Netlify
.gitignore                       # Esclude file temporanei
README.md                        # Documentazione
```

## ⚙️ Configurazione

### GitHub Actions

Per far funzionare la sincronizzazione, devi configurare:

1. **Nella monorepo**: Aggiungi lo step "Trigger CDN Sync" al workflow esistente (vedi esempio in `example/trigger-cdn-sync.example.yml`)
2. **Nella monorepo**: Aggiungi il token `CDN_REPO_TOKEN`, se lo rigeneri ricorda di aggiornarlo anche nelle altre monorepo che lo utilizzano
3. **In questa repo**: Il workflow `sync-files.yml` è già configurato (aggiornalo se hai bisogno di recuperare nuovi file)

### Netlify

La configurazione è già pronta in `netlify.toml`:

- Cache ottimizzata per immagini (1 anno)
- Cache per JSON (1 ora)
- Headers di sicurezza
- Redirect configurabili

## 🧪 Test e Utilizzo

### Test Locale

Per testare la sincronizzazione senza fare push su GitHub:

```bash
# Esegui il test
./scripts/test-sync.sh
```

Lo script:

1. Clona la monorepo `Frontend-Mentor-Challenge`
2. Copia `projects.json` e le immagini
3. Pulisce i file temporanei
4. Mostra il risultato

### Trigger Automatico

La sincronizzazione si attiva automaticamente quando:

- Viene fatto push su `main` della monorepo (Frontend-Mentor-Challenge)
- Vengono modificati file in `**/projects.json`
- Vengono modificate immagini in `**/screen-capture/**`

## 🔧 Manutenzione

### Aggiornamenti Automatici

- I file vengono aggiornati automaticamente ad ogni push della monorepo
- La cache di Netlify si invalida automaticamente
- Le immagini vengono sostituite completamente ad ogni sincronizzazione

## 🌐 URL del CDN

Una volta deployato su Netlify, i file saranno disponibili su:

```
https://portfolio-cdn.netlify.app/projects.json || https://portfolio-cdn.netlify.app/
https://portfolio-cdn.netlify.app/images/previews/[nome-progetto].webp
https://portfolio-cdn.netlify.app/images/full/[nome-progetto].webp
https://portfolio-cdn.netlify.app/images/screenshots/[nome-progetto]/desktop.jpeg
```

### Esempio di utilizzo nel frontend:

```javascript
// Carica i progetti
const response = await fetch('https://portfolio-cdn.netlify.app/projects.json');
const projects = await response.json();

// Carica immagine di anteprima
const imageUrl = `https://portfolio-cdn.netlify.app/images/previews/${project.name}.webp`;

// Carica immagine full size
const fullImageUrl = `https://portfolio-cdn.netlify.app/images/full/${project.name}.webp`;
```

## 📝 Note

- Tutti i file sono serviti con cache ottimizzata
- Le immagini sono in formato WebP per performance migliori
- Il sistema è completamente automatizzato
- Supporta sia trigger manuali che automatici
