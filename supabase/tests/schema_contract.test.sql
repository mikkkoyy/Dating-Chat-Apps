begin;
create extension if not exists pgtap with schema extensions;
select plan(25);

select has_table('public', 'profiles', 'profiles table exists');
select has_table('public', 'profile_private', 'private birth-date table exists');
select has_table('public', 'profile_photos', 'profile photo table exists');
select has_table('public', 'interests', 'interest catalogue exists');
select has_table('public', 'user_interests', 'user interest join table exists');
select has_table('public', 'likes', 'likes table exists');
select has_table('public', 'matches', 'matches table exists');
select has_table('public', 'conversations', 'conversations table exists');
select has_table('public', 'conversation_members', 'conversation members table exists');
select has_table('public', 'messages', 'messages table exists');
select has_table('public', 'user_blocks', 'blocks table exists');
select has_table('public', 'user_reports', 'reports table exists');

select has_column('public', 'profiles', 'id', 'profile auth id exists');
select has_column('public', 'profiles', 'username', 'profile username exists');
select has_column('public', 'profile_private', 'birth_date', 'birth date is isolated');
select has_column('public', 'profile_photos', 'photo_path', 'photos store private paths');
select has_column('public', 'messages', 'read_at', 'message read timestamp exists');

select ok((select relrowsecurity from pg_class where oid = 'public.profiles'::regclass), 'profiles RLS enabled');
select ok((select relrowsecurity from pg_class where oid = 'public.profile_private'::regclass), 'private profile RLS enabled');
select ok((select relrowsecurity from pg_class where oid = 'public.messages'::regclass), 'messages RLS enabled');
select ok((select relrowsecurity from pg_class where oid = 'public.matches'::regclass), 'matches RLS enabled');
select ok(exists (select 1 from pg_policies where schemaname = 'public' and tablename = 'messages' and policyname = 'messages_insert_as_self'), 'message sender policy exists');
select ok(exists (select 1 from pg_policies where schemaname = 'public' and tablename = 'user_reports' and policyname = 'user_reports_read_reporter'), 'reporter-only read policy exists');
select is((select count(*)::integer from information_schema.role_table_grants where table_schema = 'public' and table_name in ('matches', 'conversations', 'conversation_members') and grantee = 'authenticated' and privilege_type in ('INSERT', 'UPDATE', 'DELETE')), 0, 'clients cannot write matches or provision conversations');
select ok(exists (select 1 from storage.buckets where id = 'profile-photos' and public = false), 'profile photo bucket remains private');

select * from finish();
rollback;
