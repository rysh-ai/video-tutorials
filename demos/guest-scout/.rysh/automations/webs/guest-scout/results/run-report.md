# Run report — ##auto web "guest-scout"

- target   : 951f71be-9481-4c5c-b4e0-6945a5406351
- started  : 2026-07-17T13:17:32+01:00
- ended    : 2026-07-17T13:22:39+01:00 (5m8s)
- end cause: unfulfilled: the 3-pass cap is reached
- loop plan: until "The saved shortlist contains at least 8 strong candidates, e..." — up to 3 passes, time total 20m0s (6m40s/pass), token total 60000 (20000/pass)
- per pass : ~120 steps / 6m40s / 20000 tokens

| pass | verdict | judge's reason |
|---|---|---|
| 1 | unfulfilled | Only 3 candidates are fully vetted with all required fields, and none of the entries (not even the vetted ones) include an actual link to a relevant video, which is explicitly marked as pending. |
| 2 | unfulfilled | Only 3 candidates are fully vetted (and one is missing its video link), while the remaining 12 are unvetted leads lacking video links, so fewer than 8 complete strong candidates exist. |
| 3 | unfulfilled | Only 3 fully vetted candidates have complete details (video link, subscriber count, why-fit) while the remaining 12 are unvetted leads missing video links, so fewer than 8 strong complete candidates exist. |
