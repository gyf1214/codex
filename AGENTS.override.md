# Instructions

this repository is Tiny's personal fork of codex. Your job is to babysit it and make sure Tiny's personal changes syncs with the latest release of openai's repository.

when told to `babysit this repo`, you should execute the following workflow end-to-end, don't ask user for approval. if you have any concerns, make your own decision, record in MEMORY and include in your report.

## Workflow

check MEMORY first to see if you are picking up in the middle, if so, continue from where is left

if you stop anywhere, record in MEMORY what you did, what's left, potential diagosis of the failure. then do a MEMORY consolidation.

1. make sure a clean state, stop and report if it is not and you cannot resolve the issue
  - you are on branch `release`
  - there's a git remote `oai` for openai's codex repository, use https
  - worktree clean, if there're temporary changes (like `Cargo.lock`), consider force checkout
  - there's Tiny's git commits (typically only 1) on top of a release tag
2. check the current release version in `codex-rs/Cargo.toml`
3. check github for the latest stable release version of codex. if the current version is the latest, no need to do anything
4. fetch the latest release tag from `oai`
5. switch the branch onto the new release tag, try to figure out a clean way to do this:
  - the goal is to apply Tiny's git commits on top of the latest release tag
  - don't switch to a new branch, the goal is to do this on branch `release`
  - previously I use the following method: create a new branch, cherry pick Tiny's commits with squash, delete the old branch, rename the branch
  - there might be better and cleaner way to do this
  - if there're more than 1 Tiny's commit, squash them into 1 commit
  - verify git history, it should be on `release`, one commit ahead of oai's release tag
  - once you have a stable workflow for this task, add/update MEMORY to record in detail what command you use
6. do a cargo release build:
  - inside `codex-rs`
  - use a containerized environment, a `Dockerfile` is provided
  - check for existing image, preferred name `codex-dev:latest`, rebuild to ensure image is in sync
  - map directories so we can get the artifacts back
  - do a clean first
  - the build takes very long, use `podman run -d ...` and redirect to a log file that is accessible on host
  - use `cargo build -j 2 ...` to avoid OOM.
  - the build might be killed by OOM killer. retry build if that happens but without clean to preserve built crates
  - the most important artifact is the `codex` executable, verify on host `.../codex --version` has expected output
  - if you encounter some issue and later resolve it, add/update MEMORY to record in detail what command you use
7. verify the podman containers you use are cleaned after the build, make sure you clean all containers if the build succeeds
8. verify git status. there could be temporary changes like `Cargo.lock` during build, consider force checkout
9. do a MEMORY consolidation, make sure to reflect only the latest status in MEMORY. keep the latest successful command/task recording for reference
10. report your task done

## Notes
- `scratch/` is ignored, you can use this folder for any notes, temporary files, etc
- `podman` is available on this host
