# Instala CLAUDE.md y skills globales en Windows
# Ejecutar: powershell -ExecutionPolicy Bypass -File install.ps1

$ClaudeDir = "$env:USERPROFILE\.claude"
$SkillsDir = "$ClaudeDir\skills"

Write-Host "Instalando configuracion de Claude Code..."

# Crear directorios si no existen
New-Item -ItemType Directory -Force -Path $SkillsDir | Out-Null

# Copiar CLAUDE.md global
Copy-Item -Force "CLAUDE.md" "$ClaudeDir\CLAUDE.md"
Write-Host "OK CLAUDE.md instalado en $ClaudeDir"

# Copiar skills
Get-ChildItem -Directory "skills" | ForEach-Object {
    $skillName = $_.Name
    $destDir = "$SkillsDir\$skillName"
    New-Item -ItemType Directory -Force -Path $destDir | Out-Null
    Copy-Item -Force "$($_.FullName)\SKILL.md" "$destDir\SKILL.md"
    Write-Host "  OK skill: $skillName"
}

Write-Host ""
Write-Host "Instalacion completa. Reinicia Claude Code para activar los cambios."
