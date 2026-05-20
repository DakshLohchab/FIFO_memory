# Synchronous FIFO Memory Design

A robust Verilog implementation of a Synchronous First-In-First-Out (FIFO) memory buffer with integrated status flagging (Full, Empty, Overflow, Underflow, and Threshold). This design uses an expanded pointer tracking approach to clearly differentiate between full and empty states without sacrificing memory slots.

## 🚀 Overview

This repository contains a modular, parameterizable-ready Synchronous FIFO memory architecture designed for digital system pipelines and clock-domain-matched data buffering. The design spans 5 core design modules and a complete testbench sequence targeting simulation verification.

### Key Features
* **Synchronous Operation:** Single clock domain (`clk`) handling both read and write logic natively.
* **No Slot Waste:** Employs a 5-bit pointer array mapping a 16-word deep memory array. The MSB acts as a phase tracker to easily isolate FIFO Full from FIFO Empty conditions.
* **Real-time Metrics:** Status updates for Programmable Threshold compliance (`fifo_threshold` triggers when storage content reaches $\ge 8$ entries).
* **Runtime Guardrails:** Upstream signaling for hardware-critical exceptions like `fifo_overflow` and `fifo_underflow`.

---

## 🏗️ Architecture & Modules

The design uses a top-level structural layout (`top.v`) that interconnects four specific behavioral submodules:

1. **`top.v` (Top Level):** Wire routing interface tying write/read pointers, core register memory, and flags together.
2. **`memory_array.v` (Storage Array):** Instantiates a 16x8-bit memory matrix. Writes are gated behind `we && !fifo_full` and reads are gated behind `re && !fifo_empty` to ensure data integrity.
3. **`w_pointer.v` & `r_pointer.v` (Pointers):** Implement 5-bit asynchronous active-low reset counter pointers that track storage position bounds.
4. **`status.v` (Flag Flagging Generator):** Houses the combinational assignments driving operational status markers:
   * `fifo_empty`: Asserted when write and read pointers match exactly (`wptr == rptr`).
   * `fifo_full`: Asserted when lower bits match but the MSBs differ, indicating a wrap-around condition.
   * `fifo_overflow` / `fifo_underflow`: Identifies illegal access cycles synchronously.

---

## 🛠️ Verification & Test Sequence

The verification suite (`top_sim.v`) builds a test harness exercising basic operation, boundary conditions, and error states:

* **Sequential Writes:** Pipelines test vector data packets (`8'h11` through `8'h99`) on consecutive clocks.
* **Sequential Reads:** Empties the pipeline to verify structural consistency.
* **Underflow Verification:** Intentionally prompts a read command out of an empty state to confirm `fifo_underflow` assertion.
* **Overflow Verification:** Runs an extended 20-cycle loop forcing writes past the 16-word memory limit to test `fifo_full` boundaries and `fifo_overflow` assertions.

---

## 💻 How to Simulate

### Prerequisites
* **AMD Vivado Design Suite** (or any standard IEEE-1364 compliant Verilog simulator like ModelSim, Icarus Verilog, or EDA Playground).

### Steps
1. Clone this repository to your local system environment.
2. Open your simulation environment tool and create a new project.
3. Import the hardware sources located inside `sources_1/new/` (`top.v`, `memory_array.v`, `w_pointer.v`, `r_pointer.v`, `status.v`).
4. Import the simulation file inside `sim_1/new/` (`top_sim.v`).
5. Initialize the behavioral simulation and view waveform responses or standard `$monitor` console readouts.
