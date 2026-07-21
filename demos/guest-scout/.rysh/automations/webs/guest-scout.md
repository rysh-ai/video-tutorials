---
description: Discover potential podcast guests on YouTube, scoped to a topic.
  Discovery-only (never comments/subscribes/likes); saves a reviewed shortlist.
  Swap url + web_profile to a logged-in profile (e.g. ig-podcast via
  `##web headless login ig-podcast`) to scout Instagram like the blog recipe.
web_profile: guest-scout
url: https://www.youtube.com/
args: [topic]                  # run as: ##auto web run guest-scout tango
output_dir: guest-scout/results
loop:
  do:                          # the INNER loop -- one working session
    interval: 30
    max_iterations: 120
    max_duration: 5m
    auto_continue: true
    budget:
      size: 15p                # 15 pages = 15,000 tokens, hard ceiling
      watch:
        takeover_when: 80      # at 80% consumed, switch to the wrap-up leg
        takeover_prompt: >
          The discovery budget is used up - stop browsing now. Save the
          shortlist as-is, mark it PARTIAL at the top, print the file path
          and what to cover next time.
  while:                       # the OUTER loop -- repeat sessions until the GOAL holds
    enabled: true
    max_iterations: 3
    max_duration: 20m
    budget: 60p
    prompts:
      until: >
        The saved shortlist contains at least 8 strong candidates, each with
        a channel name, a why-they-fit line, an approximate subscriber count,
        and a link to one relevant video - with no duplicate channels.
      iterate_with: >
        Continue scouting for podcast guests about {{args}}, same rules as
        before (discovery only; stop on any login wall or rate limit). The
        current shortlist is seeded above: find NEW candidates it is missing,
        merge, and save back to the same file.
---

You are browsing YouTube looking for potential podcast GUESTS about: **{{args}}**.

If **{{args}}** is empty, ask me which topic to scout and stop - do not guess.

This is **discovery only** - do NOT comment, subscribe, like, or sign in. Just
read public pages. If you hit a login wall, captcha, or rate-limit notice: STOP
immediately and report it.

Method: search YouTube for the topic, open promising channels, check their
recent uploads and about pages. Prefer creators who speak well on camera,
upload regularly, and clearly know the topic.

For each candidate collect: channel name, why-they-fit (one line), approximate
subscriber count, one relevant video (title + link), and any public contact
hint from the about page (or "none"). Aim for 6-10 per session.

Save the shortlist as a markdown table to {{output_dir}}.
