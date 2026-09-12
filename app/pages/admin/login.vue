<template>
  <div class="min-h-screen bg-gradient-to-br from-green-600 to-emerald-800 flex items-center justify-center p-4">
    <div class="w-full max-w-sm">
      <!-- Logo -->
      <div class="text-center mb-8">
        <div class="w-16 h-16 bg-white rounded-2xl flex items-center justify-center mx-auto mb-4 shadow-lg">
          <UIcon name="i-heroicons-academic-cap" class="w-9 h-9 text-green-600" />
        </div>
        <h1 class="text-2xl font-extrabold text-white">Admin Panel</h1>
        <p class="text-green-200 text-sm mt-1">Pondok Pesantren Darul Maarif</p>
      </div>

      <!-- Form Card -->
      <div class="bg-white rounded-3xl shadow-xl p-6">
        <h2 class="font-extrabold text-gray-800 text-lg mb-6 text-center">Masuk ke Dashboard</h2>
        
        <UAlert v-if="errorMsg" icon="i-heroicons-exclamation-triangle" color="red" variant="soft" :title="errorMsg" class="mb-4" />

        <form class="space-y-4" @submit.prevent="login">
          <UFormGroup label="Email" name="email">
            <UInput v-model="email" type="email" placeholder="admin@darulmaarif.sch.id" icon="i-heroicons-envelope" size="lg" autocomplete="username" required />
          </UFormGroup>

          <UFormGroup label="Password" name="password">
            <UInput v-model="password" type="password" placeholder="••••••••" icon="i-heroicons-lock-closed" size="lg" autocomplete="current-password" required />
          </UFormGroup>

          <UButton type="submit" block color="green" size="lg" :loading="loading" class="rounded-xl font-bold mt-2" trailing-icon="i-heroicons-arrow-right">
            Masuk
          </UButton>
        </form>
      </div>

      <p class="text-center text-green-200/70 text-xs mt-6">
        Portal Pesantren Darul Maarif © 2024
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

definePageMeta({ layout: false, middleware: 'auth' })

const supabase = useSupabaseClient()
const email = ref('')
const password = ref('')
const loading = ref(false)
const errorMsg = ref('')

const login = async () => {
  loading.value = true
  errorMsg.value = ''
  const { error } = await supabase.auth.signInWithPassword({
    email: email.value,
    password: password.value
  })
  if (error) {
    errorMsg.value = 'Email atau password salah. Silakan coba lagi.'
  } else {
    navigateTo('/admin')
  }
  loading.value = false
}
</script>
