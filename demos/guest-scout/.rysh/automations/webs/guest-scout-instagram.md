---
description: Discover potential podcast guests on Instagram, scoped to a topic.
  Discovery-only (never messages/follows/likes); saves a reviewed shortlist.
  Requires a persistent, pre-authenticated browser profile - log in once by hand
  via `##web headless login ig-podcast https://www.instagram.com/`.
web_profile: ig-podcast        # persistent, pre-authenticated browser profile
url: https://www.instagram.com/
args: [topic]                  # run as: ##auto web run guest-scout-instagram tango
output_dir: guest-scout/results
loop:
  do:                          # the INNER loop -- one working session
    interval: 30
    max_iterations: 300
    max_duration: 7m
    auto_continue: true
    budget:
      size: 3b                 # 3 "books" = 600k tokens, hard ceiling
      watch:
        takeover_when: 90      # at 90% consumed, switch to the wrap-up leg
        takeover_prompt: >
          The discovery budget is used up - stop browsing now. Save the
          shortlist as-is, mark it PARTIAL at the top, print the file path
          and what to cover next time.
  while:                       # the OUTER loop -- repeat sessions until the GOAL holds
    enabled: true
    max_iterations: 5
    max_duration: 40m
    budget: 15b
    prompts:
      until: >
        The saved shortlist contains at least 12 strong candidates, each with
        a handle, a why-they-fit line, and a public contact or an explicit
        "on-platform only" note - with no duplicate handles.
      iterate_with: >
        Continue scouting for podcast guests about {{args}}, same rules as
        before (discovery only; stop on any login wall or rate limit). The
        current shortlist is seeded above: find NEW candidates it is missing,
        merge, and save back to the same file.
---

You are browsing Instagram looking for potential podcast GUESTS about: **{{args}}**.

If **{{args}}** is empty, ask me which topic to scout and stop - do not guess.

This is **discovery only** - do NOT message, follow, like, or DM. Just read
public pages. If you hit a login wall, captcha, or rate-limit notice: STOP
immediately and report it.

For each candidate collect: handle, why-they-fit, follower count, public
contact (or "none"), and one post that makes them relevant. Aim for 8-12.

When done, write the list as Markdown to {{output_dir}}/<topic>-<date>.md
and print the saved file path here.
