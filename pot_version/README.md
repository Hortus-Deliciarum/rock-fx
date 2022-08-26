# Configurazione rockpis/esp32

## Preparazione

Nel file /boot/uEnv.txt attivare la porta seriale `uart1` in corrispondenza della chiave `overlays`:

```
overlays=rk3308-uart1
```

Riavviare.

Ottenere la lista delle porte seriali con il comando:

```bash
sudo mraa-uart list
```

E annotare l'indice e il *path* della seriale appena attivata.  
Impostare la velocità di trasmissione con il seguente comando:

```bash
sudo mraa-uart dev device baud 115200
```

dove *device* è l'indice della seriale (di solito **1**)

## Collegamenti fisici

| esp32 pin  | rockpis pin |
| ---------- | ----------- |
| 16 (RXD 2) | 24 (TX1)    |
| 17 (TXD 2) | 23 (RX1)    |