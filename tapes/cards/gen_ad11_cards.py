#!/usr/bin/env python3
"""Title + end cards for ad11 (SecretNAT). 1920x1080, Catppuccin Mocha."""
import os
from PIL import Image, ImageDraw, ImageFont

W, H = 1920, 1080
FONTDIR = os.path.expanduser("~/Library/Fonts")
OUT = os.path.dirname(os.path.abspath(__file__))
BG = (30, 30, 46); TEXT = (205, 214, 244); TEAL = (148, 226, 213)
MUTED = (127, 132, 156); GREEN = (166, 227, 161)

def f(name, s): return ImageFont.truetype(os.path.join(FONTDIR, name), s)
XB = "JetBrainsMonoNerdFont-ExtraBold.ttf"; BD = "JetBrainsMonoNerdFont-Bold.ttf"
MD = "JetBrainsMonoNerdFont-Medium.ttf"

def center(d, y, txt, fnt, fill):
    w = d.textlength(txt, font=fnt)
    d.text(((W-w)/2, y), txt, font=fnt, fill=fill)

# Title card
img = Image.new("RGB", (W, H), BG); d = ImageDraw.Draw(img)
center(d, 330, "SecretNAT", f(BD, 44), TEAL)
center(d, 430, "THE SECRET THAT", f(XB, 96), TEXT)
center(d, 540, "NEVER LEAVES YOUR MACHINE", f(XB, 96), TEAL)
center(d, 700, "reversible secret translation · on by default", f(MD, 40), MUTED)
img.save(os.path.join(OUT, "title-ad11.png")); print("title-ad11.png")

# End card
img = Image.new("RGB", (W, H), BG); d = ImageDraw.Draw(img)
d.rectangle([0, 0, 14, H], fill=TEAL)
center(d, 300, "Your secrets stay yours.", f(XB, 88), TEAL)
center(d, 410, "Your AI still does the work.", f(XB, 72), TEXT)
center(d, 580, "rysh.ai/design-partner", f(BD, 56), TEXT)
center(d, 690, "onboarding design partners now", f(MD, 38), MUTED)
center(d, 760, "built on Claude · self-hostable · in-memory only", f(MD, 32), MUTED)
img.save(os.path.join(OUT, "end-ad11.png")); print("end-ad11.png")
