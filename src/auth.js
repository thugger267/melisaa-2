import { supabase } from './supabase.js';

export async function register(username, password) {
  const { data, error } = await supabase.auth.signUp({
    email: `${username}@dietsystem.local`,
    password: password,
    options: {
      data: { username }
    }
  });

  return { data, error };
}

export async function login(username, password) {
  const { data, error } = await supabase.auth.signInWithPassword({
    email: `${username}@dietsystem.local`,
    password: password
  });

  return { data, error };
}

export async function logout() {
  const { error } = await supabase.auth.signOut();
  return { error };
}

export async function getCurrentUser() {
  const { data: { user } } = await supabase.auth.getUser();
  return user;
}

export function onAuthStateChange(callback) {
  return supabase.auth.onAuthStateChange((event, session) => {
    callback(event, session);
  });
}
