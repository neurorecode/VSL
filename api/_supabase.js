const { createClient } = require('@supabase/supabase-js');

function pickEnv(...names) {
  for (const name of names) {
    const value = process.env[name];
    if (value) return value;
  }
  return '';
}

function supabaseAdmin() {
  const url = pickEnv('SUPABASE_URL', 'NEXT_PUBLIC_SUPA_DB_SUPABASE_URL');
  const key = pickEnv(
    'SUPABASE_SERVICE_ROLE_KEY',
    'SUPA_DB_SUPABASE_SERVICE_ROLE_KEY',
    'SUPA_DB_SUPABASE_SECRET_KEY'
  );

  if (!url || !key) {
    throw new Error(
      'Missing Supabase environment variables. Set NEXT_PUBLIC_SUPA_DB_SUPABASE_URL and SUPA_DB_SUPABASE_SERVICE_ROLE_KEY in Vercel.'
    );
  }

  return createClient(url, key, { auth: { persistSession: false } });
}

module.exports = { supabaseAdmin };
