# button test on every pin

## header 1

| status     | pin | pin | status     |
| ---------- | --- | --- | ---------- |
| +3.3V      | 1   | 2   | +5.0V      |
| **best**   | 3   | 4   | +5.0V      |
| **best**   | 5   | 6   | GND        |
| **PULLUP** | 7   | 8   | **best**   |
| GND        | 9   | 10  | **best**   |
| **PULLUP** | 11  | 12  | **PULLUP** |
| **PULLUP** | 13  | 14  | GND        |
| **PULLUP** | 15  | 16  | **PULLUP** |
| +3.3V      | 17  | 18  | **PULLUP** |
| **best**   | 19  | 20  | GND        |
| **PULLUP** | 21  | 22  | **PULLUP** |
| **best**   | 23  | 24  | **best**   |
| GND        | 25  | 26  | ADC0       |

## header 2

| status     | pin | pin | status     |
| ---------- | --- | --- | ---------- |
| GND        | 27  | 28  | **PULLUP** |
| x          | 29  | 30  | **PULLUP** |
| x          | 31  | 32  | **PULLUP** |
| x          | 33  | 34  | **PULLUP** |
| x          | 35  | 36  | x          |
| x          | 37  | 38  | x          |
| **best**   | 39  | 40  | **best**   |
| **PULLUP** | 41  | 42  | **best**   |
| **PULLUP** | 43  | 44  | **PULLUP** |
| **PULLUP** | 45  | 46  | **PULLUP** |

1.  *tested on Rock Pi S* **v1.3**
2.  **PULLUP resistor: 10K**
3.  Pins 11 and 13 are reserved ofr I2C3 device (display)
4.  available *best* (no pullup resistor needed): 10
5.  available with pullup resistor (except 11 and 13): 16

**Hypothesis**

6 encoders/buttons, 3 on header 1 and 3 on header 2

| encoder | pin    | pin    | button_pin |
| ------- | ------ | ------ | ---------- |
| 1       | 3      | 5      | **7**      |
| 2       | 8      | 10     | **12**     |
| 3       | 19     | **21** | 23         |
| 4       | **18** | **22** | 24         |
| 5       | 39     | **41** | **43**     |
| 6       | 40     | 42     | **44**     |