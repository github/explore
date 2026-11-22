---
display_name: Topological JEPA
related: jepa, w-jepa, self-supervised-learning, topological-data-analysis, persistent-homology, world-models
short_description: Topological JEPAs hide part of their input and predict the topology of the hidden part.
topic: topological-jepa
---
A topological JEPA is a joint-embedding predictive architecture that hides part of its input and predicts a topological summary of the hidden part. That summary can be the number of connected components, their persistence, or Betti numbers, and it replaces the learned embedding that other JEPAs predict. The target is computed exactly from the full input, so the predictor learns against a fixed answer key instead of a moving one.
