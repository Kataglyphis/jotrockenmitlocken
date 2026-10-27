# Changelog

## Unreleased

- Reuse ANTfrastructure's Flutter gate for Android launcher manifest and resource validation.

- Search local and direct-submodule Bash/PowerShell helpers before adding behavior here;
  extend their shared owner for functionality used by other consumers.
- Pin ANTfrastructure's shared Bash/PowerShell reuse scanner so CI reports
  consumer-to-hub overlap candidates.
- Pin ANTfrastructure to the Renovate driver that updates both direct submodules to their
  remote default branches and initializes missing checkouts on apply, including WSL over
  Windows Git checkouts.
- Verify the Renovate wrapper and shared config in CI without applying updates.
- Add shared CI size, complexity, duplication and Ruff/ty reports, with a manual Python
  refactor preview. Generated local reports stay in ignored `logs/`.
- Keep the selected route and page state when language, theme or layout changes.
- Use ANThology's native open/save dialogs and shared file-action error feedback.
- Reuse ANThology's dev-only layout and navigation contracts, including actual control taps.
- Remove the unused `provider` and `mockito` dependencies.
