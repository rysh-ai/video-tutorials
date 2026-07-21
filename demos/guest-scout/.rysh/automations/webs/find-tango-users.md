---
description: Discover candidate students for a tango school on YouTube.
  Find tango schools/instructors, then collect the users who replied in their
  video comments as potential leads. Discovery-only (never comments/subscribes/
  likes/signs in); saves a reviewed shortlist. Swap url + web_profile to a
  logged-in profile (e.g. ig-tango via `##web headless login ig-tango`) to
  scout Instagram the same way.
web_profile: find-tango-users
url: https://www.youtube.com/
args: [city]                   # run as: ##auto web run find-tango-users "buenos aires"
output_dir: find-tango-users/results
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
        The saved shortlist contains 10 candidate students, each with a
        username, the tango school/video they engaged with, a short quote or
        summary of their comment, and (if public) a profile/channel link - with
        no duplicate usernames. Once 10 unique candidates are saved, STOP the
        automation.
      iterate_with: >
        Continue finding candidate tango students near {{args}}, same rules as
        before (discovery only; stop on any login wall or rate limit). The
        current shortlist is seeded above: open MORE tango schools/videos and
        find NEW commenters it is missing, merge, and save back to the same file.
---

You are browsing YouTube looking for CANDIDATE STUDENTS for a tango school
located near: **{{args}}**.

If **{{args}}** is empty, ask me which city/region to scout and stop - do not
guess.

This is **discovery only** - do NOT comment, reply, subscribe, like, message,
or sign in. Just read public pages. If you hit a login wall, captcha, or
rate-limit notice: STOP immediately and report it.

Method:
1. Search YouTube for tango schools, academies, and instructors near {{args}}
   (try queries like "tango classes {{args}}", "escuela de tango {{args}}",
   "tango lessons {{args}}").
2. Open the most relevant tango school / instructor channels and their recent
   videos (classes, milonga clips, tutorials, promos).
3. Read the video comments and collect the USERS who replied there - these are
   people already interested in tango and are potential students.

Prefer commenters who show genuine interest: asking about classes, prices,
schedules, locations, saying they want to learn, or engaging enthusiastically.
Skip spam, bots, and pure emoji-only comments.

For each candidate collect: username/handle, the tango school + video where you
found them, a short quote or summary of their comment (why they look like a
lead), and any public profile/channel link (or "none").

The goal is exactly 10 candidate students total. Stop as soon as the shortlist
reaches 10 unique candidates - do not collect more.

Save the shortlist as a markdown table to {{output_dir}}.
