# Copilot Instructions

## 1. Source Code Management

- Whenever generating new code files or scripts, **ALWAYS** create and save them in the `tmp_script` directory to avoid cluttering the root directory.
- The `tmp_script` directory must be created automatically if it does not exist.
- Do not place temporary or experimental scripts in the project root.

---

## 2. Reports and Output Management

- Whenever generating report files, analysis documents, output files, or output from scripts, **ALWAYS** write/save them in the `tmp_output` directory.
- The `tmp_output` directory must be created automatically if it does not exist.
- Never store generated reports directly in the root directory.

---

## 3. Python Environment Management

- When running Python code or using Python-related tools:
  - **Prioritize using the local `.venv` virtual environment** in the current workspace.
  - On Windows, use:
    ```
    ./.venv/Scripts/python.exe
    ```
  - Avoid using the system-wide global `python` command unless absolutely necessary.

### UV Framework

- If the workspace uses the `uv` framework (detected via `uv.lock` or `pyproject.toml` with uv configuration):
  - **Prioritize using `uv run`** over other execution methods.
  - Follow uv’s dependency and environment management conventions.

---

## 4. Configuration File Requirement

- If the application requires configuration and no `config.yaml` exists, **ALWAYS create an appropriate `config.yaml` file**.
- The structure and content of `config.yaml` must comply with the rules defined in [`config-yaml.instructions.md`](./instructions/config-yaml.instructions.md).
- Never hardcode environment-dependent values directly inside source code when they belong in configuration.

---

## 5. Mermaid for Flow and Diagram

- When presenting a flow, diagram, workflow, execution flows, or architectural layers in a response or Markdown file, **prioritize using Mermaid**.
- Only use other formats if the user explicitly requests it or if Mermaid is not suitable for the content that needs to be presented.

---

## 6. Language and Response Style

- **ALWAYS** respond, explain, and communicate in Vietnamese.

---

## 7. Instruction Compliance

- **BEFORE** performing any file creation or modification, **ALWAYS** identify and read applicable instruction files (e.g., `*.instructions.md`) located in `.github/instructions/` or the project root.
- Strictly follow the constraints (language, coding standards, etc.) defined in those instructions for the specific file types involved.
