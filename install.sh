#!/usr/bin/env bash
# Instala CLAUDE.md y skills globales en cualquier máquina Unix/Mac/WSL

CLAUDE_DIR="$HOME/.claude"
SKILLS_DIR="$CLAUDE_DIR/skills"

echo "Instalando configuración de Claude Code..."

# Crear directorios si no existen
mkdir -p "$SKILLS_DIR"

# Copiar CLAUDE.md global
cp CLAUDE.md "$CLAUDE_DIR/CLAUDE.md"
echo "✓ CLAUDE.md instalado en $CLAUDE_DIR"

# Copiar skills
for skill_dir in skills/*/; do
  skill_name=$(basename "$skill_dir")
  mkdir -p "$SKILLS_DIR/$skill_name"
  cp "$skill_dir/SKILL.md" "$SKILLS_DIR/$skill_name/SKILL.md"
  echo "  ✓ skill: $skill_name"
done

echo ""
echo "Instalación completa. Reinicia Claude Code para activar los cambios."
