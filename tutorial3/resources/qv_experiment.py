from qiskit import *
from qiskit.circuit.library import *
from qiskit_aer import *
import time
import numpy as np
def quant_vol(qubits=15, depth=10):
  sim = AerSimulator(method='statevector', device='CPU')
  circuit = QuantumVolume(qubits, depth, seed=0)
  circuit.measure_all()
  circuit = transpile(circuit, sim)

  start = time.time()
  result = sim.run(circuit, shots=1, seed_simulator=12345).result()
  time_val = time.time() - start
  # Optionally return and print result for debugging
  # Bonus marks available for reading the simulation time directly from `result`
  return time_val
