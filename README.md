# Counting

Shared counters with history. Rails web app + Expo React Native client.

* Web: Rails 8.1, Ruby 3.2.1, SQLite, Hotwire (Turbo broadcasts), Tailwind, Devise + Google OAuth
* Mobile: `counting-rn/` (Expo ~50, React Native 0.73)

## What it does

* `Counter` with `up` / `down` / `reset`, per-change `History` entries (`change`, `comment`, `created_by`) — `app/models/counter.rb:11`
* Authenticated root at `counters#index`, unauthenticated root at `home#auto_login` — `config/routes.rb:13`
* Live updates via `broadcasts_to :counters`

## Run

```sh
bundle install
bin/rails db:setup
bin/dev
```

Mobile:

```sh
cd counting-rn
npm install
npm start
```
