# Mermaid flowchart style

Conventions from community PR [anthropics/skills#835](https://github.com/anthropics/skills/pull/835) (`mermaid-flowchart-formatter`). Not on `main` yet — kept here.

## Shapes

| Meaning | Shape | Example |
|---------|--------|---------|
| Start / end / external channel | stadium | `A(["Report to bot"])` |
| Step | rounded rectangle | `B("Click the button")` |
| Decision | hexagon | `C{{"Session alive?"}}` |

## classDef

```
classDef default fill:#E2EAFE4F,stroke:#5A88F6AF,color:#1a1a1a
classDef endNode fill:#DDF4D84F,stroke:#7DCF62AF,color:#1a1a1a
classDef decisionNode fill:#FCEBD34f,stroke:#F6AA4BAF,color:#1a1a1a
```

- Start / end / channel → `endNode`
- Decision → `decisionNode`

## Edges

```
linkStyle default stroke:#666666AF,stroke-width:2px
```

Conditionals: yes `#339933AF`, no `#DD3333AF` (`linkStyle N`, edges counted from 0).

Host subgraph:

```
style Host fill:#E2EAFE3F,stroke:#6666669F,stroke-width:1px,stroke-dasharray: 5 5
```
