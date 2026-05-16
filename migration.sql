-- Run this in Supabase SQL editor before deploying the sync service.

create table if not exists boostcamp_workouts (
  boostcamp_id   text        primary key,
  logged_at      timestamptz not null,
  workout_name   text,
  classification text        not null,
  muscles_json   jsonb       not null default '[]',
  exercises_json jsonb       not null default '[]',
  raw_json       jsonb,
  created_at     timestamptz not null default now()
);

-- Index for fast weekly queries
create index if not exists idx_boostcamp_workouts_logged_at
  on boostcamp_workouts (logged_at desc);

-- Also fix habit_logs table if you haven't already:
alter table habit_logs
  add column if not exists created_at timestamptz default now();

alter table habit_logs
  drop constraint if exists habit_logs_habit_id_date_unique;

alter table habit_logs
  add constraint habit_logs_habit_id_date_unique
  unique (habit_id, date);
