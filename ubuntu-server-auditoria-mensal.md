# 🔎 Auditoria Mensal Estrutural – Ubuntu Server

> Este procedimento detecta **corrupção silenciosa, vazamentos de recursos e degradação estrutural** antes que o sistema comece a falhar (APT travando, processos zumbis, mounts fantasmas, inode leak, logs explosivos, etc).

Rodar **1 vez por mês** (ou sob suspeita).

---

## 1️⃣ Verificação de sanidade do systemd

```bash
systemctl is-system-running
systemctl list-units --state=failed
```

**Esperado:**

* `running`
* zero unidades falhadas

---

## 2️⃣ Detecção de processos zumbis

```bash
ps -eo pid,ppid,stat,cmd | awk '$3 ~ /Z/ {print}'
```

**Esperado:** nenhum retorno.

---

## 3️⃣ Verificação de locks fantasmas do APT/dpkg

```bash
lsof /var/lib/apt/lists/lock
lsof /var/lib/dpkg/lock*
```

**Esperado:** nenhum processo segurando lock.

---

## 4️⃣ Auditoria de integridade do dpkg

```bash
sudo dpkg --audit
sudo apt -f install
```

**Esperado:** sem erros.

---

## 5️⃣ Auditoria de espaço em disco e inodes

```bash
df -h /
df -i /
```

**Alerta se:**

* Uso > 80%
* Inodes > 70%

---

## 6️⃣ Verificação de mounts fantasmas

```bash
mount | grep snap || echo "Nenhum mount snap"
```

**Esperado:** nenhum retorno.

---

## 7️⃣ Verificação de timers perigosos

```bash
systemctl list-timers --all | grep -E "snap|unattended" || echo "Nenhum timer perigoso ativo"
```

---

## 8️⃣ Auditoria de logs gigantes

```bash
journalctl --disk-usage
du -sh /var/log/*
```

Se logs > 1G → limpar:

```bash
sudo journalctl --vacuum-time=14d
```

---

## 9️⃣ Auditoria de kernels antigos

```bash
dpkg -l | grep linux-image | awk '{print $2}'
uname -r
```

Remova kernels antigos se existirem.

---

## 10️⃣ Resultado

Se todos os testes passarem, o sistema está:

> **Estruturalmente íntegro e imune à degradação silenciosa.**

---

## (Opcional) Automatizar auditoria mensal

Crie job mensal:

```bash
crontab -e
```

Adicione:

```bash
# === Auditoria estrutural mensal ===
0 4 1 * * /usr/bin/systemctl is-system-running >> /var/log/auditoria.log && /usr/bin/dpkg --audit >> /var/log/auditoria.log && /usr/bin/journalctl --disk-usage >> /var/log/auditoria.log
```
