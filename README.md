# Ubuntu Server Baseline

**Structural hardening baseline for Ubuntu Server**

> 🇧🇷 *Baseline estrutural para transformar imagens Ubuntu “cruas” em servidores previsíveis, estáveis e que não se degradam ao longo do tempo.*
>
> 🇺🇸 *Structural baseline to convert raw Ubuntu cloud images into predictable, stable and non-degrading servers.*

---

## 🇧🇷 O que este baseline corrige

| Problema                 | Ubuntu padrão           | Com este baseline      |
| ------------------------ | ----------------------- | ---------------------- |
| `unattended-upgrades`    | Atualizações aleatórias | Totalmente controladas |
| Subsistema snapd         | Ativo                   | Removido completamente |
| Deadlocks de APT         | Frequentes              | Eliminados             |
| Corrupção de `dpkg`      | Silenciosa              | Prevenida              |
| Explosão de logs         | Sem controle            | Sanitizada             |
| Degradação a longo prazo | Sim                     | Não                    |

---

## 🇺🇸 What this baseline fixes

| Problem               | Default Ubuntu         | With this baseline |
| --------------------- | ---------------------- | ------------------ |
| unattended-upgrades   | Random package changes | Fully controlled   |
| snapd subsystem       | Active                 | Completely removed |
| APT deadlocks         | Common                 | Eliminated         |
| dpkg corruption       | Silent                 | Prevented          |
| Log explosion         | Uncontrolled           | Sanitized          |
| Long-term degradation | Yes                    | No                 |

---

## 🇧🇷 O que ele faz

* Remove completamente o subsistema Snap
* Desativa `unattended-upgrades`
* Repara e sanitiza `apt` / `dpkg`
* Limpa logs, pacotes órfãos e kernels antigos
* Implanta um ciclo semanal de manutenção controlada
* Adiciona auditoria estrutural mensal

---

## 🇺🇸 What it does

* Completely removes the Snap subsystem
* Disables `unattended-upgrades`
* Repairs and sanitizes `apt` / `dpkg`
* Cleans logs, orphan packages and old kernels
* Installs a controlled weekly maintenance cycle
* Adds monthly structural auditing

---

## 🚀 Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/MrFerbic/ubuntu-server-baseline/main/baseline.sh | sudo bash
```

---

## 📂 Files

| File                                | Description                     |
| ----------------------------------- | ------------------------------- |
| `baseline.sh`                       | Automatic baseline installer    |
| `ubuntu-server-hardening.md`        | Full structural hardening guide |
| `ubuntu-server-auditoria-mensal.md` | Monthly integrity audit         |

---

## 🧩 Supported

* Ubuntu Server **22.04+**
* Ubuntu Server **24.04+**
* ARM64 / x86
* Oracle / AWS / Azure / VPS / Bare Metal

---

## 🧱 Result

🇧🇷 Seu Ubuntu Server se torna:

> **Previsível. Estável. Não degradável. Pronto para produção.**

🇺🇸 Your Ubuntu Server becomes:

> **Predictable. Stable. Non-degrading. Production-grade.**

---

Maintained by **MrFerbic**
**Structural Engineering for Linux Servers**
