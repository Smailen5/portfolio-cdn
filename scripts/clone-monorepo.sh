#!/bin/bash

# Trigger manuale
if [ "$GITHUB_EVENT_NAME" = "workflow_dispatch" ]; then
MONOREPO_NAME="Frontend-Mentor-Challenge"
MONOREPO_OWNER="Smailen5"
BRANCH="main"
else
# Trigger automatico, utilizza il payload
MONOREPO_NAME="$MONOREPO_NAME"
MONOREPO_OWNER="$MONOREPO_OWNER"
BRANCH="$$BRANCH"

echo "📁 Clonando monorepo: $MONOREPO_OWNER/$MONOREPO_NAME"
echo "Branch: $BRANCH"

git clone https://github.com/$MONOREPO_OWNER/$MONOREPO_NAME.git temp-monorepo
cd temp-monorepo
git checkout $BRANCH
echo "✅ Monorepo clonato e checkout completato"
