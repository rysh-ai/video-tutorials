# Narration Guide

Tips, tone, and best practices for voiceover recording across all 50 video stories.

---

## Voice & Tone

### Character
- **Confident but casual** -- you're explaining to a smart colleague, not lecturing.
- **Concise** -- every word earns its place. Cut filler: "basically", "actually", "so yeah".
- **Direct** -- lead with the verb. "Type rysh." not "What you want to do is type rysh."
- **Enthusiastic without hype** -- genuine excitement, not marketing-speak.

### Pace
- **Normal speech**: 140-160 words per minute.
- **Key moments**: Slow down to 100-120 WPM when explaining something critical.
- **Pauses**: 1-2 second pause after showing output. Let the viewer read.
- **Never rush** -- if the story is too long, cut content, don't speed up.

### Pronunciation Guide

| Term | Pronunciation |
|------|--------------|
| Rysh | "rish" (rhymes with "dish") |
| NATS | "nats" (one syllable) |
| PTY | "P-T-Y" (spell it out) |
| TUI | "T-U-I" (spell it out) |
| CLI | "C-L-I" (spell it out) |
| vt10x | "V-T-ten-X" |
| JetStream | "jet stream" (two words) |
| proto.actor | "proto dot actor" |
| TOML | "tom-ul" |
| YAML | "yam-ul" |
| ANSI | "an-see" |
| Gin | "jin" |
| GORM | "gorm" (rhymes with "form") |
| Capacitor | "kuh-PASS-itor" |
| WebSocket | "web socket" (two words) |
| xterm | "ex term" |

---

## Script Structure

Every story follows this pattern:

### 1. Hook (0-3 seconds)
- One punchy sentence.
- A question, a bold claim, or a surprising fact.
- Examples:
  - "What if every terminal pane was an autonomous AI agent?"
  - "One command to install. Every platform."
  - "Your AI agent has 35 tools."

### 2. Setup (3-8 seconds)
- Brief context: what are we about to see?
- One or two sentences max.

### 3. Demo (8-80% of the story)
- Show the feature step by step.
- Narrate what you're doing and why.
- Every action has a verbal companion:
  - **Before**: "Let's create a new tab."
  - **During**: (type `Ctrl+T`, press `n`)
  - **After**: "There's our new tab."

### 4. Takeaway (last 3-5 seconds)
- One sentence. Memorable.
- Restate the hook or answer the question.
- End card with the takeaway text.

---

## Recording Tips

### Before Recording
1. Read the script out loud twice before hitting record.
2. Mark emphasis words in bold: "It's not just a terminal. It's an **AI workspace**."
3. Practice the typing sequences -- fumbling kills pacing.
4. Have a glass of water handy.

### During Recording
1. **Stand up** if possible -- it improves vocal energy.
2. **Smile** while speaking -- it changes your tone, even on audio-only.
3. **Point to the screen** mentally -- describe what the viewer should look at.
4. If you make a mistake, pause 2 seconds, then restart the sentence. Edit later.
5. Don't say "um" or "uh" -- just pause silently instead.

### After Recording
1. Listen back at 1x speed before editing.
2. Cut dead air (pauses over 2 seconds).
3. Cut false starts and restarts.
4. Normalize to -14 LUFS for YouTube.
5. Add 0.5s of silence at the start and end.

---

## Narration Patterns

### Describing Actions
Use present tense, imperative voice:
- "Type `rysh`" (not "Now we're going to type rysh")
- "Press Ctrl+P" (not "What I'm doing here is pressing Ctrl+P")
- "The output shows three panes" (not "As you can see, the output is showing us three panes")

### Explaining Concepts
Lead with what, then why:
- "Double-Escape switches modes. Each mode has its own prompt character, output buffer, and history."
- Not: "The reason we have different modes is because..."

### Transitions Between Scenes
- "Next..." / "Now let's..."
- "That's tabs. Now panes."
- Avoid: "Moving on to the next topic which is..."

### Referring to UI Elements
- "The border highlights when a pane is focused."
- "The footer shows the current mode."
- "The prompt character changes from greater-than to less-than."
- Don't say "the thing at the bottom" -- name it.

---

## Per-Group Tone Adjustments

| Group | Tone |
|-------|------|
| 1. Getting Started | Welcoming, excited, "let me show you something cool" |
| 2. Multiplexer Basics | Practical, hands-on, "here's how you do it" |
| 3. Input Modes | Conceptual clarity, "this is the key insight" |
| 4. Interactive Terminal | Impressive, "yes, this really works" |
| 5. AI Agentic Features | Power-user, "here's what sets Rysh apart" |
| 6. Autonomous Agents | Future-forward, "imagine having a team of AI workers" |
| 7. Humanoids | Boundary-pushing, "your AI talks to the outside world" |
| 8. Collaboration | Team-oriented, "work together in real time" |
| 9. Pipelines | Orchestration-focused, "automate your workflow" |
| 10. Web Terminal | Convenience, "access from anywhere" |
| 11. Mobile App | On-the-go, "your workspace in your pocket" |
| 12. Chrome Extension | Integration, "your browser is now a pane" |
| 13. Server & Billing | Professional, "production-ready infrastructure" |

---

## Common Mistakes to Avoid

1. **Over-explaining** -- viewers can see the screen. Don't describe what's visually obvious.
2. **Reading code aloud** -- say what the code does, not what it says.
3. **Saying "simply"** -- nothing is simple if you have to say it is.
4. **Technical jargon without context** -- explain "JetStream KV" as "persistent storage" first, then name-drop.
5. **Monotone** -- vary pitch and pace. Key moments get emphasis.
6. **Apologizing** -- "This might seem complicated but..." Just explain it clearly.
7. **Future tense** -- "You will see" -> "Watch this" or just show it.
