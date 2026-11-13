
# 4-Bit Array Multiplier | Verilog HDL

<p align="center">
  <b>RTL Design • Digital Logic Design • Functional Verification</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Language-Verilog-blue?style=for-the-badge&logo=verilog" />
  <img src="https://img.shields.io/badge/Simulation-Synopsys%20VCS-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Waveform-Synopsys%20Verdi-green?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Format-FSDB-purple?style=for-the-badge" />
</p>

## 1. Project Overview

This project presents the RTL design and functional verification of a **4-bit × 4-bit unsigned Array Multiplier** using Verilog Hardware Description Language (HDL).

The multiplier performs binary multiplication through partial product generation and successive addition stages implemented using Half Adders (HA) and Full Adders (FA).

The architecture accepts two 4-bit unsigned operands and produces an 8-bit multiplication result.

The design is simulated using **Synopsys VCS**, while waveform inspection and RTL debugging are performed using **Synopsys Verdi** with FSDB waveform support.

## 2. Design Specifications

| Parameter | Description |
|---|---|
| Design Name | 4-Bit Array Multiplier |
| Design Type | Combinational Logic |
| Architecture | Array Multiplier |
| Input Operand A | 4-bit unsigned |
| Input Operand B | 4-bit unsigned |
| Output Product | 8-bit |
| Arithmetic Operation | Binary Multiplication |
| Basic Components | Half Adder and Full Adder |
| HDL | Verilog |
| Simulator | Synopsys VCS |
| Waveform Viewer | Synopsys Verdi |
| Waveform Format | FSDB |

## 3. Design Methodology

The multiplier is implemented using a structured partial-product addition approach.

### 3.1 Partial Product Generation

Four partial product rows are generated using bitwise AND operations between the multiplicand and individual bits of the multiplier.

\[
PP_i = A \land \{4\{B_i\}\}
\]

where:

- \(A\) represents the 4-bit multiplicand.
- \(B_i\) represents an individual multiplier bit.
- \(PP_i\) represents the corresponding partial product row.

### 3.2 Partial Product Addition

The generated partial products are combined using Half Adders and Full Adders.

- Half Adders perform two-input binary addition.
- Full Adders perform three-input binary addition, including carry-in.
- Intermediate carry signals are propagated through successive addition stages.

### 3.3 Product Generation

The final sum and carry outputs are combined to produce the 8-bit multiplication result.

\[
P = A \times B
\]

The maximum possible product is:

\[
15 \times 15 = 225
\]

Therefore, an 8-bit output is sufficient to represent the complete unsigned multiplication result.

## 4. RTL Module Architecture

The project consists of the following Verilog modules:

| Module | Functionality |
|---|---|
| `ha` | Implements Half Adder logic |
| `fa` | Implements Full Adder logic |
| `bit4_array_multiplier` | Integrates partial product generation and addition stages |
| `bit4_array_multiplier_tb` | Applies test vectors and verifies the multiplier |

### Half Adder Logic

**Boolean Expressions:**

- Sum = A XOR B
- Carry = A AND B

### Full Adder Logic

**Boolean Expressions:**

- Sum = A XOR B XOR Cin
- Carry = (A AND B) OR (B AND Cin) OR (Cin AND A)

## 5. Repository Structure

```text
4-bit-array-multiplier/
│
├── bit4_array_multiplier.v
│   └── RTL source code
│
├── bit4_array_multiplier_tb.v
│   └── Functional verification testbench
│
├── screenshots/
│   └── verdi_waveform.png
│
├── README.md
│
└── .gitignore
```

Generated simulation files such as FSDB databases and compiled executables can be maintained locally rather than committed to the repository.

## 6. Functional Verification

A Verilog testbench is developed to verify the functional behavior of the multiplier.

The testbench applies different input combinations at 10 ns intervals and observes the corresponding 8-bit product.

### 6.1 Test Scenarios

| Test Case | Operand A | Operand B | Expected Product |
|:---:|:---:|:---:|:---:|
| TC1 | 0010 (2) | 0011 (3) | 00000110 (6) |
| TC2 | 0100 (4) | 0101 (5) | 00010100 (20) |
| TC3 | 0111 (7) | 0010 (2) | 00001110 (14) |
| TC4 | 1001 (9) | 1010 (10) | 01011010 (90) |
| TC5 | 1111 (15) | 1111 (15) | 11100001 (225) |

### 6.2 Expected Simulation Output

```text
Time=0  A= 2  B= 3  Product=  6
Time=10 A= 4  B= 5  Product= 20
Time=20 A= 7  B= 2  Product= 14
Time=30 A= 9  B=10  Product= 90
Time=40 A=15  B=15  Product=225
```

## 7. Simulation Environment

The design is simulated using Synopsys VCS and analyzed using Synopsys Verdi.

### 7.1 Simulation Workflow

```text
       Verilog RTL Design
               |
               v
        Verilog Testbench
               |
               v
         Synopsys VCS
               |
               v
        RTL Simulation
               |
               v
         FSDB Database
               |
               v
        Synopsys Verdi
               |
               v
       Waveform Analysis
```

### 7.2 VCS Compilation

Compile the RTL source and testbench using:

```bash
vcs -full64 -debug_access+all \
bit4_array_multiplier.v \
bit4_array_multiplier_tb.v \
-o simv
```

Ensure that the Verdi FSDB PLI integration is configured correctly in the VCS environment.

### 7.3 Execute Simulation

```bash
./simv
```

The simulation executes the testbench and generates the FSDB waveform database when the FSDB dump commands are enabled.

### 7.4 FSDB Generation

Add the following commands inside the testbench:

```verilog
initial begin
    $fsdbDumpfile("4bitarraymultiplier.fsdb");
    $fsdbDumpvars(0, bit4_array_multiplier_tb);
end
```

### 7.5 Open Waveform in Synopsys Verdi

```bash
verdi -ssf 4bitarraymultiplier.fsdb &
```

The generated FSDB database can be opened in Verdi for waveform visualization and signal-level debugging.

## 8. Waveform Analysis

The following signals are observed in Synopsys Verdi:

| Signal | Width | Description |
|---|---:|---|
| `a` | 4 bits | Multiplicand input |
| `b` | 4 bits | Multiplier input |
| `p` | 8 bits | Final multiplication output |

Waveform analysis is used to:

- Inspect input and output transitions.
- Verify combinational circuit behavior.
- Observe multiplication results for different input combinations.
- Identify potential RTL functional issues.
- Debug signal behavior using the design hierarchy.

## 9. Tools and Technologies

| Tool / Technology | Purpose |
|---|---|
| Verilog HDL | RTL design implementation |
| Synopsys VCS | RTL compilation and simulation |
| Synopsys Verdi | Waveform visualization and debugging |
| FSDB | Simulation waveform database |
| Git | Version control |
| GitHub | Source code management and project documentation |

## 10. Key Learning Outcomes

Through this project, the following concepts are explored:

- Combinational digital circuit design.
- Binary multiplication architecture.
- Partial product generation.
- Half Adder and Full Adder implementation.
- Structural RTL modeling using Verilog.
- Testbench development and simulation.
- RTL functional debugging.
- Synopsys VCS and Verdi tool workflow.
- FSDB waveform generation and analysis.

## 11. Future Enhancements

Potential extensions to this project include:

- Extending the multiplier architecture to 8-bit and 16-bit designs.
- Implementing Wallace Tree and Booth multiplier architectures.
- Performing RTL synthesis and area analysis.
- Evaluating propagation delay and critical paths.
- Developing a parameterized multiplier architecture.
- Performing gate-level simulation and timing verification.

## 12. Author

**SANTHOSH KUMAR N A**

RTL Design | Digital Design | VLSI Engineering

- GitHub: [Your GitHub Profile](https://github.com/your-username)
- LinkedIn: [Your LinkedIn Profile](https://linkedin.com/in/your-profile)

## 13. License

This project is intended for educational and learning purposes.

You are welcome to explore, modify, and extend the implementation with appropriate attribution.

---

<p align="center">
  <b>Designed with Verilog HDL | Simulated with Synopsys VCS | Debugged with Synopsys Verdi</b>
</p>

<p align="center">
  ⭐ If you find this project useful, consider starring the repository!
</p>
