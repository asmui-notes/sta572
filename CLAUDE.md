# STA572: Workflow for Modifying Files

**Project directory:** `/Users/asmuie/sta572 Rprog/sta572/`
**GitHub Pages:** `https://asmuie-analytics.github.io/sta572/`
**Repository:** `git@github.com:asmuie-analytics/sta572.git`

---

## ⚠️ Golden Rules

1. **Never run bare `quarto render`** — it uses the freeze cache and deletes `_files/` folders without regenerating them, breaking all plots on GitHub Pages.
2. **Always render chapter by chapter** using the individual commands below.
3. **Always check `docs/.nojekyll` is still present** after rendering (`ls docs/.nojekyll`). If missing, run `touch docs/.nojekyll` before committing.
4. **Always include the `_files/` folder** in `git add` — without it, plots are broken on GitHub Pages.
5. **If plots break again** — delete the chapter's `_freeze/` folder and re-render.

---

## Chapter 1 — Introduction to Time Series

**File:** `C1 Intro to time series.qmd`
**Data used:** `data/electric.csv`, `data/CPI Malaysia.csv`

```bash
# Step 1: Edit the file in RStudio or VS Code
# /Users/asmuie/sta572 Rprog/sta572/C1 Intro to time series.qmd

# Step 2: Render
cd "/Users/asmuie/sta572 Rprog/sta572"
quarto render "C1 Intro to time series.qmd"

# Step 3: Check output locally
# Open: docs/C1 Intro to time series.html

# Step 4: Stage, commit, push
git add "C1 Intro to time series.qmd"
git add "docs/C1 Intro to time series.html"
git add "docs/C1-Intro-to-time-series_files/"
git add "_freeze/C1 Intro to time series/"
git add "docs/search.json"
git commit -m "Update C1: describe what you changed"
git push origin main
```

---

## Chapter 2 — Univariate Modelling Techniques

**File:** `C2 Univariate Modelling Techniques.qmd`
**Data used:** `data/CPI Malaysia.csv`, `data/electric.csv`

```bash
# Step 1: Edit the file in RStudio or VS Code
# /Users/asmuie/sta572 Rprog/sta572/C2 Univariate Modelling Techniques.qmd

# Step 2: Render
cd "/Users/asmuie/sta572 Rprog/sta572"
quarto render "C2 Univariate Modelling Techniques.qmd"

# Step 3: Check output locally
# Open: docs/C2 Univariate Modelling Techniques.html

# Step 4: Stage, commit, push
git add "C2 Univariate Modelling Techniques.qmd"
git add "docs/C2 Univariate Modelling Techniques.html"
git add "docs/C2-Univariate-Modelling-Techniques_files/"
git add "_freeze/C2 Univariate Modelling Techniques/"
git add "docs/search.json"
git commit -m "Update C2: describe what you changed"
git push origin main
```

---

## Chapter 3 — Econometric Modelling

**File:** `C3 Econometric Modelling.qmd`
**Data used:** `data/economic data.csv`

```bash
# Step 1: Edit the file in RStudio or VS Code
# /Users/asmuie/sta572 Rprog/sta572/C3 Econometric Modelling.qmd

# Step 2: Render
cd "/Users/asmuie/sta572 Rprog/sta572"
quarto render "C3 Econometric Modelling.qmd"

# Step 3: Check output locally
# Open: docs/C3 Econometric Modelling.html

# Step 4: Stage, commit, push
git add "C3 Econometric Modelling.qmd"
git add "docs/C3 Econometric Modelling.html"
git add "docs/C3-Econometric-Modelling_files/"
git add "_freeze/C3 Econometric Modelling/"
git add "docs/search.json"
git commit -m "Update C3: describe what you changed"
git push origin main
```

---

## Chapter 4 — Stochastic Process

**File:** `C4 Stochastic Process.qmd`
**Data used:** `data/CPI Malaysia.csv`

```bash
# Step 1: Edit the file in RStudio or VS Code
# /Users/asmuie/sta572 Rprog/sta572/C4 Stochastic Process.qmd

# Step 2: Render
cd "/Users/asmuie/sta572 Rprog/sta572"
quarto render "C4 Stochastic Process.qmd"

# Step 3: Check output locally
# Open: docs/C4 Stochastic Process.html

# Step 4: Stage, commit, push
git add "C4 Stochastic Process.qmd"
git add "docs/C4 Stochastic Process.html"
git add "docs/C4-Stochastic-Process_files/"
git add "_freeze/C4 Stochastic Process/"
git add "docs/search.json"
git commit -m "Update C4: describe what you changed"
git push origin main
```

---

## Chapter 5 — Box-Jenkins Methodology

**File:** `C5 BoxJenkins.qmd`
**Data used:** `data/ipi_1d.csv` (IPI Malaysia), S&P 500 via `quantmod::getSymbols("ES=F")`

```bash
# Step 1: Edit the file in RStudio or VS Code
# /Users/asmuie/sta572 Rprog/sta572/C5 BoxJenkins.qmd

# Step 2: Render
cd "/Users/asmuie/sta572 Rprog/sta572"
quarto render "C5 BoxJenkins.qmd"

# Step 3: Check output locally
# Open: docs/C5 BoxJenkins.html

# Step 4: Stage, commit, push
git add "C5 BoxJenkins.qmd"
git add "docs/C5 BoxJenkins.html"
git add "docs/C5-BoxJenkins_files/"
git add "_freeze/C5 BoxJenkins/"
git add "docs/search.json"
git commit -m "Update C5: describe what you changed"
git push origin main
```

---

## Home Page (index)

**File:** `index.qmd`

```bash
# Step 1: Edit the file
# /Users/asmuie/sta572 Rprog/sta572/index.qmd

# Step 2: Render
cd "/Users/asmuie/sta572 Rprog/sta572"
quarto render "index.qmd"

# Step 3: Stage, commit, push
git add "index.qmd"
git add "docs/index.html"
git add "docs/search.json"
git commit -m "Update index: describe what you changed"
git push origin main
```

---

## Site Configuration (_quarto.yml)

**File:** `_quarto.yml` — controls navbar, theme, footer, output directory.

```bash
# After editing _quarto.yml, re-render ALL chapters individually:
cd "/Users/asmuie/sta572 Rprog/sta572"

rm -rf "_freeze/C1 Intro to time series"
quarto render "C1 Intro to time series.qmd"

rm -rf "_freeze/C2 Univariate Modelling Techniques"
quarto render "C2 Univariate Modelling Techniques.qmd"

rm -rf "_freeze/C3 Econometric Modelling"
quarto render "C3 Econometric Modelling.qmd"

rm -rf "_freeze/C4 Stochastic Process"
quarto render "C4 Stochastic Process.qmd"

rm -rf "_freeze/C5 BoxJenkins"
quarto render "C5 BoxJenkins.qmd"

quarto render "index.qmd"

# Verify .nojekyll is present
ls docs/.nojekyll

# Stage everything and push
git add _quarto.yml index.qmd
git add "C1 Intro to time series.qmd" "C2 Univariate Modelling Techniques.qmd"
git add "C3 Econometric Modelling.qmd" "C4 Stochastic Process.qmd" "C5 BoxJenkins.qmd"
git add docs/ _freeze/
git commit -m "Update site config: describe what you changed"
git push origin main
```

---

## Quick Reference

| Chapter | QMD File | HTML Output | Figures Folder | Freeze Folder |
|---------|----------|-------------|----------------|---------------|
| C1 | `C1 Intro to time series.qmd` | `docs/C1 Intro to time series.html` | `docs/C1-Intro-to-time-series_files/` | `_freeze/C1 Intro to time series/` |
| C2 | `C2 Univariate Modelling Techniques.qmd` | `docs/C2 Univariate Modelling Techniques.html` | `docs/C2-Univariate-Modelling-Techniques_files/` | `_freeze/C2 Univariate Modelling Techniques/` |
| C3 | `C3 Econometric Modelling.qmd` | `docs/C3 Econometric Modelling.html` | `docs/C3-Econometric-Modelling_files/` | `_freeze/C3 Econometric Modelling/` |
| C4 | `C4 Stochastic Process.qmd` | `docs/C4 Stochastic Process.html` | `docs/C4-Stochastic-Process_files/` | `_freeze/C4 Stochastic Process/` |
| C5 | `C5 BoxJenkins.qmd` | `docs/C5 BoxJenkins.html` | `docs/C5-BoxJenkins_files/` | `_freeze/C5 BoxJenkins/` |

---

## Troubleshooting: Plots Missing on GitHub Pages

```bash
cd "/Users/asmuie/sta572 Rprog/sta572"

# 1. Delete the freeze cache for the affected chapter
rm -rf "_freeze/C1 Intro to time series"   # change to affected chapter

# 2. Re-render
quarto render "C1 Intro to time series.qmd"

# 3. Verify figures were generated
find docs/ -name "*.png" | grep "C1"

# 4. Restore .nojekyll if missing
touch docs/.nojekyll

# 5. Commit and push
git add "docs/C1 Intro to time series.html"
git add "docs/C1-Intro-to-time-series_files/"
git add "_freeze/C1 Intro to time series/"
git add "docs/.nojekyll"
git add "docs/search.json"
git commit -m "Fix C1: restore missing figure files"
git push origin main
```

---

## Data Files

All datasets are in `data/` and available at:
`https://github.com/asmuie-analytics/sta572/tree/main/data`

| File | Used In |
|------|---------|
| `data/CPI Malaysia.csv` | C1, C2, C4 |
| `data/electric.csv` | C1, C2 |
| `data/economic data.csv` | C3 |
| `data/ipi_1d.csv` | C5 (SARIMA) |
| `data/SNP500.csv` | C5 (non-seasonal, legacy) |

---

cd "/Users/asmuie/sta572 Rprog/sta572"

# Clear ALL freeze caches first
rm -rf "_freeze/C1 Intro to time series"
rm -rf "_freeze/C2 Univariate Modelling Techniques"
rm -rf "_freeze/C3 Econometric Modelling"
rm -rf "_freeze/C4 Stochastic Process"
rm -rf "_freeze/C5 BoxJenkins"

# Render each chapter individually
quarto render "C1 Intro to time series.qmd"
quarto render "C2 Univariate Modelling Techniques.qmd"
quarto render "C3 Econometric Modelling.qmd"
quarto render "C4 Stochastic Process.qmd"
quarto render "C5 BoxJenkins.qmd"
quarto render "index.qmd"

# Verify .nojekyll is still there
ls docs/.nojekyll

# Stage everything
git add docs/ _freeze/
git add C1\ Intro\ to\ time\ series.qmd
git add C2\ Univariate\ Modelling\ Techniques.qmd
git add C3\ Econometric\ Modelling.qmd
git add C4\ Stochastic\ Process.qmd
git add C5\ BoxJenkins.qmd
git add index.qmd docs/search.json

# Commit and push
git commit -m "Re-render all chapters"
git push origin main

*Last updated: April 2026*
