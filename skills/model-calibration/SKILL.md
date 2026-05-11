---
name: model-calibration
description: >
  Use this skill whenever a classification model is being built, evaluated, or deployed in any project.
  Triggers include: training a classifier, evaluating model performance, building a prediction pipeline,
  deploying a probabilistic model, or any mention of softmax outputs, confidence scores, predict_proba,
  or probability thresholds. Also trigger when the user asks about model reliability, overconfidence,
  decision thresholds, or risk-based decisions (medical, financial, fraud, etc.).
  ALWAYS include calibration measurement and correction as part of any classification project — do not
  treat it as optional. If the user is building any sklearn, PyTorch, or XGBoost classifier, this skill applies.
---

# Model Calibration Skill

Calibration ensures that a model's predicted probabilities correspond to real-world frequencies.
A model predicting 80% confidence should be correct ~80% of the time. Softmax outputs do NOT
guarantee this — they rank, but they don't calibrate.

**Always apply this skill as a final step in any classification pipeline.**

---

## Quick Reference

| Task | Method |
|------|--------|
| Measure calibration | ECE + reliability diagram |
| Test if calibration is needed | Spiegelhalter Z ( \|Z\| > 1.96 → fix ) |
| Fix: simple, fast | Temperature Scaling |
| Fix: binary problems | Platt Scaling |
| Fix: flexible, non-parametric | Isotonic Regression |
| Fix: distribution-free bounds | Venn-Abers Predictors |
| Verify after fixing | Check refinement is preserved |

---

## Step 1 — Measure

Always compute calibration on a **held-out validation set**, never on training data.

```python
import numpy as np
import matplotlib.pyplot as plt
from sklearn.calibration import calibration_curve

def plot_reliability_diagram(y_true, y_prob, n_bins=10, model_name="Model"):
    """Reliability diagram (calibration curve)."""
    prob_true, prob_pred = calibration_curve(y_true, y_prob, n_bins=n_bins)
    
    fig, ax = plt.subplots(figsize=(6, 6))
    ax.plot([0, 1], [0, 1], "k--", label="Perfect calibration")
    ax.plot(prob_pred, prob_true, "s-", label=model_name)
    ax.set_xlabel("Mean predicted probability")
    ax.set_ylabel("Fraction of positives")
    ax.set_title("Reliability Diagram")
    ax.legend()
    plt.tight_layout()
    plt.savefig("calibration_curve.png", dpi=150)
    plt.show()

def expected_calibration_error(y_true, y_prob, n_bins=10):
    """ECE — lower is better. Rule of thumb: ECE > 0.05 warrants correction."""
    bins = np.linspace(0, 1, n_bins + 1)
    ece = 0.0
    for i in range(n_bins):
        mask = (y_prob >= bins[i]) & (y_prob < bins[i+1])
        if mask.sum() == 0:
            continue
        bin_acc = y_true[mask].mean()
        bin_conf = y_prob[mask].mean()
        ece += mask.mean() * abs(bin_acc - bin_conf)
    return ece

def spiegelhalter_z(y_true, y_prob):
    """
    Spiegelhalter Z-test for calibration.
    |Z| < 1.96 → calibrated (p > 0.05). Stop.
    |Z| > 1.96 → miscalibrated → apply correction.
    """
    n = len(y_true)
    num = np.sum((y_true - y_prob) * (1 - 2 * y_prob))
    denom = np.sqrt(np.sum((1 - 2 * y_prob)**2 * y_prob * (1 - y_prob)))
    z = num / denom if denom > 0 else 0
    return z
```

### Usage

```python
y_prob = model.predict_proba(X_val)[:, 1]  # binary: take positive class
y_true = y_val

ece = expected_calibration_error(y_true, y_prob)
z = spiegelhalter_z(y_true, y_prob)

print(f"ECE:            {ece:.4f}  (threshold: 0.05)")
print(f"Spiegelhalter Z: {z:.4f}  (threshold: ±1.96)")

plot_reliability_diagram(y_true, y_prob, model_name="Pre-calibration")
```

---

## Step 2 — Test

```
|Z| < 1.96  →  Model is already calibrated. Skip to Step 4 (verify refinement).
|Z| > 1.96  →  Apply one of the correction methods below.
```

---

## Step 3 — Correct

### Option A: Temperature Scaling (recommended first choice)

Works for neural networks and any model where you have access to logits.
Single parameter `T` — divides logits before softmax. Fast, rarely overfits.

```python
import torch
import torch.nn as nn
from torch import optim

class TemperatureScaling(nn.Module):
    def __init__(self):
        super().__init__()
        self.temperature = nn.Parameter(torch.ones(1) * 1.5)

    def forward(self, logits):
        return logits / self.temperature

    def fit(self, logits, labels, lr=0.01, max_iter=50):
        """Fit T on validation logits."""
        optimizer = optim.LBFGS([self.temperature], lr=lr, max_iter=max_iter)
        criterion = nn.CrossEntropyLoss()
        logits_t = torch.tensor(logits, dtype=torch.float32)
        labels_t = torch.tensor(labels, dtype=torch.long)

        def eval_step():
            optimizer.zero_grad()
            loss = criterion(self.forward(logits_t), labels_t)
            loss.backward()
            return loss

        optimizer.step(eval_step)
        print(f"Optimal temperature: {self.temperature.item():.4f}")
        return self

# Usage:
# ts = TemperatureScaling().fit(val_logits, y_val)
# calibrated_probs = torch.softmax(ts(torch.tensor(test_logits)), dim=1).detach().numpy()
```

### Option B: Platt Scaling (binary classifiers / sklearn)

Fits a logistic regression on top of the model's raw scores.

```python
from sklearn.linear_model import LogisticRegression
from sklearn.calibration import CalibratedClassifierCV

# Wrap existing model
calibrated_model = CalibratedClassifierCV(base_model, method='sigmoid', cv='prefit')
calibrated_model.fit(X_val, y_val)
y_prob_calibrated = calibrated_model.predict_proba(X_test)[:, 1]
```

### Option C: Isotonic Regression (more data needed, ~1000+ samples)

Non-parametric, more flexible than Platt. Risk of overfitting with small datasets.

```python
calibrated_model = CalibratedClassifierCV(base_model, method='isotonic', cv='prefit')
calibrated_model.fit(X_val, y_val)
y_prob_calibrated = calibrated_model.predict_proba(X_test)[:, 1]
```

### Option D: Venn-Abers Predictors (distribution-free, any size)

Use when distribution-free coverage guarantees are required (medical, legal, high-stakes).

```python
# pip install venn-abers
from venn_abers import VennAbersCalibrator

va = VennAbersCalibrator()
va.fit(y_prob_val, y_val)
y_prob_calibrated = va.predict_proba(y_prob_test)
```

---

## Step 4 — Verify

Calibration should improve reliability **without** destroying discrimination (refinement).
Always check both after correction.

```python
from sklearn.metrics import roc_auc_score, brier_score_loss

def calibration_report(y_true, y_prob_before, y_prob_after):
    """Compare pre/post calibration metrics."""
    metrics = {
        "ECE before":    expected_calibration_error(y_true, y_prob_before),
        "ECE after":     expected_calibration_error(y_true, y_prob_after),
        "Z before":      spiegelhalter_z(y_true, y_prob_before),
        "Z after":       spiegelhalter_z(y_true, y_prob_after),
        "AUC before":    roc_auc_score(y_true, y_prob_before),
        "AUC after":     roc_auc_score(y_true, y_prob_after),
        "Brier before":  brier_score_loss(y_true, y_prob_before),
        "Brier after":   brier_score_loss(y_true, y_prob_after),
    }
    print("\n=== Calibration Report ===")
    for k, v in metrics.items():
        print(f"  {k:<18}: {v:.4f}")
    
    # Warn if AUC dropped significantly
    auc_drop = metrics["AUC before"] - metrics["AUC after"]
    if auc_drop > 0.02:
        print(f"\n  ⚠ AUC dropped {auc_drop:.4f} — calibration may be flattening refinement.")
    else:
        print(f"\n  ✓ Refinement preserved (AUC delta: {auc_drop:.4f})")

    # Plot both curves
    fig, ax = plt.subplots(figsize=(6, 6))
    ax.plot([0, 1], [0, 1], "k--", label="Perfect")
    for probs, label in [(y_prob_before, "Before"), (y_prob_after, "After")]:
        pt, pp = calibration_curve(y_true, probs, n_bins=10)
        ax.plot(pp, pt, "s-", label=label)
    ax.set_xlabel("Mean predicted probability")
    ax.set_ylabel("Fraction of positives")
    ax.set_title("Calibration: Before vs After")
    ax.legend()
    plt.tight_layout()
    plt.savefig("calibration_comparison.png", dpi=150)
    plt.show()
```

---

## Full Pipeline Template

Use this as the standard structure for any classification project:

```python
# ============================================================
# CLASSIFICATION PIPELINE WITH CALIBRATION
# ============================================================

# 1. Split data: train / val / test  (never calibrate on train)
from sklearn.model_selection import train_test_split
X_trainval, X_test, y_trainval, y_test = train_test_split(X, y, test_size=0.2)
X_train, X_val, y_train, y_val = train_test_split(X_trainval, y_trainval, test_size=0.2)

# 2. Train model
model.fit(X_train, y_train)

# 3. Get validation probabilities
y_prob_val = model.predict_proba(X_val)[:, 1]

# 4. Measure
ece = expected_calibration_error(y_val, y_prob_val)
z   = spiegelhalter_z(y_val, y_prob_val)
plot_reliability_diagram(y_val, y_prob_val, model_name="Raw model")

# 5. Decide
if abs(z) <= 1.96:
    print("Model is calibrated. No correction needed.")
    final_probs = model.predict_proba(X_test)[:, 1]
else:
    print(f"Z={z:.2f} — applying calibration...")
    # Choose method: sigmoid (Platt) for <1000 samples, isotonic for more
    calibrated = CalibratedClassifierCV(model, method='sigmoid', cv='prefit')
    calibrated.fit(X_val, y_val)
    final_probs = calibrated.predict_proba(X_test)[:, 1]

# 6. Verify on test set
y_prob_test_raw = model.predict_proba(X_test)[:, 1]
calibration_report(y_test, y_prob_test_raw, final_probs)
```

---

## Method Selection Guide

```
Has logits (neural network)?
  └─ Yes → Temperature Scaling (Option A)
  └─ No  → Binary problem?
              └─ Yes, < 1000 val samples → Platt Scaling (Option B)
              └─ Yes, ≥ 1000 val samples → Isotonic Regression (Option C)
              └─ Need distribution-free guarantees → Venn-Abers (Option D)
```

---

## Dependencies

```bash
pip install scikit-learn numpy matplotlib
pip install torch          # only for Temperature Scaling
pip install venn-abers     # only for Option D
```

---

## Key Concepts (reference)

| Term | Meaning |
|------|---------|
| **Calibration** | Predicted probability ≈ empirical frequency |
| **Refinement** | Model's ability to discriminate classes (AUC) |
| **ECE** | Expected Calibration Error. Lower = better. >0.05 → fix |
| **Spiegelhalter Z** | Statistical test. \|Z\| > 1.96 → miscalibrated |
| **Overconfidence** | Model assigns high probabilities even when wrong |
| **Temperature T** | T > 1 softens predictions; T < 1 sharpens them |
| **Brier Score** | Combines calibration + refinement in one metric |
