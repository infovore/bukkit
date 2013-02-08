# Bukkit

Bukkit is an ephemeral to-do list for Little Printer. You text things to your Bukkit, and they appear on a print-out…

…once. Then, they're gone, unless you add them again. Point being: it's a way to get things onto paper, fast.

## Software

Look, it's a Rails app. `bundle` away. It's designed to be hosted on Heroku/run with Foreman. It has ~0 special requirements, other than a .env file containing three environment variables: `TWILIO_SID`, `TWILIO_AUTH`, and `TWILIO_NUMBER`. Bet you can't guess what they are.