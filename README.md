# Portfolio CDN

Repository dedicata alla distribuzione dei file statici del portfolio tramite CDN Netlify.

## 🎯 Scopo

Questa repository serve come CDN per:

- `projects.json` - Dettagli di tutti i progetti con metadati completi
- Immagini di anteprima (`previews/`) - Screenshot ridimensionati per le card
- Immagini full size (`full/`) - Screenshot ad alta risoluzione per i dettagli

## 🏗️ Architettura

```
Frontend-Mentor-Challenge (Monorepo)
    ↓ (GitHub Actions)
Portfolio CDN (Questa repo)
    ↓ (Netlify Deploy)
CDN Globale (Netlify)
    ↓ (HTTP/HTTPS)
Applicazioni Frontend
```

## 🔄 Sincronizzazione Automatica

I file vengono sincronizzati automaticamente dalla monorepo principale tramite GitHub Actions quando:

- Viene fatto push su `main` della monorepo
- Vengono modificati file in `**/projects.json` o `**/images/previews/**`

## 📁 Struttura

```
public/
├── projects.json          # Dettagli progetti con metadati
└── images/
    ├── full/              # Immagini ad alta risoluzione
    │   ├── .gitkeep       # Mantiene la cartella su Git
    │   └── *.webp         # Screenshot full size
    └── previews/          # Immagini di anteprima
        ├── .gitkeep       # Mantiene la cartella su Git
        └── *.webp         # Screenshot ridimensionati
```

### File di Configurazione

```
.github/workflows/
├── sync-files.yml         # Workflow principale di sincronizzazione
└── trigger-cdn-sync.yml   # Workflow per triggerare la sincronizzazione

netlify.toml               # Configurazione Netlify
.gitignore                 # Esclude file temporanei
test-sync.sh              # Script di test locale
```

## ⚙️ Configurazione

### GitHub Actions

Per far funzionare la sincronizzazione, devi configurare:

1. **Nella monorepo**: Aggiungi lo step "Trigger CDN Sync" al workflow esistente (vedi esempio in `trigger-cdn-sync.yml`)
2. **In questa repo**: Il workflow `sync-files.yml` è già configurato (aggiornalo se hai bisogno di recuperare nuovi file)
3. **Token**: Crea un Personal Access Token con permessi di repository e aggiungilo come `CDN_REPO_TOKEN` nella monorepo (ne esiste gia uno, rigeneralo se necessario, aggiorna tutte le monorepo che lo utilizzano)

#### Configurazione Token

1. Vai su GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Crea un nuovo token con scope `repo`
3. Nella monorepo, vai su Settings → Secrets and variables → Actions
4. Aggiungi: `CDN_REPO_TOKEN` = [il tuo token]

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
./test-sync.sh
```

Lo script:

1. Clona la monorepo `Frontend-Mentor-Challenge`
2. Copia `projects.json` e le immagini
3. Pulisce i file temporanei
4. Mostra il risultato

### Test su GitHub Actions

Per testare manualmente la sincronizzazione:

1. Vai su **Actions** → **"Sync Files from Monorepo"**
2. Clicca **"Run workflow"**
3. Seleziona il branch della monorepo da sincronizzare
4. Clicca **"Run workflow"**

### Trigger Automatico

La sincronizzazione si attiva automaticamente quando:

- Viene fatto push su `main` della monorepo
- Vengono modificati file in `**/projects.json`
- Vengono modificate immagini in `**/screen-capture/**`

## 📊 Monitoraggio

- **GitHub Actions**: Monitora i workflow per errori
- **Netlify**: Dashboard per performance e deploy
- **CDN**: Cache hit rate e latenza

## 🔧 Manutenzione

### Aggiornamenti Automatici

- I file vengono aggiornati automaticamente ad ogni push della monorepo
- La cache di Netlify si invalida automaticamente
- Le immagini vengono sostituite completamente ad ogni sincronizzazione

## 🌐 URL del CDN

Una volta deployato su Netlify, i file saranno disponibili su:

```
https://[nome-sito].netlify.app/projects.json
https://[nome-sito].netlify.app/images/previews/[nome-progetto].webp
https://[nome-sito].netlify.app/images/full/[nome-progetto].webp
```

### Esempio di utilizzo nel frontend:

```javascript
// Carica i progetti
const response = await fetch('https://[nome-sito].netlify.app/projects.json');
const projects = await response.json();

// Carica immagine di anteprima
const imageUrl = `https://[nome-sito].netlify.app/images/previews/${project.name}.webp`;

// Carica immagine full size
const fullImageUrl = `https://[nome-sito].netlify.app/images/full/${project.name}.webp`;
```

## 📝 Note

- Tutti i file sono serviti con cache ottimizzata
- Le immagini sono in formato WebP per performance migliori
- Il sistema è completamente automatizzato
- Supporta sia trigger manuali che automatici
