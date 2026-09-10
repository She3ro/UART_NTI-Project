
# 🔌 UART Transceiver in Verilog
<div align="center">
  <img src="https://img.shields.io/badge/Language-Verilog-blue" alt="Language">
  <img src="https://img.shields.io/badge/Status-Completed-brightgreen" alt="Status">
</div>

## 📝 Overview

This repository contains a **configurable and full-duplex UART (Universal Asynchronous Receiver-Transmitter)** implemented in Verilog. The design supports various baud rates, data lengths, parity modes, and stop bit formats — making it flexible for diverse communication needs.

🚀 It includes:
- A **transmitter**
- A **receiver**
- A **baud rate generator**
- FIFO buffers for seamless data handling
- Full testbench support for verification

---

## ✨ Features

- **Full-Duplex Communication**  
  Simultaneous transmission and reception of data.

- **Configurable Baud Rate**  
  Selectable via an input port. Default system clock is **100 MHz**. Supported rates:
  - `600`, `1200`, `2400`, `4800`, `9600` (default)
  - `19200`, `38400`, `57600`, `115200`

- **Flexible Data Format**  
  - **Data Bits**: 5, 6, 7, or 8 bits  
  - **Parity**: None, Even, or Odd  
  - **Stop Bits**: 1, 1.5, or 2  

- **FIFO Integration**  
  Buffers on both RX and TX paths help prevent data loss and improve performance.

- **Status Signals**  
  Easily interface with external modules via:
  - `tx_full`
  - `rx_empty`
  - `parity_error`
  - `frame_error`

---

## 📁 File Structure

```
.
├── srcs/
│   ├── uart_transceiver.v      # Top-level UART wrapper (connects RX, TX, FIFOs, and Baud Gen)
│   ├── uart_tx.v               # UART transmitter module
│   ├── uart_rx.v               # UART receiver module
│   ├── baud_generator.v        # Generates baud rate ticks
│   ├── timer_input.v           # Timer module used by baud generator
│   └── fifo_generator_0.v      # FIFO module (placeholder for IP or custom implementation)

├── tb/
│   ├── tb_baud_generator.v            # Testbench for baud_generator
│   └── tb_uart_rx.v                   # Testbench for uart_rx
│   ├── tb_uart_tx.v                   # Testbench for uart_tx
│   └── tb_uart_transceiver.v          # Testbench for uart_transceiver

├── constraint/                        # (Optional) constraint File for Timing & Power reporting
│   └── Nexys_4.xdc                   

└── README.md                          # Project documentation
```

---

## 🔧 Module Overview

### `uart_transceiver`
Top-level module that wraps around the TX and RX modules.  
✅ Connects to the baud rate generator  
✅ Interfaces with two FIFOs for buffered RX/TX  
✅ Handles configurable parameters through its ports

---

### `uart_tx` – Transmitter

- **Function**:  
  Serializes input data. When `tx_start` is asserted, it sends a start bit, followed by data (LSB first), optional parity, and stop bits.

- **Controls**:  
  Configured using:
  - `dbit_select_i` – data bits  
  - `sbit_select_i` – stop bits  
  - `parity_select_i` – parity

- **Signal Output**:  
  `tx_done_tick` – high for one cycle after transmission

---

### `uart_rx` – Receiver

- **Function**:  
  Listens for start bits on the `rx` line. Oversamples at 16× the baud rate to center on each bit. Deserializes and checks parity/stop bits.

- **Error Handling**:  
  Flags:
  - `parity_error`
  - `frame_error`

---

### `baud_generator`
Generates `s_tick` signals using:
- A `timer_input` module
- A selectable baud rate via `baud_rate_sel`

---

## ⚙️ Configuration

All parameters are dynamically set via input ports on `uart_transceiver`.

| Port             | Width | Description |
|------------------|-------|-------------|
| `baud_rate_sel`  | 4-bit | Baud rate selector (`4'd8` → 115200) |
| `dbit_select_i`  | 3-bit | Data bits: `3'b000` (5) to `3'b011` (8) |
| `sbit_select_i`  | 2-bit | Stop bits: `2'b00` (1), `2'b01` (1.5), `2'b10` (2) |
| `parity_select_i`| 2-bit | Parity: `2'b00` (None), `2'b01` (Even), `2'b10` (Odd) |

---

## 🧪 Testing & Simulation

Comprehensive testbenches are included to verify functionality.

### `tb_uart_tx`

Includes a `send_byte` task to test:
- 8-N-1 (standard config)
- 7-E-2 (even parity, 2 stop bits)
- 8-O-1.5 (odd parity, 1.5 stop bits)
- 5/6-bit configurations with varied settings
- Continuous data transmissions (stress test)

---

### `tb_uart_rx`

Includes a `send_frame` task to simulate incoming UART frames.  
Tests decoding and:
- Data bit width  
- Parity checking  
- Stop bit validation  
- Error detection (`parity_error`, `frame_error`)

✅ Supports various data patterns and timing to ensure robustness.

---

## 💡 Future Enhancements

Here are some possible improvements and add-ons to extend the functionality:

- 🌐 **AXI/APB Bus Wrappers:** Wrap the UART in a standard bus interface for easier SoC integration  
- 🧠 **Auto Baud Rate Detection:** Allow the UART to dynamically detect incoming baud rate  
- 🕵️ **Line Idle Timeout / Framing Watchdog:** Detect line silence or corruption  
- 📊 **Improved Testbench Suite:** Add self-checking and randomized tests using SystemVerilog or UVM  
- 🧩 **Integration with Soft CPU Core:** Such as PicoRV32 or RISC-V for embedded application testing  

---
## 🌟 Contributors

Special thanks to everyone who contributed to this project:

- **Ahmed Waleed**  
  [LinkedIn](https://www.linkedin.com/in/ahmedwaleed3604/) | [GitHub](https://github.com/AhmedWaleed36)

- **Ahmed Khaled**  
  [LinkedIn](https://www.linkedin.com/in/ahmedkhaled-l/) | [GitHub](https://github.com/Ahmed-Khaled-L)

---

Feel free to fork and experiment with the project — PRs are welcome! 😊
