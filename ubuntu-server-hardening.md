# 🛡️ Ubuntu Server – Saneamento, Hardening e Blindagem Estrutural

> Este guia transforma uma VM Ubuntu “padrão de cloud” em um **servidor previsível, estável e imune à degradação silenciosa** causada por agentes automáticos, snaps, unattended-upgrades e deadlocks do APT.

Compatível com:

* Ubuntu Server 22.04+
* Ubuntu Server 24.04+
* Oracle ARM / x86
* VPS / Bare metal / VM

---

## 1️⃣ Descontaminação inicial do APT

### 1.1 Descubra se existe APT travado

```bash
sudo lsof /var/lib/apt/lists/lock
```

Se existir processo segurando lock:

```bash
ps -fp <PID>
sudo kill -9 <PID>
```

---

### 1.2 Limpe locks residuais

```bash
sudo rm -f /var/lib/apt/lists/lock
sudo rm -f /var/cache/apt/archives/lock
sudo rm -f /var/lib/dpkg/lock*
```

---

### 1.3 Reconstrua o banco do dpkg

```bash
sudo dpkg --configure -a
sudo apt -f install
```

---

## 2️⃣ Remoção de agentes de degradação

### 2.1 Desative unattended-upgrades

```bash
sudo systemctl stop unattended-upgrades
sudo systemctl disable unattended-upgrades
```

---

### 2.2 Desmonte o snapd (modo servidor)

```bash
sudo systemctl stop snapd.service snapd.socket || true
sudo systemctl disable snapd.service snapd.socket || true
sudo systemctl mask snapd.service snapd.socket
```

Remova o snapd se existir:

```bash
sudo apt purge snapd -y || true
sudo rm -rf /snap /var/snap /var/lib/snapd /var/cache/snapd
```

Remova unidades órfãs:

```bash
sudo rm -f /etc/systemd/system/snapd.service
sudo rm -f /etc/systemd/system/snapd.socket
sudo rm -f /usr/lib/systemd/system/snapd.service
sudo rm -f /usr/lib/systemd/system/snapd.socket
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
```

---

## 3️⃣ Saneamento estrutural do sistema

```bash
sudo apt update
sudo apt full-upgrade -y
sudo apt autoremove --purge -y
sudo apt autoclean
sudo journalctl --vacuum-time=14d
sudo systemctl daemon-reexec
```

---

## 4️⃣ Verificação de sanidade

```bash
systemctl is-system-running
df -h /
```

Esperado:

* `running`
* Uso da raiz < 15%

---

## 5️⃣ Job semanal de manutenção controlada

Edite o crontab:

```bash
crontab -e
```

Adicione:

```bash
# === Manutenção estrutural semanal ===
0 3 * * 0 /usr/bin/apt update && /usr/bin/apt full-upgrade -y && /usr/bin/apt autoremove --purge -y && /usr/bin/journalctl --vacuum-time=14d && /bin/systemctl daemon-reexec
```

Confirme:

```bash
crontab -l
```

---

## 6️⃣ Resultado

Após este procedimento:

* Zero snap
* Zero unattended-upgrades
* dpkg previsível
* apt sem deadlock
* sistema não degrada com o tempo
* manutenção controlada e auditável

---

> Este baseline transforma Ubuntu Server “doméstico” em **servidor de verdade**.
