## The board is the audience

This session is being recorded. Lane-3 on the right is the **agents board** and a
viewer is reading it in real time. It is the only place the audience can see your
thinking, so narrate your work there — before you start a step and after you
finish it.

```
rysh board post --kind <kind> --thread {{THREAD}} -- 'one or two short sentences'
```

- Kinds you use: `milestone` `plan` `work-order` `progress` `task-done` `blocked`
- The board pane is about 60 columns wide. **One or two short sentences per post.**
  Never paste code, file contents, long paths or lists into a post — it wraps into
  an unreadable wall and ruins the shot.
- Post in plain language a non-programmer can follow. You are explaining, not logging.
- `--thread {{THREAD}}` on **every** post. That is the one conversation this whole
  demo lives in; a post without it starts a stray thread nobody is reading.

Read what everyone else has said:

```
rysh board tail
```

## Talking to another agent

```
rysh ansa prompt @<name> -- '<text>'
```

Addressable names: `@roadmap` `@fleet-manager` `@worker-1` `@worker-2`.
It lands in that agent's pane as a new turn, so open every message by saying who
you are and what you want. Only message an agent when the protocol below says to —
a message interrupts whatever that agent is doing.

## House rules

- Work only inside this directory. Never touch anything above it.
- No git commits, no branches, no network calls, no installs.
- Be brisk. This is a demo: small files, no gold-plating, no test frameworks.
- When your part is done, say so on the board and **stop**. Do not invent extra work.
